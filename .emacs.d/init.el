; __________   ___________________________________________   ___________________________________________   ___________________________________________  ___________________________________________
;|Esc       | |F1        |F2        |F3        |F4        | |F5        |F6        |F7        |F8        | |F9        |F10       |F11       |F12       ||insert    |delete    |home      |end       |
;|          | |help      |flyspl    |mcro-start|mcro-end/c| |revert-bu |          |dedic-win |narrow-ind| |cmd-center|reftex-toc|tex-insenv|prev-latex||hl-line   |whitespace|deflt-face|zoom      |
;|          | |man       |flyspl-dic|mcro-name |          | |          |          |          |narrow-fun| |          |          |tex-clsenv|prev-clear||linum     |autoindent|          |zoomable  |
;|          | |          |          |          |          | |          |          |          |          | |          |          |          |          ||          |          |          |          |
;|__________| |__________|__________|__________|__________| |__________|__________|__________|__________| |__________|__________|__________|__________||__________|__________|__________|__________|
; _________________________________________________________________________________________________________________________________________________________________________________________________
;|`           |1             |2           |3           |4           |5           |6           |7           |8           |9           |0           |λ           |=           |Backspace             |
;|flymake-next|bread-set     |bread-prev  |bread-next  |fill-par    |            |            |fold        |fwd-syntax  |begn-defun  |end-defun   |find-tag    |pop-tag-mark|join-line             |
;|~           |!             |@           |#           |$           |%           |^           |&           |*           |(           |)           |π           |+           |                      |
;|flymake     |              |            |bread-list  |            |            |            |fold-column |bwd-syntax  |smart-backw |smart-forw  |tags-apropos|            |                      |
;|____________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|______________________|
;|TAB                |q             |w           |ef          |rp          |tg          |yj          |ul          |iu          |oy          |p;          |[           |]           |<_|            |
;|goto-match-paren   |mc-next-like  |copy-region |<del-wrd    |del-wrd>    |compile/run |recent-file |<-W         |^           |W->         |splt-w-vert |winner-undo |golden-ratio|ido-sw-buf     |
;|focus-minibuffer   |mc-edit-lines |            |transpose-up|transpose-dn|transpos-wrd|find-file-at|pager-row-up|/\          |pager-row-dn|splt-w-hori |winner-redo |gldn-rat-tog|ido-goto-sym/ln|
;|                   |mc-all-like   |            |            |            |            |            |            |            |            |            |            |balance-win |               |
;|___________________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|__             |
;|Cpslock               |a             |sr          |ds          |ft          |gd          |h           |jn          |ke          |li          | o          |'           |\           |            |
;|                      |exe-command   |comment-togl|<del-chr    |del-chr>    |killwholline|>>|         |<-          |v           |->          |other-window|win-switch  |del-window  |            |
;|                      |exe-shell     |align-regexp|            |            |new-scratch ||<<         ||<-         |\/          |->|         |prev-window |win-80col   |del-o-window|            |
;|                      |              |            |            |            |            |            |            |            |            |            |            |            |            |
;|______________________|______________|____________|____________|____________|___________(#)___________|____________|____________|____________|____________|____________|____________|____________|
;|Shift           |-             |z           |x           |c           |v           |b           |nk          |m           |,           |.           |/           |Shift                          |
;|                |expand-region |undo        |xpdf-glo-up |ace-jmp-wd-l|goto-last-ch|toggle-case |erc         |isearch-forw|ahs-sym-bck |ahs-sym-fwd |query-replac|                               |
;|                |contrct-region|            |xpdf-glo-dn |ace-jmp-wd-g|pop-to-mark |caps-mode   |            |sprint      |ahs-def-bck |ahs-def-fwd |iedit       |                               |
;|                |              |undo        |            |            |            |            |            |            |            |            |            |                               |
;|________________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|_______________________________|
;|Fn          |Ctrl              |S          |Alt        |SPC                                                               |AltGr       |[=]         |Ctrl        |                               |
;|            |                  |           |           |hippie-expand                                                     |            |idobuffer   |            |                               |
;|            |                  |           |           |mark-paragraph                                                    |            |Tabbar-menu |            |                               |
;|            |                  |           |           |                                                                  |            |menu-bar    |            |                               |
;|____________|__________________|___________|___________|__________________________________________________________________|____________|____________|____________|_______________________________|

;;______________________________________________________________________________
;;
;;
;π                                    TODO
;;
;;______________________________________________________________________________

;;;; Regressions in updating 24.5 to 25.1:
;; jdee mode no longer works
;; eldoc can print in modeline? Is this bad
;; eldoc slow
;; linum mode extremely slow
;;   ag is extremely slow (due to linum)
;; scrolling in big buffers very slow (eg .emacs.d/config
;; Focus of opened windows is wonky
;; Arduino

;;;; Build the perfect editor!
;; speedbar + ibuffer like behaviour
;; maybe a project like file
;; an outline?
;; http://leoeditor.com/
;; Build and extend the editor based on what you are doing
;; A bit like acme
;; Macros are to 'small'
;; Lispcode is a one time write thing (for modes and stuff)


;;;; Things to look into/examine
;; Port to Emacs 24
;; Code navigation
;; Code folding
;; cedet
;; magit
;; Windownavigation/manipulation
;; mail
;; org-mode
;;   org-agenda http://www.aaronbedra.com/emacs.d/#org-agenda
;; minimap
;; eshell ido ctrl-r
;;     call (eshell-save-some-history), ido on eshell-history-file-name, insert result into eshell
;; C/C++ - http://tuhdo.github.io/c-ide.html
;; I want to go home/to diku http://labs.rejseplanen.dk/labs/data__brug/rejseplanens_api/

;; look at define-keys last arg

;; Lookup stackoverflow (Could be cool)
;; https://atom.io/packages/ask-stack
;; https://github.com/gleitz/howdoi
;; https://github.com/atykhonov/emacs-howdoi

;; windowmanager
;; xpdfremote
;; Pagefitted coding
;; Move by syllable. http://www.tug.org/docs/liang/ http://usuallyalex.wordpress.com/2009/06/15/detecting-syllables-programatically/
;; autofix wrongtype of delimiters ([)) -> ([]) when typing closing delimiter

;; browse-kill-ring

;; Semantic highlight? https://medium.com/@evnbr/coding-in-color-3a6db2743a1e


;;;;;; Updates to emacs
;;;; 24.3 Look at
;; set-temporary-overlay-map
;; python-shell-send-buffer
;; wavy underline
;; erc notifications

;;;; 24.4
;; Cursor only blinks 10 times?! blink-cursor-blink
;; electric-indent-mode is on by default
;; look at cycle-spacing
;; look at C-x spc
;; isearch-forward-symbol-at-point
;; or take a look at the smart scan package instead.
;; look at todo mode
;; look at trace-function
;; look at superword-mode and subword-mode
;; look at define-alternatives
;; look at subr-x.el
;; FIX sr-speedbar!!!!
;; FIX load-path
;; set load-prefer-newer to t
;; look at defvar-local and setq-local
;; look at get-lru-window and get-mru-window
;; set-temporary-overlay-map


;; Delete entire word under cursor

;; Deletemode?, all movement deletes


;;;; Contextaware button (context should be inserted before action is completed)
;; search -> repeat search
;; compile latex -> view latex/update xpdf
;; M-x -> repeat last command

;; checkdoc your elisp code

;; Look into: (cool features of emacs not yet explored)
;; initial-buffer-choice
;; blink-cursor-blinks
;; split-window change!
;; eval-defun use this!
;; read-regexp-defaults-function
;; load-prefer-newer
;; C-x TAB (indent-rigidly)
;; electric-indent-mode enabled by default
;; tab-stop-list
;; cycle-spacing
;; try out electric pairing with electric-pair-preserve-balance and electric-pair-delete-adjacent-pairs
;; remember-notes
;; eww BUILD IN BROWSER!!!!!!!!
;; define-alternatives
;; subr-x.el
;; :distant-foreground
;; expand-file-name

;; paredit
;; restclient
;; web-mode

;;;;;; If you ever get to code:
;;;; Clojure:
;; https://github.com/clojure-emacs/cider
;;
;;;; Common lisp:
;; https://github.com/capitaomorte/sly
;;

;; fix forward-word-to-newline
;; can use forward-word now

;; Auto-highlight-symbol virker ikke!!!!!!!!!!!!
;; powerline-percent-xpm virker ikke i modeline!!!!
;; Spring-forward virker ikke!!!
;;                ;; (:eval (powerline-percent-xpm 'text nil powerline-color1)) ;; TODO make me work

;; https://github.com/Valloric/YouCompleteMe commpletions in vim




;; https://github.com/knupfer/haskell-emacs
;; https://commercialhaskell.github.io/intero/

;; integrate ag (or ack) to do almost live searching
;; helm-projectile-ag


;; skewer, for integrating with webbrowser/javascript
;; http://nullprogram.com/blog/2012/10/31/
;; http://www.50ply.com/blog/2012/08/13/introducing-impatient-mode/


;; swiper - search results in buffer, spaces in search query are separate groups
;; stuff from http://oremacs.com/

;; In settings.el
;; Should c-eldoc be reenabled?
;; ;; (require 'c-eldoc)
;; ;; (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)



;; Create a python mode
;; Elpy is not ideal
;; Create a custom mode using some of elpy's functionality
;; Should it use the default python.el or python-mode.el?
;;
;; python - elpy with jedi or rope
;;     http://www.reddit.com/r/emacs/comments/2g3sbf/recommendations_for_python_ide_under_emacs/
;; Projectile?
;; eval-buffer
;; eval-region
;; eval-block (newline,char (not comment), to next newline,char)
;; eval-statement
;; eval-project
;; browse documentation, from code/project, or from web
;; goto-definition (not only for projects loaded)
;; 2to3 helper



;; http://www.wilfred.me.uk/blog/2015/03/19/adding-a-new-language-to-emacs/
;; http://www.wilfred.me.uk/blog/2016/04/28/effortless-major-mode-development/
;; http://www.wilfred.me.uk/blog/2014/09/27/the-definitive-guide-to-syntax-highlighting/

;; http://www.wilfred.me.uk/blog/2013/03/31/essential-elisp-libraries/


;; Create / find a better color-picker
;; Tried emacs-colorpicker https://github.com/syohex/emacs-colorpicker not in melpa, uses python script with dependencies
;; zenity-color-picker uses zentiy, not nice


;; Use xdotool to interact with other programs
;; IE, remote control evince instead of xpdf
;; xdotool search "evince"
;; xdotool windowactivate --sync 12582920; xdotool key Next
;; xdotool windowactivate --sync 33554435;xdotool key ctrl+l; xdotool type 10; xdotool key KP_Enter



;; css-autoprefixer
;; cquery

;;______________________________________________________________________________
;;
;;
;π                                DEPENDENCIES
;;
;;______________________________________________________________________________

;; erlang
;; gnuplot
;; auctex
;; gtags (global)
;; w3m (optional)
;; emacs-w3m (optional)
;; email.el : (setq my-email-address "...")
;; aspell, aspell-en, aspell-da (aur)
;; emacs-python-mode - should start using elpa

;;______________________________________________________________________________
;;
;;
;π                                KEYBINDINGS
;;
;;______________________________________________________________________________

;; Nice to remember keys:
;; C-l          scroll line to top/center/bottom
;; C-x -        Shrink window to buffersize

;; C-x r k      Kill (cut) rectangle
;; C-x r M-w    Copy rectangle
;; C-x r y      Yank (paste) rectangle
;; C-x r o      Open (insert spaces into selection)
;; C-x r c      Clear (overwrite selection with spaces)
;; C-x r t      Replace (replace selection with user text)
;; C-x r N      Numerate lines
;; C-u Cx r N   Numerate lines prompting starting number

;; M-z          zap to char
;; M-SPC        fixup-whitespace

;; C-s C-w      Search for word at point
;; C-s C-s      C-s repeats the last search term when searching

;; C-M-Space    Mark-sexp

;; C-x C-x      swap mark and point

;; C-u C-space  Jump back

;; C-j          newline-and-indent


;; C-y          yank-or-pop
;; C-Y          yank
;; C-H-y        yank primary

;; M-next       scroll-other-window
;; M-prev       scroll-other-window-down

;; C-x `        next-error


