;;______________________________________________________________________________
;π ESHELL
;;______________________________________________________________________________
(require 'eshell)
(setq eshell-directory-name "~/.emacs.d/eshell/")
(setq eshell-visual-commands '("nano"))
(setq eshell-buffer-shorthand t)
(setq eshell-hist-ignoredups t)
(setq eshell-aliases-file "~/.emacs.d/eshell/alias")
(setq eshell-cmpl-cycle-completions nil)
(defun m-eshell-hook ()
  (setq pcomplete-cycle-completions nil)
  (setq eshell-visual-commands '("nano"))
  (setq eshell-buffer-shorthand t)
  (setq eshell-hist-ignoredups t)
  (define-key eshell-mode-map (kbd "H-d") 'eshell-kill-input)
  (define-key eshell-mode-map (kbd "H-N") 'eshell-bol)
  (define-key eshell-mode-map (kbd "C-l") '(lambda () (interactive) (eshell/clear) (eshell-send-input)))
  (define-key eshell-mode-map (kbd "<return>") 'my-eshell-send-input)
  (add-to-list 'eshell-visual-commands "nano")
  (add-to-list 'eshell-visual-commands "htop")
  (add-to-list 'eshell-visual-commands "irssi")
  (add-to-list 'eshell-visual-commands "emacs")
  (add-to-list 'eshell-visual-commands "alsamixer")
  (add-to-list 'eshell-visual-commands "ssh")
  (add-to-list 'eshell-visual-commands "tail")

  (setq eshell-history-size 1000)
  )

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

(defun eshell/clear ()
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))
