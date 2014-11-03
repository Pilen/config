;;______________________________________________________________________________
;;
;;
;π                               FUNCTIONALITY
;;
;;______________________________________________________________________________



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

(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))

;;
;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn   (rename-file name new-name 1)   (rename-buffer new-name)        (set-visited-file-name new-name)        (set-buffer-modified-p nil))))))
(defalias 'rfb 'rename-file-and-buffer)

;; Never understood why Emacs doesn't have this function, either.
;;
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))

    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn         (copy-file filename newname 1)  (delete-file filename)  (set-visited-file-name newname)         (set-buffer-modified-p nil)     t))))


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
    (kill-whole-line)
    (forward-line -1)
    (yank)
    (setq kill-ring (cdr kill-ring))
    (forward-line -1)
    (move-to-column column-number)))

;;; Made by Søren Pilgård
(defun transpose-down ()
  "Move current line down"
  (interactive)
  (let ((column-number (- (point) (point-at-bol))))
    (kill-whole-line)
    (forward-line 1)
    (yank)
    (setq kill-ring (cdr kill-ring))
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