;; Debug on errors in .emacs

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq debug-on-error t)
(setq load-prefer-newer t)
(byte-recompile-directory "~/.emacs.d/" 0)
;; (byte-recompile-directory "~/.emacs.d/" 0 t) ;; force all

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/my-plugins")
;;______________________________________________________________________________
;π Settings
;;______________________________________________________________________________
(load-file "~/.emacs.d/config/my-packages.el")

(load-file "~/.emacs.d/.private.el")

(load-file "~/.emacs.d/config/keybindings.el")
(load-file "~/.emacs.d/config/settings.el") ;; what is fuzzy?, smex?
(load-file "~/.emacs.d/config/command-center.el")
(load-file "~/.emacs.d/config/compile.el")
(load-file "~/.emacs.d/config/custom.el")
(load-file "~/.emacs.d/config/indentation.el")
(load-file "~/.emacs.d/config/modeline.el")
(load-file "~/.emacs.d/config/theme.el")
(load-file "~/.emacs.d/config/help.el")
(load-file "~/.emacs.d/config/whitespace.el")
(load-file "~/.emacs.d/config/windows.el")


;;______________________________________________________________________________
;π LANGUAGES
;;______________________________________________________________________________
(load-file "~/.emacs.d/config/c-programming.el")
(load-file "~/.emacs.d/config/erlang.el")
(load-file "~/.emacs.d/config/haskell.el")
(load-file "~/.emacs.d/config/latex.el") ;; use elpa instead?
(load-file "~/.emacs.d/config/lisp.el")
(load-file "~/.emacs.d/config/python.el") ;; todo!!
(load-file "~/.emacs.d/config/scala.el")
(load-file "~/.emacs.d/config/sml.el")

