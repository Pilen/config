;;______________________________________________________________________________
;;SHORTCUTS
;;______________________________________________________________________________

;; open keyboard shortcut image with F8 key
(global-set-key (kbd "<f8>")
  (lambda ()
    (interactive)
    (find-file "~/.emacs.d/ergonomic_emacs_layout_qwerty_5.3.4.png")))

;; kicking the habit
(global-unset-key (kbd "C-b")) ; backward-char
(global-unset-key (kbd "C-f")) ; forward-char
(global-unset-key (kbd "C-p")) ; previous-line
(global-unset-key (kbd "C-n")) ; next-line

(global-unset-key (kbd "M-b")) ; backward-word
(global-unset-key (kbd "M-t")) ; forward-word

(global-unset-key (kbd "M-s")) ; kill-word
(global-unset-key (kbd "C-<backspace>")) ; backward-kill-word
;(global-unset-key (kbd "C-s")) ; delete-char

(global-unset-key (kbd "M-j")) ; newline-and-indent
(global-unset-key (kbd "M-h")) ; mark-paragraph

(global-unset-key (kbd "M-o"))
(global-unset-key (kbd "C-o"))
(global-unset-key (kbd "M-'")) ; abbrev-prefix-mark

(global-unset-key (kbd "M-u")) ;
(global-unset-key (kbd "M-n")) ;
(global-unset-key (kbd "M-e")) ;
(global-unset-key (kbd "M-i")) ;
(global-unset-key (kbd "M-U")) ;
(global-unset-key (kbd "M-N")) ;
(global-unset-key (kbd "M-E")) ;
(global-unset-key (kbd "M-I")) ;

(global-unset-key (kbd "M-a")) ;
(global-unset-key (kbd "M-b")) ;
(global-unset-key (kbd "M-c")) ;
(global-unset-key (kbd "M-d")) ;
(global-unset-key (kbd "M-e")) ;
(global-unset-key (kbd "M-f")) ;
(global-unset-key (kbd "M-g")) ;
(global-unset-key (kbd "M-h")) ;
(global-unset-key (kbd "M-i")) ;
(global-unset-key (kbd "M-j")) ;
(global-unset-key (kbd "M-k")) ;
(global-unset-key (kbd "M-l")) ;
(global-unset-key (kbd "M-m")) ;
(global-unset-key (kbd "M-n")) ;
(global-unset-key (kbd "M-o")) ;
(global-unset-key (kbd "M-p")) ;
(global-unset-key (kbd "M-q")) ;
(global-unset-key (kbd "M-r")) ;
(global-unset-key (kbd "M-s")) ;
(global-unset-key (kbd "M-t")) ;
(global-unset-key (kbd "M-u")) ;
(global-unset-key (kbd "M-v")) ;
;(global-unset-key (kbd "M-w")) ;
;(global-unset-key (kbd "M-x")) ;
(global-unset-key (kbd "M-y")) ;
(global-unset-key (kbd "M-z")) ;

(global-unset-key (kbd "M-A")) ;
(global-unset-key (kbd "M-B")) ;
(global-unset-key (kbd "M-C")) ;
(global-unset-key (kbd "M-D")) ;
(global-unset-key (kbd "M-E")) ;
(global-unset-key (kbd "M-F")) ;
(global-unset-key (kbd "M-G")) ;
(global-unset-key (kbd "M-H")) ;
(global-unset-key (kbd "M-I")) ;
(global-unset-key (kbd "M-J")) ;
(global-unset-key (kbd "M-K")) ;
(global-unset-key (kbd "M-L")) ;
(global-unset-key (kbd "M-M")) ;
(global-unset-key (kbd "M-N")) ;
(global-unset-key (kbd "M-O")) ;
(global-unset-key (kbd "M-P")) ;
(global-unset-key (kbd "M-Q")) ;
(global-unset-key (kbd "M-R")) ;
(global-unset-key (kbd "M-S")) ;
(global-unset-key (kbd "M-T")) ;
(global-unset-key (kbd "M-U")) ;
(global-unset-key (kbd "M-V")) ;
(global-unset-key (kbd "M-W")) ;
(global-unset-key (kbd "M-X")) ;
(global-unset-key (kbd "M-Y")) ;
(global-unset-key (kbd "M-Z")) ;


