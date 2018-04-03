;;______________________________________________________________________________
;π ESHELL
;;______________________________________________________________________________

;; http://www.masteringemacs.org/article/complete-guide-mastering-eshell
;; http://www.howardism.org/Technical/Emacs/eshell-fun.html


(require 'eshell)
(require 'em-alias)
(require 'em-ls)
(require 'ag)
(setq eshell-directory-name "~/.emacs.d/eshell/")
(setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx" "ncftp" "pine" "tin" "trn" "elm"))
(setq eshell-buffer-shorthand t)
(setq eshell-hist-ignoredups t)
(setq eshell-aliases-file "~/.emacs.d/eshell/alias")
(setq eshell-cmpl-cycle-completions nil)
(defun m-eshell-hook ()
  (setq pcomplete-cycle-completions nil)
  (setq eshell-buffer-shorthand t)
  (setq eshell-hist-ignoredups t)
  ;; (define-key eshell-mode-map (kbd "H-d") 'eshell-kill-input)
  (define-key eshell-mode-map (kbd "C-a") 'eshell-my-bol)
  (define-key eshell-mode-map (kbd "H-N") 'eshell-my-bol)
  (define-key eshell-mode-map (kbd "C-l") 'eshell/clear)
  (define-key eshell-mode-map (kbd "<return>") 'my-eshell-send-input)
  (define-key eshell-mode-map (kbd "H-r") 'eshell-ido-history)
  (define-key eshell-mode-map (kbd "H-d") 'my-eshell-kill-whole-line)
  (add-to-list 'eshell-visual-commands "nano")
  (add-to-list 'eshell-visual-commands "htop")
  (add-to-list 'eshell-visual-commands "irssi")
  (add-to-list 'eshell-visual-commands "emacs")
  (add-to-list 'eshell-visual-commands "alsamixer")
  (add-to-list 'eshell-visual-commands "ssh")
  (add-to-list 'eshell-visual-commands "tail")
  (add-to-list 'eshell-visual-commands "tmux")
  (add-to-list 'eshell-command-aliases-list  '("f" "eshell-goto"))
  ;; (add-to-list 'eshell-command-aliases-list  '("ag" "ag-eshell $*"))
  ;; (add-to-list 'eshell-command-aliases-list  '("ls" "eshell/ls"))
  (setq eshell-command-aliases-list (remove-if
                                     (lambda (alias)
                                       (string= (car alias) "ls")) eshell-command-aliases-list))
  (setq eshell-history-size 10000)
  )

(defun eshell/new (&optional arg)
  (if arg
        (with-current-buffer (eshell arg)
          (rename-buffer (format "*eshell - %s*" arg) )
          (when (file-directory-p arg)
            (insert "cd " arg)
            (eshell-send-input)))
    (eshell t)))

(defalias 'eshell/n 'eshell/new)

(add-hook 'eshell-mode-hook 'm-eshell-hook)
(defun tyler-eshell-view-file (file)
  "A version of `view-file' which properly respects the eshell prompt."
  (interactive "fView file: ")
  (unless (file-exists-p file) (error "%s does not exist" file))
  (let ((had-a-buf (get-file-buffer file))
        (buffer (find-file-noselect file)))
    (if (eq (with-current-buffer buffer (get major-mode 'mode-class))
            'special)
        (progn
          (switch-to-buffer buffer)
          (message "Not using View mode because the major mode is special"))
      (let ((undo-window (list (window-buffer) (window-start)
                               (+ (window-point)
                                  (length (funcall eshell-prompt-function))))))
        (switch-to-buffer buffer)
        (view-mode-enter (cons (selected-window) (cons nil undo-window))
                         'kill-buffer)))))
(defun eshell/less (&rest args)
  "Invoke `view-file' on a file. \"less +42 foo\" will go to line 42 in
    the buffer for foo."
  (while args
    (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
        (let* ((line (string-to-number (match-string 1 (pop args))))
               (file (pop args)))
          (tyler-eshell-view-file file)
          (goto-line line))
      (tyler-eshell-view-file (pop args)))))

(defalias 'eshell/more 'eshell/less)
;; (defun eshell/e (file)
;;   (message file)
;;   (find-file-other-window file))

(defun eshell/e (file &rest files)
  (message default-directory)
  (setq files (mapcar (lambda (x) (if (stringp x) (list x) x))
                      (cons file files)))
  (dolist (filelist files)
    (dolist (file filelist)
      (find-file-other-window file t))))

(defalias 'eshell/o 'ido-find-file)

(defun eshell/s (command &rest args)
  (shell-command (mapconcat 'identity (cons command args) " ")))

(defun shell-toggle-buffer-switch-to-other-window ()
  "Switches to other window.  If the current window is the only window in the
current frame, create a new window and switch to it.

\(This is less intrusive to the current window configuration than
`switch-buffer-other-window')"
  (let ((this-window (selected-window)))
    (other-window 1)
    ;; If we did not switch window then we only have one window and need to
    ;; create a new one.
    (if (eq this-window (selected-window))
        (progn
          (split-window-horizontally)
          (other-window 1)))))

(defun my-eshell-send-input ()
  (interactive)
  (goto-char (point-max))
  (eshell-send-input))

(defvar eshell-execute-my-command-history nil)

;; Does not work with "clear"
(defun eshell-execute-my-command (&optional command)
  (interactive)
  (let ((window-number  (window-numbering-get-number))
        (start nil)
        (result command))
    (when (null command)
      (let ((history (cdr eshell-execute-my-command-history)))
        (setq command (read-string
                       "kat$: "
                       (car eshell-execute-my-command-history)
                       'history)))
      (when (not (string= command (car eshell-execute-my-command-history)))
        (push command eshell-execute-my-command-history)))

    (shell-toggle nil)
    (eshell-kill-input)
    (insert command)
    (setq start (1+ (point)))
    (eshell-send-input)
    (message command)
    (when (not (string= "" command)) ;; should be if it is empty or only contains whitespace
      ;; (let ((time (current-time)))
      ;; (>= 1 (float-time (time-subtract time (current-time)))));; Should have a max time of 1 sec
      (while (>= start eshell-last-output-start)
        (sleep-for 0 20))
      (when (= 1 (count-lines start eshell-last-output-start))
        (setq result
              (substring
               (buffer-substring-no-properties start
                                               eshell-last-output-start)
               0 -1))))
    (select-window-by-number window-number)
    (message result)))

(defun eshell-execute-current-line ()
  "Insert text of current line in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((command (buffer-substring
                  (save-excursion
                    (beginning-of-line)
                    (point))
                  (save-excursion
                    (end-of-line)
                    (point)))))
    (let ((buf (current-buffer)))
      (unless (get-buffer eshell-buffer-name)
        (eshell))
      (display-buffer eshell-buffer-name t)
      (switch-to-buffer-other-window eshell-buffer-name)
      (end-of-buffer)
      (eshell-kill-input)
      (insert command)
      (eshell-send-input)
      (end-of-buffer)
      (switch-to-buffer-other-window buf))))


(defun eshell-goto (dir)
  "Use ido to go to dir"
  (interactive)
  (let ((dir (ido-read-directory-name "goto: "))
        (inhibit-read-only t))
    (insert "cd " "\"" dir "\"")
    (eshell-send-input)
    (search-backward-regexp eshell-prompt-regexp)
    (previous-line)
    (kill-region (point) (point-max))
    (ring-remove eshell-history-ring 0)
    ;; (ring-remove eshell-history-ring 0) ;; delete the call to this function
    ))


(setq eshell-prompt-function (lambda () (concat (abbreviate-file-name (eshell/pwd))
                                                "\n" (if (= (user-uid) 0) "# " "$ "))))
(setq eshell-prompt-regexp "^[^#$\n]*\n[#$] ")


(defun eshell-bol ()
  "Goes to the beggining of the line, after the last prompt"
  (interactive)
  (save-match-data
    (search-backward-regexp eshell-prompt-regexp)
    (goto-char (match-end 0))))

(defun eshell-ido-history ()
  "Complete history using ido"
  (interactive)
  (goto-char (point-max))
  (insert (ido-completing-read "execute: " (ring-elements eshell-history-ring))))

(defun my-eshell-kill-whole-line ()
  (interactive)
  (eshell-my-bol)
  (kill-line))
;;______________________________________________________________________________
;π ESHELLCONTROL
;;______________________________________________________________________________

(defun my-eshell-execute-current-line ()
  "Insert text of current line in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((command (buffer-substring
                  (save-excursion
                    (beginning-of-line)
                    (point))
                  (save-excursion
                    (end-of-line)
                    (point)))))
    (let ((buf (current-buffer)))
      (unless (get-buffer eshell-buffer-name)
        (eshell))
      (display-buffer eshell-buffer-name t)
      (switch-to-buffer-other-window eshell-buffer-name)
      (end-of-buffer)
      (eshell-kill-input)
      (insert command)
      (eshell-send-input)
      (end-of-buffer)
      (switch-to-buffer-other-window buf))))


;; If deleting the eshell prompt is suddenly possible, it might be that inhibit-read-only is somehow set to t (should be nil)
(defun eshell/clear ()
  (interactive)
  (goto-char (point-max))
  (eshell-my-bol)
  (let ((inhibit-read-only t)
        (current (buffer-substring (point) (point-max))))
    (delete-region (point) (point-max))
    (erase-buffer)
    (eshell-send-input)
    (insert current)))


;;______________________________________________________________________________
;π SORT
;;______________________________________________________________________________


(defun eshell-ls-sort-entries_orig (entries)
  "Sort the given ENTRIES, which may be files, directories or both.
In Eshell's implementation of ls, ENTRIES is always reversed."
  (if (eq sort-method 'unsorted)
      (nreverse entries)
    (sort entries
          (function
           (lambda (l r)
             (let ((result
                    (cond
                     ((eq sort-method 'by-atime)
                      (eshell-ls-compare-entries l r 4 'time-less-p))
                     ((eq sort-method 'by-mtime)
                      (eshell-ls-compare-entries l r 5 'time-less-p))
                     ((eq sort-method 'by-ctime)
                      (eshell-ls-compare-entries l r 6 'time-less-p))
                     ((eq sort-method 'by-size)
                      (eshell-ls-compare-entries l r 7 '<))
                     ((eq sort-method 'by-extension)
                      (let ((lx (file-name-extension
                                 (directory-file-name (car l))))
                            (rx (file-name-extension
                                 (directory-file-name (car r)))))
                        (cond
                         ((or (and (not lx) (not rx))
                              (equal lx rx))
                          (string-lessp (directory-file-name (car l))
                                        (directory-file-name (car r))))
                         ((not lx) t)
                         ((not rx) nil)
                         (t
                          (string-lessp lx rx)))))
                     (t
                      (string-lessp (directory-file-name (car l))
                                    (directory-file-name (car r)))))))
               (if reverse-list
                   (not result)
                 result)))))))

(defun eshell-ls-sort-entries (entries)
  "Sort the given ENTRIES, with directories first"
  ;; (print entries)
  ;; (print (car (car entries)))
  (let ((sorted (eshell-ls-sort-entries_orig entries))
        (directories nil)
        (files nil))
    (dolist (entry sorted)
      (if (file-directory-p (car entry))
          (push (cons (concat (car entry) "/") (cdr entry)) directories)
        (push entry files)))
    (setq sorted (append files directories))
    (setq sorted (nreverse sorted))
    sorted))


(defun eshell-my-bol ()
  "Go to beginning of line or beggining of prompt"
  (interactive)
  (if (= (line-number-at-pos) (line-number-at-pos (point-max)))
      (eshell-bol)
    (beginning-of-line)))



(defun eshell/ag (string &rest args)
  "Search with ag using the current eshell directory and a given string.
   To be used from within an eshell alias
   (`alias ag 'ag-eshell $1'` within eshell)"
  (message "in ag-eshell")
  (let ((ag-arguments (cons "--smart-case" (cons "--stats" args))))
    (ag/search string (eshell/pwd) :regexp t))
  "")
(add-to-list 'ag-ignore-list "#*#")

(defun eshell/agp (string &rest args)
  "Search with ag using the current eshell directory and a given string.
   To be used from within an eshell alias
   (`alias ag 'ag-eshell $1'` within eshell)"
  (let ((ag-arguments (cons "--smart-case" (cons "--stats" args))))
    (ag/search string (ag/project-root (eshell/pwd)) :regexp t))
  "")

(defvar my-ag-history nil)
(defun ag/read-from-minibuffer (prompt)
  "Read a value from the minibuffer with PROMPT.
If there's a string at point, offer that as a default."
  (let* ((suggested (ag/dwim-at-point))
         (final-prompt
          (if suggested
              (format "%s (default %s): " prompt suggested)
            (format "%s: " prompt)))
         ;; Ask the user for input, but add `suggested' to the history
         ;; so they can use M-n if they want to modify it.
         (user-input (read-from-minibuffer
                      final-prompt
                      nil nil nil
                      'my-ag-history
                      suggested)))
    ;; Return the input provided by the user, or use `suggested' if
    ;; the input was empty.
    (if (> (length user-input) 0)
        user-input
      suggested)))

(setq ag-reuse-buffers t)

;; Updating linums while ag runs causes it to slow down enormously, so turn it off temporarily
(add-hook 'ag-mode-hook '(lambda () (linum-mode -1)))
(add-hook 'ag-search-finished-hook '(lambda () (linum-mode t)))


;;______________________________________________________________________________
;π Enhanced LS
;;______________________________________________________________________________
;; https://www.emacswiki.org/emacs/EshellEnhancedLS

(defun ted-eshell-ls-find-file-at-point (point)
  "RET on Eshell's `ls' output to open files."
  (interactive "d")
  (find-file (buffer-substring-no-properties
              (previous-single-property-change point 'help-echo)
              (next-single-property-change point 'help-echo))))

(defun pat-eshell-ls-find-file-at-mouse-click (event)
  "Middle click on Eshell's `ls' output to open files.
 From Patrick Anderson via the wiki."
  (interactive "e")
  (ted-eshell-ls-find-file-at-point (posn-point (event-end event))))

(let ((map (make-sparse-keymap)))
  (define-key map (kbd "RET")      'ted-eshell-ls-find-file-at-point)
  (define-key map (kbd "<return>") 'ted-eshell-ls-find-file-at-point)
  (define-key map (kbd "<mouse-2>") 'pat-eshell-ls-find-file-at-mouse-click)
  (defvar ted-eshell-ls-keymap map))

(defadvice eshell-ls-decorated-name (after ted-electrify-ls activate)
  "Eshell's `ls' now lets you click or RET on file names to open them."
  (add-text-properties 0 (length ad-return-value)
                       (list 'help-echo "RET, mouse-2: visit this file"
                             'mouse-face 'highlight
                             'keymap ted-eshell-ls-keymap)
                       ad-return-value)
  ad-return-value)


;;______________________________________________________________________________
;π ESHELL OPEN
;;______________________________________________________________________________
(defun my-eshell-open ()
  (interactive)
  (if (derived-mode-p 'eshell-mode)
      (let* ((eshell-buffers-raw (--filter
                                  (with-current-buffer it
                                    (derived-mode-p 'eshell-mode))
                                  (buffer-list)))
             (eshell-buffers (-rotate -1 eshell-buffers-raw))
             (names (--map (buffer-name it) eshell-buffers))
             (alist (-zip-pair names eshell-buffers))
             (selected (ido-completing-read "Eshell: " names)))
        (switch-to-buffer (alist-get selected alist)))
    (let* ((current-buffer (current-buffer))
           (buffer (--first
                    (with-current-buffer it
                      (and (derived-mode-p 'eshell-mode)
                           (not (eq it current-buffer))))
                    (buffer-list))))
      (if buffer
          (switch-to-buffer-other-window buffer)
        (eshell)))))
