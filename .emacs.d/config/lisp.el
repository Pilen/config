
;;______________________________________________________________________________
;π LISP-POWER-MODE
;;______________________________________________________________________________

(defconst lisp-modes '(lisp-mode
                       emacs-lisp-mode
                       scheme-mode
                       common-lisp-mode
                       clojure-mode)
  "Lisp of lisp modes.")


(define-minor-mode lisp-power-mode
  "Add common keybindings for all lisp modes"
  :lighter "lisp"
  :keymap (let ((lisp-power-map (make-sparse-keymap)))
            ;; (define-key lisp-power-map (kbd "...") 'some-function)
            lisp-power-map))
(defun lisp-power-mode-activate ()
  "Activate lisp-power-mode"
  (lisp-power-mode t))

(dolist (mode lisp-modes)
  (add-hook (intern (format "%s-hook" mode))
            #'lisp-power-mode-activate))

;;______________________________________________________________________________
;π RACKET/SCHEME
;;______________________________________________________________________________

(dolist (mode lisp-modes)
  (add-hook (intern (format "%s-hook" mode))
            #'paredit-mode))

;; M-s	paredit-splice-sexp
;; (foo (bar| baz) quux)
;;   --->
;; (foo bar| baz quux)


;; <C-right> <C-)>	paredit-forward-slurp-sexp
;; (foo (bar |baz) quux zot)
;;   --->
;; (foo (bar |baz quux) zot)

;; (a b ((c| d)) e f)
;;   --->
;; (a b ((c| d) e) f)


;; <C-left>	paredit-forward-barf-sexp
;; (foo (bar |baz quux) zot)
;;   --->
;; (foo (bar |baz) quux zot)


;; <C-M-left> <C-(>	paredit-backward-slurp-sexp
;; (foo bar (baz| quux) zot)
;;   --->
;; (foo (bar baz| quux) zot)

;; (a b ((c| d)) e f)
;;   --->
;; (a (b (c| d)) e f)


;; <C-M-right>	paredit-backward-barf-sexp
;; (foo (bar baz |quux) zot)
;;   --->
;; (foo bar (baz |quux) zot)


;; M-J	paredit-join-sexps
;; (hello)| (world)
;;   --->
;; (hello| world)

;; "Hello, "| "world!"
;;   --->
;; "Hello, |world!"

;; hello-
;; |  world
;;   --->
;; hello-|world


;; M-q	paredit-reindent-defun
;;   (no examples)

;;______________________________________________________________________________
;π RACKET/SCHEME
;;______________________________________________________________________________
(add-to-list 'auto-mode-alist '("\\.rkt\\'$" . scheme-mode))
(add-hook 'scheme-mode-hook (lambda ()
                              (require 'quack)
                              (setq quack-fontify-style 'emacs)
                              (setq quack-default-program "racket")
                              (setq quack-global-menu-p nil)))
(add-to-list 'load-path "~/.emacs.d/plugins/geiser-0.3/")
;(load-file "~/.emacs.d/plugins/geiser-0.3/")
(require 'geiser)