;;______________________________________________________________________________
;π MODES
;;______________________________________________________________________________
(load-file "~/.emacs.d/config/ace-jump.el")
;; (load-file "~/.emacs.d/config/anything.el") ;; Should use helm instead
(load-file "~/.emacs.d/config/auto-highlight-symbol.el") ;; disable in help buffer
(load-file "~/.emacs.d/config/auto-insert.el")
(load-file "~/.emacs.d/config/erc.el") ;; todo
(load-file "~/.emacs.d/config/eshell.el")
(load-file "~/.emacs.d/config/expand-region.el") ;; + smart-forward look into this
(load-file "~/.emacs.d/config/flymake.el")
(load-file "~/.emacs.d/config/flyspell.el")
(load-file "~/.emacs.d/config/debugger.el")
(load-file "~/.emacs.d/config/auto-completion.el")
(load-file "~/.emacs.d/config/ibuffer.el")
(load-file "~/.emacs.d/config/ido.el")
(load-file "~/.emacs.d/config/ido-imenu.el")
(load-file "~/.emacs.d/config/incmove.el") ;; move to my-plugins
(load-file "~/.emacs.d/config/search.el")
(load-file "~/.emacs.d/config/rainbow-delimiters.el")
(load-file "~/.emacs.d/config/shell.el")
(load-file "~/.emacs.d/config/sql.el")
(load-file "~/.emacs.d/config/tabbar.el") ;; not in use
(load-file "~/.emacs.d/config/tags.el")
(load-file "~/.emacs.d/config/web.el")
(load-file "~/.emacs.d/config/w3m.el") ;; not in use
(load-file "~/.emacs.d/config/wanderlust.el") ;; not in use

