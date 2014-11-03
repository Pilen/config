;;______________________________________________________________________________
;π PYTHON
;;______________________________________________________________________________
;; (setq python-command "/usr/bin/bpython")
(remove-hook 'python-mode-hook (lambda () (setq imenu-create-index-function 'python-imenu-create-index)))
(add-hook 'python-mode-hook
          (lambda ()
            (setq imenu-create-index-function 'imenu-default-create-index-function)))

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
  (python-shell-send-string "__name__ = '__emacs__'")
  (python-shell-send-buffer)
  (python-shell-send-string (concat "print('evaluating: " (buffer-name) "')"))
  (save-selected-window
    (python-shell-switch-to-shell)))
