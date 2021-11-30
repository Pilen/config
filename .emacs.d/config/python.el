;;______________________________________________________________________________
;π PYTHON
;;______________________________________________________________________________
;; (setq python-command "/usr/bin/bpython")
(remove-hook 'python-mode-hook (lambda () (setq imenu-create-index-function 'python-imenu-create-index)))
(defun my-python-mode-hook ()
  ;; (setq imenu-create-index-function 'imenu-default-create-index-function)
  (setq imenu-create-index-function 'python-imenu-create-index)
  (setq tab-width (default-value 'tab-width)) ;; Don't fuck with my tab-width!!!
  ;; (add-to-list 'company-backends 'company-jedi)
  ;; (jedi:setup)

  ;; I think i already did this somewhere? Remove when fixed by elpy
  (setq elpy-eldoc-show-current-function nil)
  (which-function-mode)
  )

;; (jedi:install-server)

;; (setq jedi:get-in-function-call-delay 100)
;; (setq jedi:use-shortcuts t) ;; Enable M-. and M-, for jumping to tags
;; (setq jedi:complete-on-dot t)
;; (setq jedi:tooltip-method nil)

;; (defun my-kill-jedi () (ignore-errors (kill-process  (epc:manager-server-process jedi:epc)))) ;; This is a bloody hack, currently there are bugs in jedi, spawning a slew of processes
;;  (run-with-idle-timer 60 t 'my-kill-jedi)


(add-hook 'python-mode-hook 'my-python-mode-hook)
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "-i --simple-prompt"
      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
)

;; (elpy-enable)
;; (elpy-disable)

(defun wisent-python-wy--install-parser () nil)

(defun wisent-python-default-setup ()
  "Setup buffer for parse."
  (wisent-python-wy--install-parser)
  (set (make-local-variable 'parse-sexp-ignore-comments) t)
  ;; Give python modes the possibility to overwrite this:
  (if (not comment-start-skip)
      (set (make-local-variable 'comment-start-skip) "#+\\s-*"))
  (setq
   ;; Character used to separation a parent/child relationship
   semantic-type-relation-separator-character '(".")
   semantic-command-separation-character ";"
   ;; Parsing
   semantic-tag-expand-function 'semantic-python-expand-tag

   ;; Semantic to take over from the one provided by python.
   ;; The python one, if it uses the senator advice, will hang
   ;; Emacs unrecoverably.
   imenu-create-index-function 'imenu-default-create-index-function

   ;; I need a python guru to update this list:
   semantic-symbol->name-assoc-list-for-type-parts '((variable . "Variables")
                                                     (function . "Methods"))
   semantic-symbol->name-assoc-list '((type . "Classes")
                                      (variable . "Variables")
                                      (function . "Functions")
                                      (include  . "Imports")
                                      (package  . "Package")
                                      (code . "Code")))
  )

;; (defun semantic-create-imenu-index (&optional stream)
;;   (imenu-default-create-index-function))

;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (require 'python-mode)


;; (defun python-compile ()
;;   (interactive)
;;   (save-excursion
;;     (beginning-of-buffer)
;;     (insert (concat "print('evaluating: " (buffer-name) "')\n"))
;;     (python-shell-send-buffer) ;python-shell-send-buffer
;;     (beginning-of-buffer)
;;     (kill-whole-line)
;;     )
;;   (python-shell-switch-to-shell))

(defun python-compile ()
  (interactive)
  (save-excursion
    (unless (python-shell-get-process)
      (run-python)
      (python-shell-send-string "__name__ = '__emacs__'"))
    (save-restriction
      (widen)
      (let ((string (python-shell-buffer-substring (point-min) (point-max))))
        (python-shell-send-string (concat string "\n" "print('evaluating: " (buffer-name) "', end='')"))))
    (save-selected-window
      (python-shell-switch-to-shell))))
