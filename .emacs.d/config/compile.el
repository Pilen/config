;;______________________________________________________________________________
;π COMPILE
;;______________________________________________________________________________
;; H-g  =  compile
(global-set-key (kbd "H-g")      (lambda () (interactive) (save-buffer) (message "Compile-key not defined for this mode.")))
(add-hook 'LaTeX-mode-hook       (lambda () (define-key TeX-mode-map         (kbd "H-g") 'run-latex)))
(add-hook 'c++-mode              (lambda () (define-key c++-mode-map         (kbd "H-g") (lambda () (interactive) (save-buffer) (call-interactively 'compile)))))
(add-hook 'c++-mode-hook         (lambda () (define-key c++-mode-map         (kbd "H-g") 'my-c-compile)))
(add-hook 'c-mode-hook           (lambda () (define-key c-mode-map           (kbd "H-g") 'my-c-compile)))
(add-hook 'arduino-mode-hook     (lambda () (define-key arduino-mode-map     (kbd "H-g") 'arduinel-build)))
(add-hook 'compilation-mode-hook (lambda () (define-key compilation-mode-map (kbd "H-g") 'recompile)))
(add-hook 'emacs-lisp-mode-hook  (lambda () (define-key emacs-lisp-mode-map  (kbd "H-g") 'my-elisp-eval)))
(add-hook 'erlang-mode-hook      (lambda () (define-key erlang-mode-map      (kbd "H-g") (lambda () (interactive) (save-buffer) (erlang-compile) (first-error)))))
(add-hook 'go-mode-hook          (lambda () (define-key go-mode-map          (kbd "H-g") 'my-go-compile)))
(add-hook 'haskell-mode-hook     (lambda () (define-key haskell-mode-map     (kbd "H-g") 'inferior-haskell-load-file)))
(add-hook 'jde-mode-hook         (lambda () (define-key jde-mode-map         (kbd "H-g") 'jde-compile-or-run)))
(add-hook 'makefile-mode-hook    (lambda () (define-key makefile-mode-map    (kbd "H-g") 'my-c-compile)))
(add-hook 'maple-mode-hook       (lambda () (define-key maple-mode-map       (kbd "H-g") 'maple-buffer)))
(add-hook 'python-mode-hook      (lambda () (define-key python-mode-map      (kbd "H-g") 'python-compile)))
(add-hook 'ruby-mode-hook        (lambda () (define-key ruby-mode-map        (kbd "H-g") (lambda () (interactive) (save-excursion (when (null inf-ruby-buffer) (run-ruby) (sleep-for 1))) (ruby-send-region-and-go (point-min) (point-max))))))
(add-hook 'scheme-mode-hook      (lambda () (define-key scheme-mode-map      (kbd "H-g") (lambda () (interactive) (save-buffer) (geiser-mode-switch-to-repl-and-enter)))))
(add-hook 'sh-mode               (lambda () (define-key sh-mode-map          (kbd "H-g") 'eshell-execute-current-line)))
(add-hook 'shell-script-mode     (lambda () (define-key sh-mode-map          (kbd "H-g") 'eshell-execute-current-line)))
(add-hook 'sml-mode-hook         (lambda () (define-key sml-mode-map         (kbd "H-g") 'sml-compile)))
(add-hook 'sql-mode              (lambda () (define-key sql-mode-map         (kbd "H-g") 'sql-send-line)))

(defun my-c-compile ()
  (interactive)
  (save-buffer)
  (save-some-buffers)
  (let ((already-visible (and (get-buffer "*compilation*") (get-buffer-window-list "*compilation*" nil t))))
    (cond
     ((file-exists-p (concat (file-name-directory (buffer-file-name (current-buffer))) "Makefile"))
      (compile "make"))
     ((null (car compile-history))
      (compile (compilation-read-command
                (concat "gcc "
                        (file-name-nondirectory (buffer-file-name))))))

     ('t
      (compile (compilation-read-command (car compile-history)))))
    (when already-visible
      (dolist (window (get-buffer-window-list "*compilation*" nil t))
        (unless (memq window already-visible)
          (with-selected-window window
            (bury-buffer)) ())))))

(setq compilation-skip-threshold 2)

(defun my-compile-finished (buffer result)
  (unless (string-equal result "finished\n")
      (first-error)))
(add-to-list 'compilation-finish-functions 'my-compile-finished)

(defun my-elisp-eval ()
  (interactive)
  (save-excursion
  (let ((start (search-backward-regexp "^(")))
    (goto-match-paren)
    (eval-region start (point) standard-output))))

(setq compilation-scroll-output 'first-error)


(defalias 'my-go-compile 'my-c-compile)

(define-key minibuffer-local-map (kbd "H-g") 'exit-minibuffer)

;; (setq compilation-ask-about-save t)
