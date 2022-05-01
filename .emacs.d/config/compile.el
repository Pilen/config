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
(add-hook 'java-mode-hook        (lambda () (define-key java-mode-map        (kbd "H-g") 'my-c-compile)))
(add-hook 'makefile-mode-hook    (lambda () (define-key makefile-mode-map    (kbd "H-g") 'my-c-compile)))
(add-hook 'maple-mode-hook       (lambda () (define-key maple-mode-map       (kbd "H-g") 'maple-buffer)))
;; (add-hook 'python-mode-hook      (lambda () (define-key python-mode-map      (kbd "H-g") 'python-compile)))
;; (add-hook 'python-mode-hook      (lambda () (define-key python-mode-map      (kbd "H-g") 'project-runner)))
(add-hook 'python-mode-hook      (lambda () (define-key python-mode-map      (kbd "H-g") 'my-dominating-compile)))
(add-hook 'ruby-mode-hook        (lambda () (define-key ruby-mode-map        (kbd "H-g") (lambda () (interactive) (save-excursion (when (null inf-ruby-buffer) (run-ruby) (sleep-for 1))) (ruby-send-region-and-go (point-min) (point-max))))))
(add-hook 'scheme-mode-hook      (lambda () (define-key scheme-mode-map      (kbd "H-g") (lambda () (interactive) (save-buffer) (geiser-mode-switch-to-repl-and-enter)))))
(add-hook 'sh-mode               (lambda () (define-key sh-mode-map          (kbd "H-g") 'eshell-execute-current-line)))
(add-hook 'shell-script-mode     (lambda () (define-key sh-mode-map          (kbd "H-g") 'eshell-execute-current-line)))
(add-hook 'sml-mode-hook         (lambda () (define-key sml-mode-map         (kbd "H-g") 'sml-compile)))
(add-hook 'sql-mode              (lambda () (define-key sql-mode-map         (kbd "H-g") 'sql-send-line)))
(add-hook 'org-mode              (lambda () (define-key org-mode-map         (kbd "H-g") 'org-ctrl-c-ctrl-c)))
;; (last python-mode-hook)
;; (setq python-mode-hook (butlast python-mode-hook 1))

(defun my-c-compile ()
  (interactive)
  (save-buffer)
  (save-some-buffers)
  (let ((already-visible (and (get-buffer "*compilation*") (get-buffer-window-list "*compilation*" nil t))))
    (cond
     ((file-exists-p (concat (file-name-directory (buffer-file-name (current-buffer))) ".Makefile.emacs"))
      (compile "./.Makefile.emacs"))
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
(setq next-error-highlight 1.0)

;; (setq my-compile-found-initial-error nil)
;; (defun my-compile-started (p)
;;   (setq my-compile-found-initial-error nil)
;;   ;; (next-error-follow-minor-mode -1) ;; Disable until compile is finished
;;   )
(defun my-compile-finished (buffer result)
  ;; ;; (next-error-follow-minor-mode)
  ;; (unless (string-equal result "finished\n")
  ;;   (message "finished %s %s" (current-buffer) (point))
  ;;   ;; (backward-char 1)
  ;;   (forward-line -1)
  ;;   (message "point %s" (point))
  ;;   ;; (beginning-of-line)
  ;;   ;; (first-error)
  ;; )
  )
;; (defun my-compile-goto-initial-error ()
;;   (unless my-compile-found-initial-error
;;     (ignore-errors
;;       ;; (compilation-next-error 0 nil compilation-filter-start)
;;       (message "found error")
;;       )
;;     ))
;; (add-hook 'compilation-filter-hook 'my-compile-goto-initial-error)
(add-to-list 'compilation-finish-functions 'my-compile-finished)
;; (add-hook 'compilation-start-hook 'my-compile-started)

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


(require 'ansi-color)
(defun my-colorize-compilation-buffer (&rest r)
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region compilation-filter-start (point))))
  )
(defun my-compilation-find-file-advice (func marker filename directory &rest formats)
  (apply func marker (ansi-color-filter-apply filename) directory formats))
(add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer)
(add-hook 'compilation-start-hook (lambda (p) (call-interactively 'my-ahs-clear-overlays)))
(add-hook 'compilation-start-hook (lambda (p) (linum-mode -1))) ;; linum causes this to slow down!
;; (advice-add 'compilation-next-error-function :before 'my-colorize-compilation-buffer)
;; (advice-remove 'compilation-next-error-function 'my-colorize-compilation-buffer)
(advice-add 'compilation-find-file :around 'my-compilation-find-file-advice)

(setq compilation-context-lines 20)
;; Modify compilation-set-window to use recenter instead

(defsubst compilation-set-window (w mk)
  "Align the compilation output window W with marker MK near top."
  (with-selected-window w
    ;; (recenter) ;; middle
    (recenter -5) ;; bottom
    )
  (set-window-point w mk))

(define-key compilation-mode-map (kbd "f") 'next-error-follow-minor-mode)

(setq compilation-environment '("TERM=xterm-color"))

;; (setq my-next-error-detected nil)
;; (defun my-next-error-detect-hook ()
;;   (setq my-next-error-detected t))
;; (add-hook 'next-error-hook 'my-next-error-detect-hook)
;; (defun my-goto-last-error ()
;;   (interactive)
;;   (setq my-next-error-detected nil)
;;   (with-selected-window (get-buffer-window next-error-last-buffer t)
;;     (goto-char (point-max))
;;     my-next-error-detected
;;     (while (null my-next-error-detected)
;;       (forward-line -1))
;;     )
;;   )

;; ;; (my-goto-last-error)

(setq my-dominating-compile-history nil)
(defun my-dominating-compile ()
  (interactive)
  (save-buffer)
  (let* (
         ;; (command (compilation-read-command (eval compile-command)))
         (command (ivy-read "Compile: " my-dominating-compile-history))
         (command-list (split-string command " "))
         (dir (locate-dominating-file default-directory (car command-list)))
         (file (expand-file-name (car command-list) dir))
         (new-command (s-join " " (cons file (cdr command-list))))
         (default-directory dir)
         )
    (setq my-dominating-compile-history (cons command (delete command my-dominating-compile-history)))
    (compile new-command)
    (setq compile-command command)))

(require 'typescript-mode)
(define-key typescript-mode-map (kbd "H-g") 'my-dominating-compile)
;; (setq my-dominating-compile-history (cdr my-dominating-compile-history))
