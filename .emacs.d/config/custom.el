;;______________________________________________________________________________
;π CUSTOM VARIABLES
;;______________________________________________________________________________


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(comint-buffer-maximum-size 10000)
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-get-old-input (lambda nil "") t)
 '(comint-input-ignoredups t)
 '(comint-input-ring-size 100)
 '(comint-move-point-for-output t)
 '(comint-process-echoes t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(jde-jdk-registry (quote (("1.7.45" . "/usr/lib/jvm/java-7-openjdk"))))
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (wgrep-ag wgrep ace-jump-mode ace-window ag all-the-icons arduino-mode auctex auto-highlight-symbol buffer-move c-eldoc column-marker company-go company-jedi company-quickhelp csv-mode dimmer diredfl dtrt-indent elpy ensime erc-hl-nicks fastnav fill-column-indicator flymake-cursor full-ack fuzzy geiser ghc golden-ratio google-translate goto-last-change graphviz-dot-mode highlight-tail hlinum idomenu iedit impatient-mode inf-ruby ivy-xref jss keyfreq kite less-css-mode livid-mode loccur lorem-ipsum magit markdown-mode matlab-mode memory-usage mic-paren minesweeper multiple-cursors nav neotree notmuch pager paredit powerline projectile python-mode quack rainbow-delimiters rfringe smart-forward smex sml-mode sr-speedbar swiper tabbar typescript-mode typing visible-mark volatile-highlights web web-mode win-switch window-numbering wrap-region zeal-at-point)))
 '(protect-buffer-bury-p nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "Schumacher" :family "Clean"))))
 '(eshell-prompt ((t (:foreground "LightSkyBlue1" :weight bold))))
 '(flymake-errline ((((class color)) (:underline "red"))) t)
 '(flymake-error ((((class color)) (:underline "red"))))
 '(flymake-warning ((((class color)) (:underline "yellow"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))) t)
 '(whitespace-line ((t (:inherit nil :background "gray20")))))
