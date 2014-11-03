;;______________________________________________________________________________
;π RAINBOW DELIMITERS
;;______________________________________________________________________________
(require 'rainbow-delimiters)
(setq-default frame-background-mode 'dark)

;; (set-face-attribute
;;  'rainbow-delimiters-depth-1-face nil
;;  :foreground "honeydew1")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-2-face nil
;;  :foreground "LightSkyBlue1")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-3-face nil
;;  :foreground "DarkSlateGray1")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-4-face nil
;;  :foreground "OliveDrab1")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-5-face nil
;;  :foreground "SteelBlue1")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-6-face nil
;;  :foreground "chartreuse1")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-7-face nil
;;  :foreground "MediumOrchid2")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-8-face nil
;;  :foreground "tan1")

;; (set-face-attribute
;;  'rainbow-delimiters-depth-9-face nil
;;  :foreground "magenta1")

;; (set-face-attribute
;;  'rainbow-delimiters-unmatched-face nil
;;  :foreground "red")


(set-face-attribute
 'rainbow-delimiters-depth-1-face nil
 :foreground "honeydew1")

(set-face-attribute
 'rainbow-delimiters-depth-2-face nil
 :foreground "DarkSlateGray1")

(set-face-attribute
 'rainbow-delimiters-depth-3-face nil
 :foreground "DeepSkyBlue3")

(set-face-attribute
 'rainbow-delimiters-depth-4-face nil
 :foreground "green")

(set-face-attribute
 'rainbow-delimiters-depth-5-face nil
 :foreground "pink4")

(set-face-attribute
 'rainbow-delimiters-depth-6-face nil
 :foreground "goldenrod2")

(set-face-attribute
 'rainbow-delimiters-depth-7-face nil
 :foreground "MediumOrchid2")

(set-face-attribute
 'rainbow-delimiters-depth-8-face nil
 :foreground "purple4")

(set-face-attribute
 'rainbow-delimiters-depth-9-face nil
 :foreground "gray50")

(set-face-attribute
 'rainbow-delimiters-unmatched-face nil
 :foreground "red")

;((((((((((t))))))))))

;(rainbow-delimiters-mode 1)
;;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(global-rainbow-delimiters-mode)


;(show-paren-mode t)
;(show-paren-delay 0)
;(show-paren-style 'expression)
;(set-face-background 'show-paren-match-face "#aaaaaa")
;(set-face-attribute 'show-paren-match-face nil
;                    :weight 'bold :underline nil : overline nil :slant 'normal)
;(set-face-foreground 'show-paren-mismatch-face "red")
;(set-face-attribute 'show-paren-mismatch-face nil
;                    :weight 'bold :underline t :overline nil : slant 'normal)

;(require 'highlight-parentheses)