(load-file "~/.emacs.d/config/other-modes.el") ;; look into fastnav full-ack

;;______________________________________________________________________________
;π FUNCTIONALITY
;;______________________________________________________________________________
(load-file "~/.emacs.d/config/functionality.el")
(load-file "~/.emacs.d/config/frame.el")
(load-file "~/.emacs.d/config/horizontal-scroll.el")
(load-file "~/.emacs.d/config/matching-parenthesis.el")
(load-file "~/.emacs.d/config/movement.el")
(load-file "~/.emacs.d/config/narrow.el")
(load-file "~/.emacs.d/config/scratch.el")
(load-file "~/.emacs.d/config/smartscan.el")
(load-file "~/.emacs.d/config/zoom.el")
(load-file "~/.emacs.d/config/symbols.el")

(require 'vagrant)

(load-file "~/.emacs.d/config/revy.el")
(load-file "~/.emacs.d/my-plugins/arduinel.el")


;; End of .emacs, go away debugger!
(setq debug-on-error t)
(setq debug-on-quit nil)

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
    (forge ace-jump-mode ace-window ag all-the-icons arduino-mode auctex auto-highlight-symbol buffer-move c-eldoc column-marker company-go company-jedi company-quickhelp csv-mode dimmer diredfl dtrt-indent elpy ensime erc-hl-nicks fastnav fill-column-indicator flymake-cursor full-ack fuzzy geiser ghc golden-ratio google-translate goto-last-change graphviz-dot-mode highlight-tail hlinum idomenu iedit impatient-mode inf-ruby ivy-xref jss keyfreq kite less-css-mode livid-mode loccur lorem-ipsum magit markdown-mode matlab-mode memory-usage mic-paren minesweeper multiple-cursors nav neotree notmuch pager paredit powerline projectile python-mode quack rainbow-delimiters rfringe smart-forward smex sml-mode sr-speedbar swiper tabbar typescript-mode typing visible-mark volatile-highlights web web-mode win-switch window-numbering wrap-region zeal-at-point)))
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
