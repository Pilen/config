;;______________________________________________________________________________
;;
;;
;π                               FUNCTIONALITY
;;
;;______________________________________________________________________________

(defun my-print-source-code (&optional file)
  (interactive)
  (if(buffer-file-name)
      (progn
        (unless file (setq file (buffer-file-name)))
        (start-process "my-print-source-code" nil "print-source-code" file))
    (let ((file (make-temp-file (file-name-sans-extension (buffer-name)) nil (file-name-extension (buffer-name)))))
      (write-region (point-min) (point-max) file)
      (message file)
      (call-process "print-source-code" nil nil nil file)
      (delete-file file)
      )))

(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (interactive)
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))
(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

(defun query-replace-with-region ()
  (interactive)
  (if (not (use-region-p))
    (call-interactively 'query-replace)

    (let ((text (buffer-substring-no-properties (region-beginning) (region-end))))
      (deactivate-mark)
      (goto-char (region-beginning))
      (query-replace text (query-replace-read-to text "Query replace" nil)))))

(defun reindent-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (whitespace-cleanup))
(defun reindent-region ()
  (interactive)
  (let ((start (point-min)) (end (point-max)))
    (when (and transient-mark-mode mark-active)
      (setq start (region-beginning)
            end (region-end)))
    (save-excursion
      (delete-trailing-whitespace start end)
      (indent-region start end nil)
      (untabify start end)
      (whitespace-cleanup-region start end)
      )))

(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))

;;
;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (&optional new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  ;; (interactive "sNew name: ")
  (interactive)
  (unless new-name
    (setq new-name (read-string "New Name: " (buffer-file-name))))
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name t)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
(defalias 'rfb 'rename-file-and-buffer)

;; Never understood why Emacs doesn't have this function, either.
;;
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))

    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (copy-file filename newname 1)
      (delete-file filename)
      (set-visited-file-name newname)
      (set-buffer-modified-p nil)
      t)))


