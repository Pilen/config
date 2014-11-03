;;______________________________________________________________________________
;π AUTO-HIGHLIGHT-SYMBOL
;;______________________________________________________________________________
(require 'auto-highlight-symbol)
(ahs-set-idle-interval 0.2)
(setq ahs-default-range 'ahs-range-whole-buffer)

(setq auto-highlight-symbol-mode-map nil)
(set-face-background ahs-plugin-defalt-face "olive drab")
(set-face-foreground ahs-plugin-defalt-face nil)

(set-face-background ahs-face "grey40")
(set-face-foreground ahs-face nil)

;; (set-face-background ahs-plugin-whole-buffer-face "olive drab")
;; (set-face-foreground ahs-plugin-whole-buffer-face nil)
(set-face-background ahs-plugin-whole-buffer-face (face-background 'default))
(set-face-foreground ahs-plugin-whole-buffer-face nil)


(defun ahs-mode ()
  "Always fire up ahs-mode, except in minibuffer"
  (if (not (minibufferp (current-buffer)))
      (auto-highlight-symbol-mode t)))


(define-globalized-minor-mode my-global-auto-highlight-symbol-mode
  auto-highlight-symbol-mode-map ahs-mode
  :group 'auto-highlight-symbol)

(my-global-auto-highlight-symbol-mode 1)
