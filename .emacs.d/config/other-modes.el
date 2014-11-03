;;______________________________________________________________________________
;;
;;
;π                                   MODES
;;
;;______________________________________________________________________________




;;______________________________________________________________________________
;π ARTIST MODE
;;______________________________________________________________________________
(autoload 'artist-mode "artist" "Enter artist-mode" t)


;;______________________________________________________________________________
;π BABEL
;;______________________________________________________________________________
(autoload 'babel "babel" nil t)
(autoload 'babel-region "babel" nil t)
(autoload 'babel-as-string "babel" nil t)
(autoload 'babel-buffer "babel" nil t)


;;______________________________________________________________________________
;π BREADCRUMB
;;______________________________________________________________________________
(require 'breadcrumb)


;;______________________________________________________________________________
;π FASTNAV
;;______________________________________________________________________________
(require 'fastnav)


;;______________________________________________________________________________
;π FULL-ACK
;;______________________________________________________________________________
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)


;;______________________________________________________________________________
;π FUN
;;______________________________________________________________________________
(load-file "~/.emacs.d/plugins/minesweeper-mode.el")
(require 'reddit)
(require 'typing)
(setq tetris-score-file "~/.emacs.d/tetris-scores")

(add-hook 'tetris-mode-hook (lambda ()
                              (define-key tetris-mode-map (kbd "n") 'tetris-move-left)
                              (define-key tetris-mode-map (kbd "i") 'tetris-move-right)
                              (define-key tetris-mode-map (kbd "u") 'tetris-rotate-prev)
                              (define-key tetris-mode-map (kbd "e") 'tetris-rotate-next)
                              (define-key tetris-mode-map (kbd "l") 'tetris-rotate-next)
                              (define-key tetris-mode-map (kbd "y") 'tetris-rotate-prev)
                              (define-key tetris-mode-map (kbd "r") 'tetris-start-game)))


;;______________________________________________________________________________
;π GNUPLOT
;;______________________________________________________________________________
(require 'gnuplot)


;;______________________________________________________________________________
;π GRAPHVIZ
;;______________________________________________________________________________
(load-file "~/.emacs.d/plugins/graphviz-dot-mode.el")


;;______________________________________________________________________________
;π IEDIT
;;______________________________________________________________________________
(require 'iedit)


;;______________________________________________________________________________
;π JABBER
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/emacs-jabber-0.8.0/")
(require 'jabber-autoloads)


;;______________________________________________________________________________
;π JAVA
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
(add-to-list 'load-path "~/.emacs.d/my-plugins/jde-hacks")
(setq jde-hacks-dir "~/.emacs.d/my-plugins/jde-hacks")
(require 'jde-hacks)


;;______________________________________________________________________________
;π MINIMAP
;;______________________________________________________________________________
;; (require 'minimap)
;(setq minimap-window-location 'right)
;; (setq minimap-width-fraction 0.8)
;(setq minimap-display-semantic-overlays nil)
;(setq minimap-display-semantic-overlays nil)
;(setq minimap-enlarge-certain-faces nil)
;(setq minimap-normal-height-faces nil)


;(set-face-attribute 'minimap-font-face '((default :family "DejaVu Sans Mono" :height 5)))

(setq outline-view-change-hook nil)


;;______________________________________________________________________________
;π MAPLE
;;______________________________________________________________________________
(autoload 'maple-mode "maple-mode" "Maple-mode" t)
(setq maple-command "/home/pilen/programs/maple16/bin/maple")
(add-to-list 'auto-mode-alist
             '("\\.mw$" . maple-mode))


;;______________________________________________________________________________
;π MATHEMATICA
;;______________________________________________________________________________
(autoload 'math "math" "Starts Mathematica" t)
;(autoload 'math-mode "math" "Mode for editing Mathematica" t)
;(setq auto-mode-alist (cons '("\\.m\\'".math-mode) auto-mode-alist))


;;______________________________________________________________________________
;π MATLAB
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/plugins/matlab-emacs")
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list 'auto-mode-alist
             '("\\.m$" . matlab-mode))
;(setq matlab-indent-function t)
(setq matlab-shell-command "~/programs/MATLAB/R2012a/bin/matlab")


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


;;______________________________________________________________________________
;π SAGE
;;______________________________________________________________________________
(add-to-list 'load-path (expand-file-name "/opt/sage/data/emacs"))
(autoload 'sage "sage")
;(setq sage-command "/opt/sage/sage")
(autoload 'sage-view "sage-view")
(add-hook 'sage-startup-hook 'sage-view 'sage-view-disable-inline-output)
