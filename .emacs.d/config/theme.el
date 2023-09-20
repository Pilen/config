;;______________________________________________________________________________
;π FONT
;;______________________________________________________________________________
;;font: schumacher-clean
;;alternative monaco - no anti-aliasing

;(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
; '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;(set-face-attribute 'default nil :height 80)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "Schumacher" :family "Clean"))))
 '(eshell-prompt ((t (:foreground "LightSkyBlue1" :weight bold))))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(whitespace-line ((t (:inherit nil :background "gray20")))))

;; M-x set-frame-font
;; -Schumacher-Schumacher Clean-regular-normal-normal-*-12-*-*-*-c-60-iso10646-1
;; (add-to-list 'default-frame-alist
;;              '(font . "-Schumacher-Schumacher Clean-regular-normal-normal-*-12-*-*-*-c-60-iso10646-1"))

(setq my-antialias-toggle nil)
(defun my-antialias-toggle ()
  (interactive)
  (setq my-antialias-toggle (not my-antialias-toggle))
  (set-face-font 'default (if my-antialias-toggle ":" ":antialias=false")))

;;______________________________________________________________________________
;π THEME
;;______________________________________________________________________________
;(require 'color-theme)
;(require 'color-theme-tomorrow)

;(add-to-list 'load-path "~/.emacs.d/themes/solarized")
;(eval-after-load "color-theme"
;  '(progn
;     (color-theme-initialize)
;     (color-theme-hober)))
;(require 'color-theme-solarized)
;(color-theme-solarized-dark)

(if (or (string= (system-name) "joker") (string= (system-name) "penguin"))
    (set-background-color "grey30")
  (set-background-color "SteelBlue4"))
(set-foreground-color "honeydew1")

;(set-face-background 'menubar "slate gray")
;(set-face-attribute 'menubar nil :box nil)

;; Box modeline
;(custom-set-faces
;   '(mode-line ((t (:box (:line-width 0 :color "gray50"))))))
;(custom-set-faces
;   '(mode-line-inactive ((t (:box (:line-width 0 :color "gray50"))))))

(set-face-background 'mode-line "slate gray")
(set-face-background 'mode-line-inactive "gray36")
;(set-face-foreground 'mode-line-inactive "gray10")
(set-face-foreground 'mode-line-inactive "black")

;(set-face-background 'mode-line "#4477aa")
(set-face-attribute 'mode-line nil :box nil)
;(set-background-color "black")
;(set-face-background 'default "black")
;(set-face-background 'region "black")
;(set-face-foreground 'default "white")
;(set-face-foreground 'region "gray60")
;(set-foreground-color "white")
;(set-cursor-color "red")
;(set-cursor-color "cyan")

(set-face-background 'show-paren-match "gray40")
;(set-face-background 'paren-face-match "gray40") ;; from mic-paren

(set-face-foreground 'vertical-border "gray22")

;(set-face-background 'region "royal blue")
;(set-face-background 'region "cornflower blue")
;(set-face-background 'region "DeepSkyBlue4")
(set-face-background 'region "SkyBlue4")

;(set-face-background hl-line-face "dark olive green")
(set-face-background hl-line-face "dark slate gray")
;(set-face-background hl-line-face "DodgerBlue4")
;(set-face-background hl-line-face "RoyalBlue4")
;(set-face-background hl-line-face "gray27")
;(set-face-background hl-line-face "gray34")


(setq ansi-color-names-vector ["black" "red3" "green3" "yellow3" "blue2" "magenta3" "cyan3" "gray90"])
(setq ansi-color-names-vector ["black" "OrangeRed1" "green3" "yellow3" "blue2" "magenta3" "cyan3" "gray90"])
(setq ansi-color-names-vector ["black" "OrangeRed2" "green3" "yellow3" "DodgerBlue2" "DarkOrchid2" "cyan3" "gray90"])
;; (setq ansi-color-names-vector ["black" "red" "green" "yellow" "dodger blue" "magenta" "cyan" "white"])
(setq ansi-color-map (ansi-color-make-color-map))


(set-face-foreground 'font-lock-comment-face "chocolate1") ; default
;; (set-face-foreground 'font-lock-comment-face "rosy brown")
;; (set-face-foreground 'font-lock-comment-face "chocolate2")
;; (set-face-foreground 'font-lock-comment-face "chocolate3")
;; (set-face-foreground 'font-lock-comment-face "chocolate4")
;; (set-face-foreground 'font-lock-comment-face "chocolate")
