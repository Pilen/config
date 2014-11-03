;;______________________________________________________________________________
;π WHITESPACE
;;______________________________________________________________________________

;(add-hook 'emacs-lisp-mode-hook
;          (lambda ()
;            (font-lock-add-keywords nil
;                                    '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
(require 'whitespace)
(setq whitespace-line-column 80)
(set-face-attribute 'whitespace-trailing nil :background "grey60")
(set-face-attribute 'whitespace-tab nil :background "grey60")
;;(set-face-attribute 'whitespace-line nil :foreground nil)  ;; I actually want it to use its default color.
;;(set-face-attribute 'whitespace-line nil :background nil)
;(set-face-foreground 'whitespace-line nil)
(setq whitespace-style '(face tabs trailing ));lines-tail)) ;;removed: lines-tail, empty
(global-whitespace-mode t)

;;show-trailing-whitespace is incompatible with fci-mode
;;(setq-default show-trailing-whitespace t)
;;(set-face-attribute
;; 'trailing-whitespace nil
;; :background "gray60")

;; nuke whitespaces when writing to a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (font-lock-add-keywords
;;      'emacs-lisp-mode
;;      '(("^[^\n]\\{80\\}\\(.*\\)$"
;;         1 longlines prepend)))

;; (defface longlines
;;   '((((type x w32 mac))
;;      (:background "red")); :inherit bold))
;;     (((type tty))
;;      (:foreground "blue")))
;;   "Face used to display the time in the mode line.")

(defface whitespace-line
  '((((class mono)) (:inverse-video t :bold t :underline t))
    (t (:background "gray20" :foreground "red")))
  "Face used to visualize \"long\" lines.

See `whitespace-line-column'."
  :group 'whitespace)
