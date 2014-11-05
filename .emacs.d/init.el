; __________   ___________________________________________   ___________________________________________   ___________________________________________  ___________________________________________
;|Esc       | |F1        |F2        |F3        |F4        | |F5        |F6        |F7        |F8        | |F9        |F10       |F11       |F12       ||insert    |delete    |home      |end       |
;|          | |translate |flyspl    |mcro-start|mcro-end/c| |revert-bu |          |dedic-win |narrow-ind| |cmd-center|reftex-toc|tex-insenv|prev-latex||hl-line   |whitespace|deflt-face|zoom      |
;|          | |          |flyspl-dic|mcro-name |          | |          |          |          |narrow-fun| |          |          |tex-clsenv|prev-clear||linum     |autoindent|          |zoomable  |
;|          | |          |          |          |          | |          |          |          |          | |          |          |          |          ||          |          |          |          |
;|__________| |__________|__________|__________|__________| |__________|__________|__________|__________| |__________|__________|__________|__________||__________|__________|__________|__________|
; _________________________________________________________________________________________________________________________________________________________________________________________________
;|`           |1             |2           |3           |4           |5           |6           |7           |8           |9           |0           |λ           |=           |Backspace             |
;|flymake-next|bread-set     |bread-prev  |bread-next  |fill-par    |            |            |fold        |fwd-syntax  |smart-backw |smart-forw  |find-tag    |pop-tag-mark|join-line             |
;|~           |!             |@           |#           |$           |%           |^           |&           |*           |(           |)           |π           |+           |                      |
;|flymake     |              |            |bread-list  |            |            |            |fold-column |bwd-syntax  |begn-defun  |end-defun   |tags-apropos|            |                      |
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
;; python - elpy with jedi or rope
;;     http://www.reddit.com/r/emacs/comments/2g3sbf/recommendations_for_python_ide_under_emacs/
;; C/C++ - http://tuhdo.github.io/c-ide.html
;; I want to go home/to diku http://labs.rejseplanen.dk/labs/data__brug/rejseplanens_api/

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


;; Debug on errors in .emacs
(setq debug-on-error t)

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
(load-file "~/.emacs.d/config/whitespace.el")
(load-file "~/.emacs.d/config/windows.el")


;;______________________________________________________________________________
;π MODES
;;______________________________________________________________________________
(load-file "~/.emacs.d/config/ace-jump.el")
;; (load-file "~/.emacs.d/config/anything.el") ;; Should use helm instead
(load-file "~/.emacs.d/config/auto-highlight-symbol.el") ;; disable in help buffer
(load-file "~/.emacs.d/config/auto-insert.el")
(load-file "~/.emacs.d/config/erc.el") ;; todo
(load-file "~/.emacs.d/config/erlang.el")
(load-file "~/.emacs.d/config/eshell.el")
(load-file "~/.emacs.d/config/expand-region.el") ;; + smart-forward look into this
(load-file "~/.emacs.d/config/flymake.el")
(load-file "~/.emacs.d/config/flyspell.el")
(load-file "~/.emacs.d/config/haskell.el")
(load-file "~/.emacs.d/config/hippie-expand.el")
(load-file "~/.emacs.d/config/ibuffer.el")
(load-file "~/.emacs.d/config/ido.el")
(load-file "~/.emacs.d/config/ido-imenu.el")
(load-file "~/.emacs.d/config/incmove.el") ;; move to my-plugins
(load-file "~/.emacs.d/config/isearch.el")
(load-file "~/.emacs.d/config/latex.el") ;; use elpa instead?
(load-file "~/.emacs.d/config/python.el") ;; todo!!
(load-file "~/.emacs.d/config/rainbow-delimiters.el")
(load-file "~/.emacs.d/config/shell.el")
(load-file "~/.emacs.d/config/sml.el")
(load-file "~/.emacs.d/config/sql.el")
(load-file "~/.emacs.d/config/tabbar.el") ;; not in use
(load-file "~/.emacs.d/config/tags.el")
(load-file "~/.emacs.d/config/w3m.el") ;; not in use
(load-file "~/.emacs.d/config/wanderlust.el") ;; not in use

(load-file "~/.emacs.d/config/other-modes.el") ;; look into fastnav full-ack

;;______________________________________________________________________________
;π FUNCTIONALITY
;;______________________________________________________________________________
(load-file "~/.emacs.d/config/functionality.el")
(load-file "~/.emacs.d/config/horizontal-scroll.el")
(load-file "~/.emacs.d/config/matching-parenthesis.el")
(load-file "~/.emacs.d/config/movement.el")
(load-file "~/.emacs.d/config/narrow.el")
(load-file "~/.emacs.d/config/scratch.el")
(load-file "~/.emacs.d/config/smartscan.el")
(load-file "~/.emacs.d/config/zoom.el")

;; End of .emacs, go away debugger!
(setq debug-on-error nil)
