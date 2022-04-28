;;______________________________________________________________________________
;π COMMAND-CENTER
;;______________________________________________________________________________

(defvar command-center-commands '())

(defun command-center-add (command &optional name)
  (when (null name)
    (if (symbolp command)
        (setq name (symbol-name command))
      (setq name (prin1-to-string command))))

  (setq command-center-commands (append
                                 command-center-commands
                                 `((,name . ,command)))))

(defun command-center-clear ()
  (setq command-center-commands '()))

(defun command-center ()
  (interactive)
  (let* ((names (mapcar #'car command-center-commands))
         (name (ido-completing-read ">: " names))
         (pair (assoc name command-center-commands))
         (command (cdr pair)))
    (setq command-center-commands
          (cons pair (delete pair command-center-commands)))
    (if (commandp command)
        (call-interactively command)
      (funcall command))))

(progn
  (command-center-clear)
  ;; File/buffer
  (command-center-add 'my-find-file-in-selected-window "find-file-in-selected-window")
  (command-center-add 'my-find-file-other-window "find-file-other-window")
  (command-center-add 'rename-file-and-buffer)
  (command-center-add 'move-buffer-file)
  (command-center-add 'delete-file)

  (command-center-add 'erase-buffer)
  (command-center-add 'revert-buffer)
  (command-center-add 'revert-all-buffers)

  (command-center-add 'make-directory)
  (command-center-add 'change-directory)
  (command-center-add 'set-buffer-file-coding-system)
  (command-center-add (lambda () (interactive) (set-buffer-file-coding-system 'unix t)) "unix-file")
  (command-center-add (lambda () (interactive) (call-interactively 'set-buffer-file-coding-system)) "set-encoding")
  (command-center-add (lambda () (interactive) (let ((before-save-hook nil)) (save-buffer))) "save-buffer-no-hook")
  (command-center-add 'sudo-edit-current-file "edit current file sudo root")
  (command-center-add 'count-words "count-lines/words")

  ;; Project
  (command-center-add 'projectile-find-file-dwim)
  (command-center-add 'projectile-find-file-dwim-other-window)
  (command-center-add 'magit-status)
  (command-center-add 'magit-pull-from-upstream)
  (command-center-add 'magit-push-current-to-upstream)
  (command-center-add 'magit-fetch-all)
  (command-center-add 'magit-log-buffer-file)
  (command-center-add 'magit-blame)
  (command-center-add 'magit-remote-prune)
  (command-center-add 'my-magit-clean-after-merge-request)
  (command-center-add 'magit-section-toggle-children)

  ;; Search
  (command-center-add 'occur)
  (command-center-add 'loccur-current)
  (command-center-add 'loccur-previous-match)
  (command-center-add 'ag-project-regexp "ag")
  (command-center-add 'swiper)
  (command-center-add 'query-replace-regexp)

  ;; Elisp
  (command-center-add 'eval-buffer)
  (command-center-add 'eval-region)
  (command-center-add 'emacs-lisp-mode)
  (command-center-add 'edebug-eval-top-level-form "edebug-current")


  ;; Formating
  (command-center-add 'whitespace-cleanup)
  (command-center-add 'reindent-buffer)
  (command-center-add 'auto-fill-mode)
  (command-center-add 'fill-region)
  (command-center-add (lambda () (interactive) (fill-region (point-min) (point-max))) "fill buffer")
  (command-center-add 'sort-lines)
  (command-center-add (lambda () (interactive) (untabify (point-min) (point-max))) "untabify-buffer")
  (command-center-add 'align-regexp)
  (command-center-add 'my-align-regexp)

  ;; Edit
  (command-center-add 'insert-unicode-symbol)
  (command-center-add 'increment-number-at-point)
  (command-center-add 'decrement-number-at-point)
  (command-center-add 'lorem-ipsum-insert-paragraphs)


  ;; Org
  (command-center-add 'org-mode)
  (command-center-add 'show-all)
  (command-center-add 'hide-sublevels "hide-all")
  (command-center-add 'org-mouse-show-headlines "show-headlines")
  (command-center-add 'org-promote-subtree)
  (command-center-add 'org-demote-subtree)
  (command-center-add 'org-indent-block)
  (command-center-add 'org-indent-region)
  (command-center-add 'org-store-link)
  (command-center-add 'org-babel-execute-buffer)
  (command-center-add 'org-babel-switch-to-session)
  (command-center-add 'org-set-tags-command)

  ;; Origami
  (command-center-add 'origami-open-all-nodes)
  (command-center-add 'origami-close-all-nodes)
  (command-center-add 'origami-recursively-toggle-node)
  (command-center-add 'origami-show-only-node)

  ;; Frames
  (command-center-add 'my-frame-new "frame-new") ;; 35?
  (command-center-add 'my-frame-close "frame-close")
  (command-center-add 'my-frame-close-others "frame-close-others")
  (command-center-add 'my-frame-close-extra "frame-close-extra")
  (command-center-add 'my-frame-reset-background "frame-reset-background")
  (command-center-add 'my-frame-random-background "frame-random-background")


  ;; Terminal/shell
  (command-center-add (lambda () (interactive) (shell-command "urxvtc")) "urxvtc")
  (command-center-add 'shell-command-on-region-replace)
  (command-center-add 'eshell-execute-my-command)
  (command-center-add 'eshell-execute-current-line)
  (command-center-add 'eshell-command)
  (command-center-add 'shell-toggle-cd "eshell-cd")

  ;; Programming
  (command-center-add 'c-find-header)
  (command-center-add 'c-add-to-header)
  (command-center-add (lambda () (interactive) (jde-import-all) (jde-import-organize)) "java import-all + organize")
  (command-center-add 'httpd-serve-current-directory)
  (command-center-add 'impatient-mode)
  (command-center-add 'skewer-load-buffer)



  ;; Other
  (command-center-add 'compile)
  (command-center-add 'sgml-close-tag)
  (command-center-add 'sql-clear "clear")
  (command-center-add 'sql-clear)
  (command-center-add 'my-tags-create)
  (command-center-add 'gtags-create-or-update)
  (command-center-add 'visit-tags-table)
  (command-center-add 'indent-region)
  (command-center-add 'horizontal-recenter)
  (command-center-add 'google-translate-da/en)
  (command-center-add 'google-translate-en/da)
  (command-center-add 'glasses-mode)
  (command-center-add 'global-whitespace-mode)
  (command-center-add 'repunctuate-sentences)
  (command-center-add 'customize-group)
  (command-center-add 'list-processes)
  (command-center-add (lambda () (interactive) (find-file (concat (file-name-sans-extension (buffer-file-name)) ".pdf"))) "open-pdf")
  (command-center-add 'tramp-cleanup-all-connections)
  (command-center-add 'tramp-cleanup-all-buffers "tramp close everything")
  (command-center-add 'ediff-buffers)
  (command-center-add 'ediff)
  (command-center-add 'ediff-directories)
  (command-center-add 'fit-window-to-buffer)
  (command-center-add (lambda () (interactive) (quick-calc) (yank)) "quick-calc-insert")
  (command-center-add 'quick-calc)
  (command-center-add 'man) ()
  (command-center-add 'neotree)
  (command-center-add 'imenu-list-smart-toggle)
  (command-center-add 'ibuffer)
  (command-center-add 'font-lock-fontify-buffer)
  (command-center-add 'beginning-of-defun)
  (command-center-add 'apply-macro-to-region-lines)

  (command-center-add (lambda () (interactive) (ido-find-file-in-dir "~/.emacs.d/config/")) "find config file")
  (command-center-add 'goto-command-center)

  (command-center-add 'dired-toggle-read-only "dired-edit")
  (command-center-add 'wdired-finish-edit "dired-finish-edit")
  (command-center-add (lambda () (interactive) (mc/insert-numbers (string-to-number (read-from-minibuffer "start: ")))) "multiple-cursors-insert-number")

  (command-center-add (lambda () (interactive) (insert (prin1-to-string (call-interactively 'eval-expression)))) "insert")

  (command-center-add 'my-antialias-toggle)
  (command-center-add 'my-print-source-code "print-source-code")

  (command-center-add 'my-describe-variable-full)


  (command-center-add 'smart-to-ascii)


  (command-center-add 'vagrant)

  (command-center-add 'next-scratch-buffer)
  (command-center-add 'flyspell-correct-word-before-point)

  ;; Revy
  (command-center-add 'revy-abort)
  (command-center-add 'revy-show-text)
  (command-center-add 'revy-ubertex-mode)
  (command-center-add 'revy-ubersicht-mode)
  (command-center-add 'revy-manus-break)
  (command-center-add 'revy-manus-comment)
  (command-center-add 'revy-manus-preamble)
  (command-center-add 'revy-manus-clean)
  (command-center-add (lambda () (interactive) (insert "\\pause{}")) "revy manus \\pause{}")

  ;; Instruktor
  (command-center-add 'ret-tilføj-punkt)
  (command-center-add 'ret-svar)

  (length command-center-commands)
  )


(defun goto-command-center ()
  (interactive)
  ;; (switch-to-buffer ".emacs")
  (find-file "~/.emacs.d/config/command-center.el")
  (goto-char (point-min))
  (search-forward ";;______________________________________________________________________________
;π COMMAND-CENTER
;;______________________________________________________________________________
")
  (goto-char (match-beginning 0))
  (recenter 0))
