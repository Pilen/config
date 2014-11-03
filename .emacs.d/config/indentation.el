;;______________________________________________________________________________
;π INDENTATION
;;______________________________________________________________________________
(setq standard-indent 4)
(setq-default indent-tabs-mode nil)
;(setq tab-always-indent 'complete)
(setq tab-always-indent t)

(setq-default tab-width 4)

(setq-default c-basic-offset 4)
;;Autoindentation on yanking
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-list-mode lisp-mode
                                                     clojure-mode scheme-mode
                                                     haskell-mode ruby-mode
                                                     rspec-mode   python-mode
                                                     c-mode       c++-mode
                                                     objc-mode    latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))


(add-hook 'c-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 4)
            (setq c-indent-level 4)))
(add-hook 'objc-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 4)
            (setq c-indent-level 4)))
(add-hook 'c++-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 4)
            (setq c-indent-level 4)))

;;______________________________________________________________________________
;π AUTO-INDENT
;;______________________________________________________________________________
(require 'auto-indent)

;;______________________________________________________________________________
;π DTRT-INDENT
;;______________________________________________________________________________
;(add-hook 'c-mode-common-hook
;          (lambda()
;            (require 'dert-indent)
;            (dtrt-indent-mode t)))
(require 'dtrt-indent)
(dtrt-indent-mode t)