(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Toggles from 3 cases: UPPER CASE, lower case, Title Case,
in that cyclic order."
  (interactive)
  (let (pos1 pos2 (deactivate-mark nil) (case-fold-search nil))
    (if (and transient-mark-mode mark-active)
        (setq pos1 (region-beginning)
              pos2 (region-end))
      (setq pos1 (car (bounds-of-thing-at-point 'word))
            pos2 (cdr (bounds-of-thing-at-point 'word))))

    (when (not (eq last-command this-command))
      (save-excursion
        (goto-char pos1)
        (cond
         ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps") )
         ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps") )
         (t (put this-command 'state "all lower") )
         )
        )
      )

    (cond
     ((string= "all lower" (get this-command 'state))
      (upcase-initials-region pos1 pos2) (put this-command 'state "init caps"))
     ((string= "init caps" (get this-command 'state))
      (upcase-region pos1 pos2) (put this-command 'state "all caps"))
     ((string= "all caps" (get this-command 'state))
      (downcase-region pos1 pos2) (put this-command 'state "all lower"))
     )
    )
  )

(defun toggle-letter-case-forward ()
  (interactive)
  (let ((case-fold-search nil))
    (cond
     ((looking-at "[[:lower:]]") (upcase-region (point) (1+ (point))))
     ((looking-at "[[:upper:]]") (downcase-region (point) (1+ (point)))))))


(defun toggle-letter-case-programming ()
  (interactive)
  (save-excursion
    (let* ((case-fold-search nil)
           (bound-start nil)
           (bound-end nil)
           )
      (while (looking-at "[_a-zæøåA-ZÆØÅ0-9]")
        (forward-char -1))
      (forward-char 1)
      (setq bound-start (point))
      (search-forward-regexp "[_a-zæøåA-ZÆØÅ0-9]+")
      (setq bound-end (point))
      ;; (setq bound-end -1)
      (goto-char bound-start)
      (cond
       ;; snake_case -> smallCase
       ((and (looking-at "\\(_*\\)\\([a-zæøå0-9]+\\(_[a-zæøå0-9]+\\)+\\)\\(_*\\)")
             (= (match-end 0) bound-end))
        (message "snake_case -> smallCase")
        (let* ((start (match-end 1))
               (end (match-beginning 4))
               (words (split-string (match-string-no-properties 2) "_"))
               (first (car words))
               (rest (cdr words))
               )
          (message "%s %s" start end)
          (goto-char start)
          (delete-region start end)
          (insert first)
          (insert (mapconcat #'upcase-initials rest ""))
          ))
       ;; UPPER_CASE -> snake_case
       ;; Positioned above test for pascal case
       ((and (looking-at "\\(_*\\)\\([A-ZÆØÅ0-9]+\\(_[A-ZÆØÅ0-9]+\\)*\\)\\(_*\\)")
             (= (match-end 0) bound-end))
        (message "UPPER_CASE -> snake_case")
        (let* ((start (match-end 1))
               (end (match-beginning 4)))
          (downcase-region start end)
          ))
       ;; smallCase -> PascalCase
       ((and (looking-at "\\(_*\\)\\([a-zæøå]\\)[a-zæøå0-9A-ZÆØÅ]*\\(_*\\)")
             (= (match-end 0) bound-end))
        (message "smallCase -> PascalCase")
        (let* ((start (match-end 1))
               (letter (match-string-no-properties 2)))
          (goto-char start)
          (delete-char 1)
          (insert (upcase letter))
          ))
       ;; PascalCase -> UPPER_CASE
       ((and (looking-at "\\(_*\\)\\([A-ZÆØÅ][a-zæøå0-9A-ZÆØÅ]+\\)\\(_*\\)")
             (= (match-end 0) bound-end))
        (message "PascalCase -> UPPER_CASE")
        (let* ((start (match-end 1))
               (end (match-beginning 3))
               (words (match-string-no-properties 2))
               (n 0))
          (goto-char start)
          (delete-region start end)
          (while (string-match "\\([A-ZÆØÅ]\\)\\([a-zæøå0-9]*\\)" words n)
            (insert (match-string 1 words))
            (insert (upcase (match-string 2 words)))
            (insert "_")
            (setq n (match-end 0))
            )
          (delete-char -1)
          ))
       (t
        (message "fallback to toggle-letter-case")
        (toggle-letter-case)
        )))))





(defun shell-command-on-region-replace (start end command)
  "Run shell-command-on-region interactivly replacing the region in place"
  (interactive (let (string)
         (unless (mark)
           (error "The mark is not set now, so there is no region"))
         ;; Do this before calling region-beginning
         ;; and region-end, in case subprocess output
         ;; relocates them while we are in the minibuffer.
         ;; call-interactively recognizes region-beginning and
         ;; region-end specially, leaving them in the history.
         (setq string (read-from-minibuffer "Shell command on region: "
                                            nil nil nil
                                            'shell-command-history))
         (list (region-beginning) (region-end)
               string)))
  (shell-command-on-region start end command t t))


(defun yank-or-pop (&optional arg)
  (interactive "*p")
  (if (not (eq last-command 'yank))
      (if arg
          (yank arg)
        (yank))
    (setq this-command 'yank)
    (if arg
        (yank-pop arg)
      (yank-pop))))

(defun my-kill-ring-save-buffer ()
  (interactive)
  (kill-ring-save (point-min) (point-max))
  (message "Copied buffer"))

(defun my-kill-whole-line ()
  (interactive)
  (setq last-command nil)
  (kill-whole-line))

(defun horizontal-recenter ()
  "make the point horizontally centered in the window"
  (interactive)
  (let ((mid (/ (window-width) 2))
        (line-len (save-excursion (end-of-line) (current-column)))
        (cur (current-column)))
    (if (< mid cur)
        (set-window-hscroll (selected-window)
                            (- cur mid)))))

(defun my-find-file-other-window (filename &optional wildcards)
  (interactive
   (find-file-read-args "Find file in other window: "
                        (confirm-nonexistent-file-or-buffer)))
  (let ((value (find-file-noselect filename nil nil wildcards)))
    (if (listp value)
        (progn
          (setq value (nreverse value))
          (cons (switch-to-buffer-other-window (car value))
                (mapcar 'switch-to-buffer (cdr value))))

      (let* ((windows (car (gethash (selected-frame) window-numbering-table)))
             (number-of-windows (count 'nil windows :test-not 'eq))
             (window-number (window-numbering-get-number))

             (chosen-window (loop for i from 1 to number-of-windows
                                  if (not (or (= i window-number) (window-dedicated-p (elt windows i)))) return i)))

             (if (null chosen-window)
                 (switch-to-buffer-other-window value)
               (save-excursion
                 (select-window-by-number chosen-window)
                 (message default-directory)
                 (find-file filename)))))))

(defun local-set-minor-mode-key (mode key def)
  "Overrides a minor mode keybinding for the local
   buffer, by creating or altering keymaps stored in buffer-local
   `minor-mode-overriding-map-alist'."
  (let* ((oldmap (cdr (assoc mode minor-mode-map-alist)))
         (newmap (or (cdr (assoc mode minor-mode-overriding-map-alist))
                     (let ((map (make-sparse-keymap)))
                       (set-keymap-parent map oldmap)
                       (push `(,mode . ,map) minor-mode-overriding-map-alist)
                       map))))
    (define-key newmap key def)))

(defun increment-number-at-point (&optional amount)
  "Increment number found at point"
  (interactive)
  (save-excursion
    (save-match-data
      (skip-chars-backward "0123456789")
      (if (looking-at "[0123456789]+")
          (replace-match (number-to-string
                          (+ (if (null amount)
                                 1
                               amount)
                             (string-to-number (match-string 0)))))
        (error "No number at point")))))

(defun decrement-number-at-point (&optional amount)
  "Decrement number found at point"
  (interactive)
  (increment-number-at-point (- (if (null amount)
                                    1
                                  amount))))

(defun fill-paragraph-from-current-line ()
  "Fill current paragraph starting from current line"
  (interactive)
  (let ((start (line-beginning-position))
        end)
    (save-excursion
      (forward-paragraph)
      (setq end (point)))
    (fill-region start end)))


;;; Made by Søren Pilgård
(defun transpose-up ()
  "Move current line up"
  (interactive)
  (let ((column-number (- (point) (point-at-bol))))
    (my-kill-whole-line)
    (forward-line -1)
    (yank)
    (unless (= (char-before) ?\n) (insert "\n"))
    (setq kill-ring (cdr kill-ring))
    (forward-line -1)
    (move-to-column column-number)))

;;; Made by Søren Pilgård
(defun transpose-down ()
  "Move current line down"
  (interactive)
  (let ((column-number (- (point) (point-at-bol)))
        (line-number))
    (my-kill-whole-line)
    (setq line-number (line-number-at-pos))
    (forward-line 1)
    (when (= (line-number-at-pos) line-number)
      (insert "\n"))
    (yank)
    (setq kill-ring (cdr kill-ring))
    (end-of-line)
    (forward-line -1)
    (move-to-column column-number)))

(defun flipline ()
  "Flip a line around cursor
So the line with cursor |
abc|def
Becomes the line:
def|abc"
  (interactive)
  (kill-line)
  (move-beginning-of-line nil)
  (yank))

(defun new-indented-line ()
  "Insert a line below the current and indent it"
  (interactive)
  (end-of-line)
  (newline-and-indent))


(defun sudo-edit-current-file ()
  (interactive)
  (let ((pos (point)))
    (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer))))
    (goto-char pos)))

(defun revert-all-buffers ()
  "Revert all non-modified buffers associated with a file.
This is to update existing buffers after a Git pull of their underlying files."
  (interactive)
  (save-current-buffer
    (dolist (buffer (buffer-list))
      (set-buffer buffer)
      (unless (or (null (buffer-file-name)) (buffer-modified-p))
              (revert-buffer t t)
              (message "Reverted %s\n" (buffer-file-name))))))

(defun insert-current-date (&optional format)
  (interactive "Mformat: \n")
  (if (or (not format) (string-empty-p format))
      (setq format "%Y-%m-%d"))
  (insert (shell-command-to-string (concat "echo -n $(date +'" format "')"))))


(defun my-align-regexp-left ()
  (interactive)
  (align-regexp
   (region-beginning)
   (region-end)
   (concat (read-string "Align regex: ")
           "\\(\s+\\)")))
(defun my-align-regexp-right ()
  (interactive)
  (align-regexp
   (region-beginning)
   (region-end)
   (concat "\\(\s+\\)"
           (read-string "Align regex: ")))
    )
(defhydra my-align-hydra
  (:exit t)
  "Align"
  ("l" my-align-regexp-left "Align seperator left")
  ("r" my-align-regexp-right "Align seperator right")
  )

(require 'json)
(defun my-json-sort (point)
  "Sort JSON-like structure surrounding the point."
  (interactive "d")
  (let ((object-begin (nth 1 (syntax-ppss point)))
        (begin-point (point)))
    (when object-begin
      (goto-char object-begin)
      (forward-list)

      (with-current-buffer (current-buffer)
        (json-pretty-print-ordered object-begin (point))
        (indent-region object-begin (point)))

      (goto-char begin-point))))


(defun mean (&rest args)
  (/ (apply '+ args)
     (length args)))


(defun my-comment-box ()
  (interactive)
  (center-line)
  (save-excursion
    (beginning-of-line)
    (delete-char 2)
    (insert "/*")
    (end-of-line)
    (dotimes (_ (- fill-column (current-column) 2))
      (insert " "))
    (insert "*/")))


(defcustom smart-to-ascii
  '(("\x201C" . "\"")
    ("\x201D" . "\"")
    ("\x2018" . "'")
    ("\x2019" . "'")
    ("\x2013" . "-") ;; en-dash
    ("\x2014" . "-") ;; em-dash
    )
    ""
    :type '(repeat (cons (string :tag "Smart Character  ")
                         (string :tag "Ascii Replacement"))))

(defun smart-to-ascii (beg end)
  (interactive "r")
  (format-replace-strings smart-to-ascii nil beg end))

;; (defun my-smart-to-ascii ()
;;   (interactive)
;;   (let ((start (if (use-region-p) (region-beginning) (point-min)))
;;         (end (if (use-region-p) (region-end) (point-max)))
;;         (replace '(("‘" . "'")
;;                    ("‘" . "'"))))
;;     (dolist (pair replace)
;;       (goto-char start)
;;       (while (search-forward (car pair) end t)
;;         (replace-match (cdr pair))))))

(defun insert-thing (&optional arg)
  (interactive)
  (insert " ")
  (if (called-interactively-p)
      (eval-last-sexp t)
    (insert (prin1-to-string arg))))

;; (defun my-goto-last-change ()
;;   (interactive)
;;   (condition-case e
;;       (goto-last-change nil nil)
;;     (error (message "%s" (error-message-string e)))))



(defun my-describe-variable-full ()
  (interactive)
  (let ((print-level nil)
        (print-length nil))
    (call-interactively 'describe-variable))
  nil)
(define-key help-mode-map (kbd "f") 'my-describe-variable-full)


;; (defun my-yank-insert-rectangle  ()
;;   (interactive)
;;   (narrow-to-region (point) (point))
;;   (yank-rectangle)
;;   (widen))
(defun my-yank-insert-rectangle ()
    (interactive)
  (with-temp-buffer
    (yank-rectangle)
    (kill-region (point-min) (point-max)))
  (yank)
  )
(global-set-key (kbd "C-x r Y") 'my-yank-insert-rectangle)


(defun my-yank-as-rectangle ()
  (interactive)
  (with-temp-buffer
    (yank)
    (goto-char (point-min))
    (while (= (char-after) ?\n)
      (delete-char 1))
    (goto-char (point-max))
    (while (= (char-before) ?\n)
      (delete-char -1))
    (let* ((value (buffer-substring (point-min) (point-max)))
           (lines (split-string value "\n"))
           (lengths (mapcar 'length lines))
           (max (apply 'max lengths))
           (last (car (last lengths)))
           (difference (- max last)))
      (dotimes (i difference)
        (insert " "))
      (kill-rectangle (point-min) (point-max))))
  (yank-rectangle))
(global-set-key (kbd "C-x r C-y") 'my-yank-as-rectangle)

(defun my-end-or-beginning-of-buffer ()
  (interactive)
  (cond
   ((= (point) (point-max))
    (goto-char (point-min)))
   ((and (= (point) (point-min)) (eql (mark t) (point-min)))
    (goto-char (point-max)))
   ((= (point) (point-min))
    (goto-char (or (mark t) (point-max))))
   (t (push-mark) (goto-char (point-max)))
   ))


;;______________________________________________________________________________
;π CODE FOLDING
;;______________________________________________________________________________

(defun toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))

(defun cursor-selective-display ()
  "Activate selective display based on the column at point"
  (interactive)
  (set-selective-display
   (if selective-display
       nil
     (+ 1 (current-column)))))



(defun cypher-indent-line ()
  "Indent current line."
  (let (ctx (inhibit-modification-hooks t) (offset) pos
        (regexp "^\s*\\(CREATE\\|ORDER\\|MATCH\\|LIMIT\\|SET\\|SKIP\\|START\\|RETURN\\|WITH\\|WHERE\\|DELETE\\|FOREACH\\|//\\)"))

    (save-excursion
      (back-to-indentation)
      (setq pos (point))
      (setq ctx (cypher-block-context pos))
      (cond
       ((string-match-p regexp (thing-at-point 'line))
        (setq offset 0)
        )
       ((plist-get ctx :arg-inline)
        (setq offset (plist-get ctx :column))
        )
       ((re-search-backward regexp nil t)
        (goto-char (match-end 1))
        (skip-chars-forward "[:space:]")
        (setq offset (current-column))
        )
       (t
        (setq offset cypher-indent-offset))
       ))
    (when offset
      (let ((diff (- (current-column) (current-indentation))))
        (setq offset (max 0 offset))
        (indent-line-to offset)
        (if (> diff 0) (forward-char diff))
        )
      )
      ))

(defun my-backward-paragraph ()
  (interactive)
  (let ((start (point)))
    (backward-paragraph)
    (forward-char)
    (when (= (point) start)
      (backward-char)
      (backward-paragraph)
      (forward-char))))

(defun my-cypher-hook ()
  (setq beginning-of-defun-function (lambda (&optional arg) (my-backward-paragraph)))
  (setq end-of-defun-function (lambda (&optional arg) (forward-paragraph))))
(add-hook 'cypher-mode-hook 'my-cypher-hook)


(defun my-caddyfile-mode-hook ()
  (setq tab-width (default-value 'tab-width))
  (setq indent-tabs-mode (default-value 'indent-tabs-mode)))
(add-hook 'caddyfile-mode-hook #'my-caddyfile-mode-hook)
;; (remove-hook 'caddyfile-mode-hook #'my-caddyfile-mode-hook)

;;______________________________________________________________________________
;π LOCAL BACKGROUND
;;______________________________________________________________________________

(defun bufferlocal-background (background)
  (interactive)
  ;;Delete the old overlay, if any
  (remove-bufferlocal-background)
  ;;Set new overlay
  (let ((o (make-overlay (point-min) (point-max)
                         (current-buffer) nil t)))
    (overlay-put o 'face `(:background ,background))
    (overlay-put o 'buffer-local t)))

(defun remove-bufferlocal-background ()
  (interactive)
  (mapc (lambda (o)
          (when (overlay-get o 'buffer-local)
            (delete-overlay o)))
          (overlays-in (point-min) (point-max))))

;;______________________________________________________________________________
;π OVERLAYS
;;______________________________________________________________________________

(defun list-overlays-at (&optional pos)
  "Describe overlays at POS or point."
  (interactive)
  (setq pos (or pos (point)))
  (let ((overlays (overlays-at pos))
        (obuf (current-buffer))
        (buf (get-buffer-create "*Overlays*"))
        (props '(priority window category face mouse-face display
                          help-echo modification-hooks insert-in-front-hooks
                          insert-behind-hooks invisible intangible
                          isearch-open-invisible isearch-open-invisible-temporary
                          before-string after-string evaporate local-map keymap
                          field))
        start end text)
    (if (not overlays)
        (message "None.")
      (set-buffer buf)
      (erase-buffer)
      (dolist (o overlays)
        (setq start (overlay-start o)
              end (overlay-end o)
              text (with-current-buffer obuf
                     (buffer-substring start end)))
        (when (> (- end start) 13)
          (setq text (concat (substring text 1 10) "...")))
        (insert (format "From %d to %d: \"%s\":\n" start end text))
        (dolist (p props)
          (when (overlay-get o p)
            (insert (format " %15S: %S\n" p (overlay-get o p))))))
      (pop-to-buffer buf))))


;;______________________________________________________________________________
;π FONT LOCK FIX
;;______________________________________________________________________________
(setq my-font-lock-quick-fix--timer nil)
(defun my-font-lock-quick-fix ()
  (interactive)
  (when my-font-lock-quick-fix--timer (cancel-timer my-font-lock-quick-fix--timer))
  (setq my-font-lock-quick-fix--timer
        (run-with-idle-timer 3 t (lambda () (when (or (derived-mode-p 'prog-mode) (derived-mode-p 'text-mode)) (font-lock-fontify-buffer))))))