(global-unset-key (kbd "M-,")) ; tags-loop-continue
(global-unset-key (kbd "M-.")) ; find-tag
(global-unset-key (kbd "M-<")) ; beginning-of-buffer
(global-unset-key (kbd "M->")) ; end-of-buffer
(global-unset-key (kbd "M-;")) ; comment-dwim
(global-unset-key (kbd "M-:")) ; eval-expresseion
(global-unset-key (kbd "M--"))

(global-unset-key (kbd "M-<insert>"))
(global-unset-key (kbd "M-<delete>"))
(global-unset-key (kbd "M-<home>"))
(global-unset-key (kbd "M-<end>"))







;;;; CURSOR MOVEMENTS
;; Single char cursor movement
(global-set-key (kbd "M-n") 'backward-char)
(global-set-key (kbd "M-i") 'forward-char)
(global-set-key (kbd "M-u") 'previous-line)
(global-set-key (kbd "M-e") 'next-line)
;; Move by word
(global-set-key (kbd "M-l") 'geosoft-backward-word)
(global-set-key (kbd "M-y") 'forward-word)
;; Move by paragraph
(global-set-key (kbd "M-L") 'backward-paragraph)
(global-set-key (kbd "M-Y") 'forward-paragraph)
;; Move to beginning/ending of line
(global-set-key (kbd "M-N") 'move-beginning-of-line)
(global-set-key (kbd "M-I") 'move-end-of-line)
;; Move by screen (page up/down)
(global-set-key (kbd "M-U") 'scroll-down)
(global-set-key (kbd "M-E") 'scroll-up)
;; Move to beginning/ending of file
(global-set-key (kbd "M-H") 'beginning-of-buffer)
(global-set-key (kbd "M-h") 'end-of-buffer)
;; isearch
;(global-set-key (kbd "M-o") 'isearch-forward)
;(global-set-key (kbd "M-O") 'isearch-backward)
 (global-set-key (kbd "M-g") 'recenter)

;;;; MAJOR EDITING COMMANDS
;; Delete previous/next char
(global-set-key (kbd "M-s") 'delete-backward-char)
(global-set-key (kbd "M-t") 'delete-char)
;; Delete previous/next word
(global-set-key (kbd "M-f") 'backward-kill-word)
(global-set-key (kbd "M-p") 'kill-word)
;; Copy Cut Paste, Paste previous
;;lobal-set-key (kbd "M-x") 'kill-region) ; C-w
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-V") 'yank-pop)
(global-set-key (kbd "M-C") 'copy-all)
(global-set-key (kbd "M-X") 'cut-all)
;; Undo and redo
(global-set-key (kbd "M-Z") 'redo)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "C-z") 'undo)
;; Kill line
(global-set-key (kbd "M-d") 'kill-line)
(global-set-key (kbd "M-D") 'kill-whole-line)

;;;; Textual Transformation
(global-set-key (kbd "M-S-SPC") 'mark-paragraph)
;(global-set-key (kbd "M-w") 'shrink-whitespace) ???
;(global-set-key (kbd "M-'") 'comment-dwim) ;?
(global-set-key (kbd "M-b") 'toggle-letter-case)
;; Keyword completion, because Alt-Tab is used by OS
;(global-set-key (kbd "M-g") 'call-keyword-completion) ???
;; Hard-wrap/un-hard-wrap paragraph
;(global-set-key (kbd "M-q") 'compact-uncompact-block) ???

;;;; EMACS'S SPECIAL COMMANDS
;; Cancel
(global-set-key (kbd "M-k") 'keyboard-escape-quit)
;; Mark point
(global-set-key (kbd "C-SPC") 'set-mark-command)
(global-set-key (kbd "M-a") 'execute-extended-command)
(global-set-key (kbd "M-A") 'shell-command)

;;;; WINDOW SPLITTING
;(global-set-key (kbd "M-r") 'move-cursor-next-pane)
;(global-set-key (kbd "M-R") 'move-cursor-previous-pane)

;;;; OTHER SHORTCUTS
;(global-set-key (kbd "M-~") 'switch-to-previous-frame)
;(global-set-key (kbd "M-`") 'switch-to-next-frame)

;(global-set-key (kbd "M-8") 'extend-selection)
;(Global-set-key (kbd "M-*") 'select-text-in-quote)








(global-set-key (kbd "M-m") 'isearch-forward)
(global-set-key (kbd "M-M") 'isearch-backward)

(global-set-key (kbd "M-SPC") 'hippie-expand)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-'") 'switch-to-buffer)
;(global-set-key (kbd "M-,") 'previous-buffer)
;(global-set-key (kbd "M-.") 'next-buffer)
(global-set-key (kbd "M-g") 'goto-line)

(global-set-key (kbd "M-,") 'tabbar-backward)
(global-set-key (kbd "M-.") 'tabbar-forward)
(global-set-key (kbd "M-<") 'tabbar-backward-group)
(global-set-key (kbd "M->") 'tabbar-forward-group)
(global-set-key (kbd "<menu>") 'tabbar-press-home)

;;END

;;New layout
;;(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "colemak")
;; load ErgoEmacs keybinding
;;(load "~/.emacs.d/ergoemacs-keybindings-5.3.4/ergoemacs-mode")
;; turn on minor mode ergoemacs-mode
;;(ergoemacs-mode 1)

(global-set-key (kbd "M-/") 'iedit-mode)
(global-set-key (kbd "M-?") 'query-replace)
;;(global-set-key (kbd "M-?") 'query-replace-regexp)
(global-set-key (kbd "M-\\") 'delete-window)
(global-set-key (kbd "M-|") 'delete-other-windows)
(global-set-key (kbd "M-:") 'split-window-vertically)
(global-set-key (kbd "M-;") 'split-window-horizontally)
(global-set-key (kbd "M-r") 'align-regex)
(global-set-key (kbd "M-]") 'kill-buffer)
(global-set-key (kbd "M-}") 'kill-buffer-and-window)

(global-set-key (kbd "M-q") 'goto-match-paren)
(global-set-key (kbd "M-Q") 'rainbow-delimiters-mode)
(global-set-key (kbd "M-j") 'my-anything)

(global-set-key (kbd "M-<insert>") 'linum-mode)
(global-set-key (kbd "M-<end>") 'whitespace-mode)

(global-set-key (kbd "M-<home>") '(lambda nil (interactive) (defaultface)))
(global-set-key (kbd "M-+") '(lambda nil (interactive) (zoomableface)))
(global-set-key (kbd "M-=") '(lambda nil (interactive) (zoom 1)))
(global-set-key (kbd "M-<delete>") 'auto-indent-mode)

(global-set-key (kbd "M-[") 'winner-undo)
(global-set-key (kbd "M-{") 'winner-redo)
; _________________________________________________________________________________________________________________________________________________________________________________________________
;|`           |1             |2           |3           |4           |5           |6           |7           |8           |9           |0           |-           |=           |Backspace             |
;|            |              |            |            |            |            |            |            |            |            |            |            |zoom        |                      |
;|~           |!             |@           |#           |$           |%           |^           |&           |*           |(           |)           |_           |+           |                      |
;|            |              |            |            |            |            |            |            |            |            |            |            |zoomable    |                      |
;|____________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|______________________|
;|TAB                |q             |w           |ef          |rp          |tg          |yj          |ul          |iu          |oy          |p;          |[           |]           |<_|            |
;|                   |goto-m-paren  |copy-region |<del-wrd    |del-wrd>    |goto-line   |anything    |<-W         |^           |W->         |splt-w-vert |winner-undo |kill-buf    |               |
;|                   |rainbow-delim |            |            |            |            |            |<-P         |/\          |P->         |splt-w-hori |winner-redo |kill-buf+win|               |
;|                   |              |            |            |            |            |            |            |            |            |            |            |            |               |
;|___________________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|__             |
;|Cpslock               |a             |sr          |ds          |ft          |gd          |h           |jn          |ke          |li          | o          |'           |\           |            |
;|                      |exe-command   |align-regex |<del-chr    |del-chr>    |kill-line   |>>|         |<-          |v           |->          |other-window|switch-t-buf|del-window  |            |
;|                      |exe-shell     |            |            |            |killwholline||<<         ||<-         |\/          |->|         |            |            |del-o-window|            |
;|                      |              |            |            |            |            |            |            |            |            |            |            |            |            |
;|______________________|______________|____________|____________|____________|___________(#)___________|____________|____________|____________|____________|____________|____________|____________|
;|Shift           |-             |z           |x           |c           |v           |b           |nk          |m           |,           |.           |/           |Shift                          |
;|                |              |undo        |            |            |            |toggle-case |cancel      |isearch-forw|prev-buffer |next-buffer |iedit       |                               |
;|                |              |redo        |            |            |            |            |            |isearch-back|            |            |query-replac|                               |
;|                |              |undo        |            |            |            |            |            |            |            |            |            |                               |
;|________________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|_______________________________|
;|Fn          |Ctrl              |S          |Alt        |SPC                                                               |AltGr       |[=]         |Ctrl        |                               |
;|            |                  |           |           |hippie-expand                                                     |            |Tabbar-menu |            |                               |
;|            |                  |           |           |                                                                  |            |            |            |                               |
;|            |                  |           |           |                                                                  |            |            |            |                               |
;|____________|__________________|___________|___________|__________________________________________________________________|____________|____________|____________|_______________________________|



;____________________________________________________
;|insert      |delete      |home        |end         |
;|linum       |auto-indent |def-face    |whitespace-m|
;|            |            |            |            |
;|            |            |            |            |
;|____________|____________|____________|____________|










;;______________________________________________________________________________
;;Settings
;;______________________________________________________________________________
(setq inhibit-startup-message t)
(setq default-frame-alist (append (list
  '(width  . 80)  ; Width set to 80 characters
  '(height . 40)) ; Height set to 60 lines
  default-frame-alist))
(setq frame-title-format "%b")
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default show-trailing-whitespace t)
(set-face-attribute
 'trailing-whitespace nil
 :background "gray60")

(column-number-mode t)
(display-battery-mode t)
(show-paren-mode t)
(tool-bar-mode 0)
(global-linum-mode t)
(winner-mode 1)
;;______________________________________________________________________________
;;Startup
;;______________________________________________________________________________
(setq inhibit-startup-message t)
(defun display-startup-echo-area-message ()
  (message ""))
(find-file "~/.emacs")
;(switch-to-buffer "blank")
(kill-buffer "*scratch*")
(kill-buffer "*Messages*")

;;______________________________________________________________________________
;;Font
;;______________________________________________________________________________
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
 '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "Schumacher" :family "Clean")))))

;;______________________________________________________________________________
;;Theme
;;______________________________________________________________________________
(require 'color-theme)
(set-background-color "grey30")
(set-foreground-color "honeydew1")

;(set-face-background 'menubar "slate gray")
;(set-face-attribute 'menubar nil :box nil)


(set-face-background 'modeline "slate gray")
(set-face-attribute 'mode-line nil :box nil)
;(set-background-color "black")
;(set-face-background 'default "black")
;(set-face-background 'region "black")
;(set-face-foreground 'default "white")
;(set-face-foreground 'region "gray60")
;(set-foreground-color "white")
;(set-cursor-color "red")
;(set-cursor-color "cyan")


;;______________________________________________________________________________
;;Rainbow delimiters
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/")
(require 'rainbow-delimiters)
;;(require 'color-theme-tomorrow)
;;(setq-default frame-background-mode 'dark)

(set-face-attribute
 'rainbow-delimiters-depth-1-face nil
 :foreground "honeydew1")

(set-face-attribute
 'rainbow-delimiters-depth-2-face nil
 :foreground "LightSkyBlue1")

(set-face-attribute
 'rainbow-delimiters-depth-3-face nil
 :foreground "DarkSlateGray1")

(set-face-attribute
 'rainbow-delimiters-depth-4-face nil
 :foreground "OliveDrab1")

(set-face-attribute
 'rainbow-delimiters-depth-5-face nil
 :foreground "SteelBlue1")

(set-face-attribute
 'rainbow-delimiters-depth-6-face nil
 :foreground "chartreuse1")

(set-face-attribute
 'rainbow-delimiters-depth-7-face nil
 :foreground "MediumOrchid2")

(set-face-attribute
 'rainbow-delimiters-depth-8-face nil
 :foreground "tan1")

(set-face-attribute
 'rainbow-delimiters-depth-9-face nil
 :foreground "magenta1")

(set-face-attribute
 'rainbow-delimiters-unmatched-face nil
 :foreground "red")
;(((((((((())))))))))

(rainbow-delimiters-mode 1)


;(show-paren-mode t)
;(show-paren-delay 0)
;(show-paren-style 'expression)
;(set-face-background 'show-paren-match-face "#aaaaaa")
;(set-face-attribute 'show-paren-match-face nil
;                    :weight 'bold :underline nil : overline nil :slant 'normal)
;(set-face-foreground 'show-paren-mismatch-face "red")
;(set-face-attribute 'show-paren-mismatch-face nil
;                    :weight 'bold :underline t :overline nil : slant 'normal)



;;______________________________________________________________________________
;;Console
;;______________________________________________________________________________
(xterm-mouse-mode t)


;;______________________________________________________________________________
;;Indentation
;;______________________________________________________________________________
(setq standard-indent 4)
(setq-default indent-tabs-mode nil)
(setq tab-always-indent 'complete)

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


(setq c-mode-hook
      (function (lambda ()
                  (setq indent-tabs-mode nil)
                  (setq c-indent-level 4))))
(setq objc-mode-hook
      (function (lambda ()
                  (setq indent-tabs-mode nil)
                  (setq c-indent-level 4))))
(setq c++-mode-hook
      (function (lambda ()
                  (setq indent-tabs-mode nil)
                  (setq c-indent-level 4))))
;;______________________________________________________________________________
;;Auto-indent
;;______________________________________________________________________________
(require 'auto-indent)

;;______________________________________________________________________________
;;Auto-save
;;______________________________________________________________________________
(setq auto-save-default 1)
(setq auto-save-visited-file-name nil) ;;Dont save to current file
(setq delete-auto-save-files 1) ;;Delete autosaves on save
(setq check-auto-save 1) ;;check wether autosave is the most recent on revert-buffer
;(require 'auto-save)

(setq backup-by-copying t)
(setq auto-save-list-file-prefix "~/Dropbox/emacs/autosaves/")

;;______________________________________________________________________________
;;Backups
;;______________________________________________________________________________
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/Dropbox/emacs/backups"))))
(setq delete-old-versions t)

;;______________________________________________________________________________
;;Buffers
;;______________________________________________________________________________
(setq default-major-mode 'text-mode)

;;Highlight lines
;(global-hl-line-mode 1)


;;______________________________________________________________________________
;;Cursor
;;______________________________________________________________________________
(setq default-cursor-type 'box)
(defadvice overwrite-mode (after overwrite-mode)
  (if overwrite-mode
      (setq cursor-type '(bar . 1))
    (setq cursor-type 'box)))
(ad-activate 'overwrite-mode)


;;______________________________________________________________________________
;;Highlights
;;______________________________________________________________________________

;(add-hook 'emacs-lisp-mode-hook
;          (lambda ()
;            (font-lock-add-keywords nil
;                                    '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
;(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face empty tabs lines-tail trailing))
;(global-whitespace-mode t)

;;______________________________________________________________________________
;;DTRT-INDENT
;;______________________________________________________________________________
(add-hook 'c-mode-common-hook
          (lambda()
            (require 'dert-indent)
            (dtrt-indent-mode t)))
;;______________________________________________________________________________
;;Save position between sessions
;;______________________________________________________________________________
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;;______________________________________________________________________________
;;Iedit
;;______________________________________________________________________________
(require 'iedit)




































;;______________________________________________________________________________
;;
;;
;;                                    MODES
;;
;;______________________________________________________________________________


;;______________________________________________________________________________
;;ANYTHING
;;______________________________________________________________________________
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)
;(require 'anything-config)
(defun my-anything ()
  (interactive)
  (anything-other-buffer 
   '(anything-c-source-buffers+
     anything-c-source-recentf
     anything-c-source-files-in-current-dir+
     ;anything-c-source-locate
     ;anything-c-source-man-pages
     ;anything-c-source-info-libc
     ;anything-c-source-emacs-commands
     ;anything-c-source-emacs-functions
     ;anything-c-source-emacs-variables
     )
                         "*my-anything*"))


;;______________________________________________________________________________
;;ARTIST MODE
;;______________________________________________________________________________
(autoload 'artist-mode "artist" "Enter artist-mode" t)

;;______________________________________________________________________________
;;Babel
;;______________________________________________________________________________
(autoload 'babel "babel" nil t)
(autoload 'babel-region "babel" nil t)
(autoload 'babel-as-string "babel" nil t)
(autoload 'babel-buffer "babel" nil t)

;;______________________________________________________________________________
;;Flyspell
;;______________________________________________________________________________
(setq flyspell-issue-welcome-flag nil)


;;______________________________________________________________________________
;;FULL-ACK
;;______________________________________________________________________________
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;;______________________________________________________________________________
;;HIPPIE_EXPAND
;;______________________________________________________________________________
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially

                                         try-complete-lisp-symbol))

;;______________________________________________________________________________
;;IDO
;;______________________________________________________________________________
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-file-extension-order '("/" ".tex" ".emacs" ".txt" ".py" ".cfg" ".c" ".h" ".asm" ".xml" ".org"))
(ido-mode 1)
;;______________________________________________________________________________
;;JABBER
;;______________________________________________________________________________
(add-to-list 'load-path "/home/pilen/.emacs.d/emacs-jabber-0.8.0/")
(require 'jabber-autoloads)

;;______________________________________________________________________________
;;LaTeX
;;______________________________________________________________________________
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)

;;______________________________________________________________________________
;;SML
;;______________________________________________________________________________
;; Aktiver sml-mode
(add-to-list 'load-path "~/.emacs.d/sml-mode-4.1/")
(require 'sml-mode)
(setq auto-mode-alist (cons '("\\.sml$" . sml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sig$" . sml-mode) auto-mode-alist))
(add-hook 'sml-mode-hook 
          (lambda() ;;; *** SML-mode Customization 
	    (setq sml-program-name "mosml")
	    (setq sml-default-arg "-P full")
	    (setq sml-indent-level 2)        ; conserve on horizontal space
	    (setq words-include-escape t)    ; \ loses word break status
	    (setq indent-tabs-mode nil)))    ; never ever indent with tabs

;;______________________________________________________________________________
;;TabBar
;;______________________________________________________________________________

(require 'tabbar)
(set-face-attribute
 'tabbar-default nil
 :background "gray30")
(set-face-attribute
 'tabbar-unselected nil
 :background "gray60"
 :foreground "gray30"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "#f2f2f6"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
 'tabbar-separator nil
 :height 0.7)

(tabbar-mode 1)










;;______________________________________________________________________________
;;
;;
;;                                 FUNCTIONALITY
;;
;;______________________________________________________________________________

;; someday might want to rotate windows if more than 2 of them
(defun swap-windows ()
 "If you have 2 windows, it swaps them." (interactive) (cond ((not (= (count-windows) 2)) (message "You need exactly 2 windows to do this."))
 (t
 (let* ((w1 (first (window-list)))
	 (w2 (second (window-list)))
	 (b1 (window-buffer w1))
	 (b2 (window-buffer w2))
	 (s1 (window-start w1))
	 (s2 (window-start w2)))
 (set-window-buffer w1 b2)
 (set-window-buffer w2 b1)
 (set-window-start w1 s2)
 (set-window-start w2 s1)))))

;;
;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (new-name)
 "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
 (let ((name (buffer-name))
	(filename (buffer-file-name)))
 (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
 (if (get-buffer new-name)
	 (message "A buffer named '%s' already exists!" new-name)
	(progn 	 (rename-file name new-name 1) 	 (rename-buffer new-name) 	 (set-visited-file-name new-name) 	 (set-buffer-modified-p nil))))))

;; Never understood why Emacs doesn't have this function, either.
;;
(defun move-buffer-file (dir)
 "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
 (let* ((name (buffer-name))
	 (filename (buffer-file-name))
	 (dir
	 (if (string-match dir "\\(?:/\\|\\\\)$")
	 (substring dir 0 -1) dir))
	 (newname (concat dir "/" name)))

 (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
 (progn 	(copy-file filename newname 1) 	(delete-file filename) 	(set-visited-file-name newname) 	(set-buffer-modified-p nil) 	t)))) 


(defun geosoft-forward-word () 
   ;; Move one word forward. Leave the pointer at start of word 
   ;; instead of emacs default end of word. Treat _ as part of word 
   (interactive) 
   (forward-char 1) 
   (backward-word 1) 
   (forward-word 2) 
   (backward-word 1) 
   (backward-char 1) 
   (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word)) 
         (t (forward-char 1)))) 

(defun geosoft-backward-word () 
   ;; Move one word backward. Leave the pointer at start of word 
   ;; Treat _ as part of word 
   (interactive) 
   (backward-word 1) 
   (backward-char 1) 
   (cond ((looking-at "_") (geosoft-backward-word)) 
         (t (forward-char 1)))) 

(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Toggles from 3 cases: UPPER CASE, lower case, Title Case,
in that cyclic order."
  (interactive)

  (let (pos1 pos2 (deactivate-mark nil) (case-fold-search nil))
    (if (and transient-mark-mode mark-active)
        (setq pos1 (region-beginning)
              pos2 (region-end))
      (setq pos1 (car (bounds-of-thing-at-point 'word))
            pos2 (cdr (bounds-of-thing-at-point 'word))))

    (when (not (eq last-command this-command))
      (save-excursion
        (goto-char pos1)
        (cond
         ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps") )
         ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps") )
         (t (put this-command 'state "all lower") )
         )
        )
      )

    (cond
     ((string= "all lower" (get this-command 'state))
      (upcase-initials-region pos1 pos2) (put this-command 'state "init caps"))
     ((string= "init caps" (get this-command 'state))
      (upcase-region pos1 pos2) (put this-command 'state "all caps"))
     ((string= "all caps" (get this-command 'state))
      (downcase-region pos1 pos2) (put this-command 'state "all lower"))
     )
    )
  )

;;______________________________________________________________________________
;;Jump to mathcing parethesis
;;______________________________________________________________________________

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        ;(t (self-insert-command (or arg 1)))))
        ))



;;______________________________________________________________________________
;;ZOOM
;;______________________________________________________________________________

(defun defaultface ()
  (interactive)
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "Schumacher" :family "Clean")))))
)


(defun zoomableface ()
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 80 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
)

(defun zoom (n)
  "With positive N, increase the font size, otherwire decrease it"
  (set-face-attribute 'default (selected-frame) :height
                      (+ (face-attribute 'default :height) (* (if (> n 0) 1 -1) 10))
                     ;(+ (face-attribute 'default :height) 10)))
))
