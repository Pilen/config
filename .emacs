; __________   ___________________________________________   ___________________________________________   ___________________________________________  ___________________________________________
;|Esc       | |F1        |F2        |F3        |F4        | |F5        |F6        |F7        |F8        | |F9        |F10       |F11       |F12       ||insert    |delete    |home      |end       |
;|          | |flyspell  |flyspl-buf|mcro-start|mcro-end/c| |revert-bu |          |          |narrow-tog| |          |reftex-toc|tex-insenv|prev-latex||linum     |autoindent|def-face  |whitespc-m|
;|          | |          |flyspl-dic|mcro-name |          | |          |          |          |          | |          |          |tex-clsenv|prev-clear||          |          |          |rainbow-de|
;|          | |          |          |          |          | |          |          |          |          | |          |          |          |          ||          |          |          |          |
;|__________| |__________|__________|__________|__________| |__________|__________|__________|__________| |__________|__________|__________|__________||__________|__________|__________|__________|
; _________________________________________________________________________________________________________________________________________________________________________________________________
;|`           |1             |2           |3           |4           |5           |6           |7           |8           |9           |0           |-           |=           |Backspace             |
;|flymake-next|bread-set     |bread-prev  |bread-next  |            |            |            |fold        |jump-back-ta|find-tag    |forward-synt|            |zoom        |                      |
;|~           |!             |@           |#           |$           |%           |^           |&           |*           |(           |)           |_           |+           |                      |
;|flymake     |              |            |bread-list  |            |            |            |fold-column |            |tags-apropos|            |            |zoomable    |                      |
;|____________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|______________________|
;|TAB                |q             |w           |ef          |rp          |tg          |yj          |ul          |iu          |oy          |p;          |[           |]           |<_|            |
;|                   |              |copy-region |<del-wrd    |del-wrd>    |goto-line   |recent-file |<-W         |^           |W->         |splt-w-vert |winner-undo |kill-buf    |               |
;|                   |              |            |transpose-up|transpose-dn|transpos-wrd|find-file-at|pager-row-up|/\          |pager-row-dn|splt-w-hori |winner-redo |kill-buf+win|               |
;|                   |              |            |            |            |            |            |            |            |            |            |            |            |               |
;|___________________|______________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|____________|__             |
;|Cpslock               |a             |sr          |ds          |ft          |gd          |h           |jn          |ke          |li          | o          |'           |\           |            |
;|                      |exe-command   |comment-togl|<del-chr    |del-chr>    |killwholline||<<         |<-          |v           |->          |other-window|win-switch  |del-window  |            |
;|                      |exe-shell     |align-regexp|            |            |new-scratch |>>|         ||<-         |\/          |->|         |tiling-cycle|win-80col   |del-o-window|            |
;|                      |              |            |            |            |            |            |            |            |            |            |            |            |            |
;|______________________|______________|____________|____________|____________|___________(#)___________|____________|____________|____________|____________|____________|____________|____________|
;|Shift           |-             |z           |x           |c           |v           |b           |nk          |m           |,           |.           |/           |Shift                          |
;|                |expand-region |undo        |            |ace-jump-wrd|goto-last-ch|toggle-case |cancel      |isearch-forw|prev-buffer |next-buffer |query-replac|                               |
;|                |contrct-region|redo        |            |ace-jump-lin|idomenu     |caps-mode   |            |sprint      |prv-buf-grp |nxt-buf-grp |iedit       |                               |
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
;;                                    TODO
;;
;;______________________________________________________________________________

;; Port to Emacs 24
;; Code navigation
;; Code folding
;; cedet
;; magit
;; Windownavigation/manipulation
;; mail
;; org-mode
;; minimap


;;______________________________________________________________________________
;;
;;
;;                                Keybindings
;;
;;______________________________________________________________________________

;; Nice to remember keys:
;; C-l          scroll line to top/center/bottom
;; C-x -        Shrink window to buffersize

;; C-x r k      Kill (cut) rectangle
;; C-x r y      Yank (paste) rectangle
;; C-x r o      Open (insert spaces into selection)
;; C-x r c      Clear (overwrite selection with spaces)
;; C-x r t      Replace (replace selection with user text)
;; C-x r N      Numerate lines
;; C-u Cx r N   Numerate lines prompting starting number

;; M-z          zap to char
;; M-SPC        fixup-whitespace

;; C-s C-w      Search for word at point

;; Debug on errors in .emacs
(setq debug-on-error t)



;;______________________________________________________________________________
;;UNBIND
;;______________________________________________________________________________

;; ;; open keyboard shortcut image with F8 key
;; ;(global-set-key (kbd "<f8>")
;; ;  (lambda ()
;; ;    (interactive)
;; ;    (find-file "~/.emacs.d/ergonomic_emacs_layout_qwerty_5.3.4.png")))



;; ;; kicking the habit
;; (global-unset-key (kbd "C-b")) ; backward-char
;; (global-unset-key (kbd "C-f")) ; forward-char
;; (global-unset-key (kbd "C-p")) ; previous-line
;; (global-unset-key (kbd "C-n")) ; next-line

;; (global-unset-key (kbd "M-b")) ; backward-word
;; (global-unset-key (kbd "M-t")) ; forward-word

;; (global-unset-key (kbd "M-s")) ; kill-word
;; (global-unset-key (kbd "C-<backspace>")) ; backward-kill-word
;; ;(global-unset-key (kbd "C-s")) ; delete-char

;; (global-unset-key (kbd "M-j")) ; newline-and-indent
;; (global-unset-key (kbd "M-h")) ; mark-paragraph

;; (global-unset-key (kbd "M-o"))
;; (global-unset-key (kbd "C-o"))
;; (global-unset-key (kbd "M-'")) ; abbrev-prefix-mark

;; (global-unset-key (kbd "M-u")) ;
;; (global-unset-key (kbd "M-n")) ;
;; (global-unset-key (kbd "M-e")) ;
;; (global-unset-key (kbd "M-i")) ;
;; (global-unset-key (kbd "M-U")) ;
;; (global-unset-key (kbd "M-N")) ;
;; (global-unset-key (kbd "M-E")) ;
;; (global-unset-key (kbd "M-I")) ;

;; (global-unset-key (kbd "M-a")) ;
;; (global-unset-key (kbd "M-b")) ;
;; (global-unset-key (kbd "M-c")) ;
;; (global-unset-key (kbd "M-d")) ;
;; (global-unset-key (kbd "M-e")) ;
;; (global-unset-key (kbd "M-f")) ;
;; (global-unset-key (kbd "M-g")) ;
;; (global-unset-key (kbd "M-h")) ;
;; (global-unset-key (kbd "M-i")) ;
;; (global-unset-key (kbd "M-j")) ;
;; (global-unset-key (kbd "M-k")) ;
;; (global-unset-key (kbd "M-l")) ;
;; (global-unset-key (kbd "M-m")) ;
;; (global-unset-key (kbd "M-n")) ;
;; (global-unset-key (kbd "M-o")) ;
;; (global-unset-key (kbd "M-p")) ;
;; (global-unset-key (kbd "M-q")) ;
;; (global-unset-key (kbd "M-r")) ;
;; (global-unset-key (kbd "M-s")) ;
;; (global-unset-key (kbd "M-t")) ;
;; (global-unset-key (kbd "M-u")) ;
;; (global-unset-key (kbd "M-v")) ;
;; ;(global-unset-key (kbd "M-w")) ;
;; ;(global-unset-key (kbd "M-x")) ;
;; (global-unset-key (kbd "M-y")) ;
;; (global-unset-key (kbd "M-z")) ;

;; (global-unset-key (kbd "M-A")) ;
;; (global-unset-key (kbd "M-B")) ;
;; (global-unset-key (kbd "M-C")) ;
;; (global-unset-key (kbd "M-D")) ;
;; (global-unset-key (kbd "M-E")) ;
;; (global-unset-key (kbd "M-F")) ;
;; (global-unset-key (kbd "M-G")) ;
;; (global-unset-key (kbd "M-H")) ;
;; (global-unset-key (kbd "M-I")) ;
;; (global-unset-key (kbd "M-J")) ;
;; (global-unset-key (kbd "M-K")) ;
;; (global-unset-key (kbd "M-L")) ;
;; (global-unset-key (kbd "M-M")) ;
;; (global-unset-key (kbd "M-N")) ;
;; (global-unset-key (kbd "M-O")) ;
;; (global-unset-key (kbd "M-P")) ;
;; (global-unset-key (kbd "M-Q")) ;
;; (global-unset-key (kbd "M-R")) ;
;; (global-unset-key (kbd "M-S")) ;
;; (global-unset-key (kbd "M-T")) ;
;; (global-unset-key (kbd "M-U")) ;
;; (global-unset-key (kbd "M-V")) ;
;; (global-unset-key (kbd "M-W")) ;
;; (global-unset-key (kbd "M-X")) ;
;; (global-unset-key (kbd "M-Y")) ;
;; (global-unset-key (kbd "M-Z")) ;


;; (global-unset-key (kbd "M-,")) ; tags-loop-continue
;; (global-unset-key (kbd "M-.")) ; find-tag
;; (global-unset-key (kbd "M-<")) ; beginning-of-buffer
;; (global-unset-key (kbd "M->")) ; end-of-buffer
;; (global-unset-key (kbd "M-;")) ; comment-dwim
;; (global-unset-key (kbd "M-:")) ; eval-expresseion
;; (global-unset-key (kbd "M--"))

;; (global-unset-key (kbd "M-`"))
;; (global-unset-key (kbd "M-~"))
;; (global-unset-key (kbd "M-<insert>"))
;; (global-unset-key (kbd "M-<delete>"))
;; (global-unset-key (kbd "M-<home>"))
;; (global-unset-key (kbd "M-<end>"))




(global-unset-key (kbd "<f1>"))
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<f3>"))
(global-unset-key (kbd "<f4>"))
(global-unset-key (kbd "<f5>"))
(global-unset-key (kbd "<f6>"))
(global-unset-key (kbd "<f7>"))
(global-unset-key (kbd "<f8>"))
(global-unset-key (kbd "<f9>"))
(global-unset-key (kbd "<f10>"))
(global-unset-key (kbd "<f11>"))
(global-unset-key (kbd "<f12>"))



;;______________________________________________________________________________
;;Global Bindings
;;______________________________________________________________________________

;;;; CURSOR MOVEMENTS
;; Single char cursor movement
(global-set-key (kbd "H-n") 'backward-char)
(global-set-key (kbd "H-i") 'forward-char)
(global-set-key (kbd "H-u") 'previous-line)
(global-set-key (kbd "H-e") 'next-line)
;; Move by word
(global-set-key (kbd "H-l") 'geosoft-backward-word)
(global-set-key (kbd "H-l") 'backward-word-to-newline) ;; geosoft-backward-word
(global-set-key (kbd "H-y") 'forward-word-to-newline)  ;; forward-word
(global-set-key (kbd "H-0") 'forward-same-syntax)
;; Move by paragraph
;(global-set-key (kbd "H-L") 'backward-paragraph)
;(global-set-key (kbd "H-Y") 'forward-paragraph)
(global-set-key (kbd "H-L") 'pager-row-up)
(global-set-key (kbd "H-Y") 'pager-row-down)
;; Move to beginning/ending of line
(global-set-key (kbd "H-N") 'back-to-indentation-or-beginning)
(global-set-key (kbd "H-I") 'end-of-line)
;; Move by screen (page up/down)
;(global-set-key (kbd "H-U") 'scroll-down)
;(global-set-key (kbd "H-E") 'scroll-up)
(global-set-key (kbd "H-U") 'pager-page-up)
(global-set-key (kbd "H-E") 'pager-page-down)
;; Move to beginning/ending of file
(global-set-key (kbd "H-h") 'beginning-of-buffer)
(global-set-key (kbd "H-H") 'end-of-buffer)
;; isearch
;(global-set-key (kbd "H-o") 'isearch-forward)
;(global-set-key (kbd "H-O") 'isearch-backward)
 (global-set-key (kbd "H-g") 'recenter)

;;;; MAJOR EDITING COMMANDS
;; Delete previous/next char
(global-set-key (kbd "H-s") 'delete-backward-char)
(global-set-key (kbd "H-t") 'delete-char)
;; Delete previous/next word
(global-set-key (kbd "H-f") 'backward-kill-word)
(global-set-key (kbd "H-p") 'kill-word)
;; Copy Cut Paste, Paste previous
;;lobal-set-key (kbd "H-x") 'kill-region) ; C-w
;(global-set-key (kbd "H-c") 'kill-ring-save)
;(global-set-key (kbd "H-v") 'yank)
;(global-set-key (kbd "H-V") 'yank-pop)
;(global-set-key (kbd "H-C") 'copy-all)
;(global-set-key (kbd "H-X") 'cut-all)
;; Undo and redo
(global-set-key (kbd "H-Z") 'redo)
(global-set-key (kbd "H-z") 'undo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "H-w") 'kill-ring-save)

;; Kill line
;(global-set-key (kbd "H-d") 'kill-line)
(global-set-key (kbd "H-d") 'kill-whole-line)

;;;; Textual Transformation
(global-set-key (kbd "H-S-SPC") 'mark-paragraph)
;(global-set-key (kbd "H-w") 'shrink-whitespace) ???
;(global-set-key (kbd "H-'") 'comment-dwim) ;?
(global-set-key (kbd "H-b") 'toggle-letter-case)
(global-set-key (kbd "H-B") 'caps-mode)
;; Keyword completion, because Alt-Tab is used by OS
;(global-set-key (kbd "H-g") 'call-keyword-completion) ???
;; Hard-wrap/un-hard-wrap paragraph
;(global-set-key (kbd "H-q") 'compact-uncompact-block) ???
(global-set-key (kbd "H--") 'er/expand-region)
(global-set-key (kbd "H-_") 'er/contract-region)
;;;; EMACS'S SPECIAL COMMANDS
;; Cancel
(global-set-key (kbd "H-k") 'keyboard-escape-quit)
;; Mark point
(global-set-key (kbd "C-SPC") 'set-mark-command)
(global-set-key (kbd "H-a") 'execute-extended-command)
(global-set-key (kbd "H-A") 'shell-toggle)

;;;; WINDOW SPLITTING
;(global-set-key (kbd "H-r") 'move-cursor-next-pane)
;(global-set-key (kbd "H-R") 'move-cursor-previous-pane)

;;;; OTHER SHORTCUTS
;(global-set-key (kbd "H-~") 'switch-to-previous-frame)
;(global-set-key (kbd "H-`") 'switch-to-next-frame)

;(global-set-key (kbd "H-8") 'extend-selection)
;(global-set-key (kbd "H-*") 'select-text-in-quote)

(global-set-key (kbd "H-v") 'goto-last-change)





(global-set-key (kbd "H-<up>") 'windmove-up)
(global-set-key (kbd "H-<down>") 'windmove-down)
(global-set-key (kbd "H-<right>") 'windmove-right)
(global-set-key (kbd "H-<left>") 'windmove-left)
(global-set-key (kbd "S-<up>") 'buf-move-up)
(global-set-key (kbd "S-<down>") 'buf-move-down)
(global-set-key (kbd "S-<right>") 'buf-move-right)
(global-set-key (kbd "S-<left>") 'buf-move-left)
(global-set-key (kbd "C-<up>") 'tiling-tile-up)
(global-set-key (kbd "C-<down>") 'tiling-tile-down)
(global-set-key (kbd "C-<right>") 'tiling-tile-right)
(global-set-key (kbd "C-<left>") 'tiling-tile-left)
(global-set-key (kbd "H-S-<up>") 'shrink-window)
(global-set-key (kbd "H-S-<down>") 'enlarge-window)
(global-set-key (kbd "H-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "H-S-<left>") 'shrink-window-horizontally)


(global-set-key (kbd "H-m") 'isearch-forward)
(global-set-key (kbd "H-M") 'sprint-forward)
(global-set-key (kbd "H-c") 'ace-jump-word-mode)
(global-set-key (kbd "H-C") 'ace-jump-line-mode)
(global-set-key (kbd "H-V") 'idomenu)

(global-set-key (kbd "H-SPC") 'hippie-expand)
(global-set-key (kbd "H-o") 'other-window)
(global-set-key (kbd "H-O") 'tiling-cycle)
(global-set-key (kbd "H-'") 'win-switch-dispatch)
(global-set-key (kbd "H-\"") 'set-80-columns)
;(global-set-key (kbd "H-'") 'switch-to-buffer)
;(global-set-key (kbd "H-,") 'previous-buffer)
;(global-set-key (kbd "H-.") 'next-buffer)
(global-set-key (kbd "H-g") 'goto-line)
(global-set-key (kbd "H-<return>") 'ido-switch-buffer)
;(global-set-key (kbd "H-<return>") 'idobuffer)
(global-set-key (kbd "S-<return>") 'new-indented-line)

(global-set-key (kbd "H-,") 'tabbar-backward-renew)
(global-set-key (kbd "H-.") 'tabbar-forward-renew)
(global-set-key (kbd "H-<") 'tabbar-backward-group)
(global-set-key (kbd "H->") 'tabbar-forward-group)
(global-set-key (kbd "H-<menu>") 'tabbar-press-home)

(global-set-key (kbd "<menu>") 'idobuffer)
(global-set-key (kbd "S-<menu>") 'menu-bar-mode)

(global-set-key (kbd "H-D") 'create-scratch-buffer)
;;END

;;New layout
;;(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "colemak")
;; load ErgoEmacs keybinding
;;(load "~/.emacs.d/ergoemacs-keybindings-5.3.4/ergoemacs-mode")
;; turn on minor mode ergoemacs-mode
;;(ergoemacs-mode 1)

(global-set-key (kbd "H-/") 'query-replace)
(global-set-key (kbd "H-?") 'iedit-mode)
;;(global-set-key (kbd "H-?") 'query-replace-regexp)
(global-set-key (kbd "H-\\") 'delete-window)
(global-set-key (kbd "H-|") 'delete-other-windows)
(global-set-key (kbd "H-:") 'split-window-vertically)
(global-set-key (kbd "H-;") 'split-window-horizontally)
;(global-set-key (kbd "H-r") 'transpose-lines)
(global-set-key (kbd "H-r") 'comment-or-uncomment-region)
(global-set-key (kbd "H-R") 'align-regexp)
(global-set-key (kbd "H-]") '(lambda nil (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "H-}") 'kill-buffer-and-window)

(global-set-key (kbd "H-F") 'transpose-up)
(global-set-key (kbd "H-P") 'transpose-down)
(global-set-key (kbd "H-G") 'transpose-words)

;(global-set-key (kbd "H-q") 'goto-match-paren)
;(global-set-key (kbd "H-Q") 'rainbow-delimiters-mode)
;(global-set-key (kbd "H-j") 'my-anything)
(global-set-key (kbd "H-j") 'recentf-ido-find-file)
(global-set-key (kbd "H-J") 'find-file-at-point)

(global-set-key (kbd "H-<insert>") 'linum-mode)
(global-set-key (kbd "H-<end>") 'whitespace-mode)
(global-set-key (kbd "H-S-<end>") 'rainbow-delimiters-mode)

(global-set-key (kbd "H-<home>") '(lambda nil (interactive) (defaultface)))
(global-set-key (kbd "H-+") '(lambda nil (interactive) (zoomableface)))
(global-set-key (kbd "H-=") '(lambda nil (interactive) (zoom 1)))
(global-set-key (kbd "H-<delete>") 'auto-indent-mode)

(global-set-key (kbd "H-[") 'winner-undo)
(global-set-key (kbd "H-{") 'winner-redo)
(global-set-key (kbd "H-`") 'flymake-goto-next-error)
(global-set-key (kbd "H-~") 'flymake-mode)

(global-set-key (kbd "H-1") 'bc-set)
(global-set-key (kbd "H-2") 'bc-local-previous)
(global-set-key (kbd "H-3") 'bc-local-next)
(global-set-key (kbd "H-#") 'bc-list)

(global-set-key (kbd "H-7") 'toggle-selective-display)
(global-set-key (kbd "H-&") 'cursor-selective-display)
(global-set-key (kbd "H-9") 'find-tag)
(global-set-key (kbd "H-8") 'pop-tag-mark)
(global-set-key (kbd "H-(") 'tags-apropos)

(global-set-key (kbd "<f1>") 'google-translate-query-translate)
(global-set-key (kbd "H-<f1>") 'flyspell-mode)
(global-set-key (kbd "<f2>") 'flyspell-buffer)
(global-set-key (kbd "H-<f2>") 'fd-switch-dictionary)
(global-set-key (kbd "<f3>") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "<H-f3>") 'kmacro-name-last-macro)
(global-set-key (kbd "<f4>") 'kmacro-end-or-call-macro)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f8>") 'narrow-toggle)
(global-set-key (kbd "<f10>") 'reftex-toc)
(global-set-key (kbd "<f11>") 'LaTeX-environment)
(global-set-key (kbd "H-<f11>") 'LaTeX-close-environment)
(global-set-key (kbd "<f12>") 'preview-buffer)
(global-set-key (kbd "<H-f12>") 'preview-clearout-buffer)

(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "M-SPC") 'fixup-whitespace) ;make it context aware.

(global-set-key (kbd "C-H-u") 'chop-move-up)
(global-set-key (kbd "C-H-e") 'chop-move-down)


(add-hook 'comint-mode-hook (lambda ()
   (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
   (define-key comint-mode-map (kbd "<down>") 'comint-next-input)))

























;;______________________________________________________________________________
;;
;;
;;                                  Settings
;;
;;______________________________________________________________________________

;;______________________________________________________________________________
;;Settings
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/")

(setq inhibit-startup-message t)
(setq default-frame-alist (append (list
  '(width  . 80)  ; Width set to 80 characters
  '(height . 40)) ; Height set to 60 lines
  default-frame-alist))
(setq frame-title-format "%b")
(fset 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)
;;(display-battery-mode t) ;; my battery seems to be dead, and battery-mode cant handle that correctly

(show-paren-mode t)
(setq show-paren-delay 0)
;(require 'mic-paren)
;(paren-activate)
(setq show-paren-style 'expression)

(tool-bar-mode 0)
(menu-bar-mode 0)
(global-linum-mode t)
(winner-mode 1)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(setq european-calendar-style t)

(setq temporary-file-directory "/tmp/")
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))
(require 'shell-toggle)
(setq shell-toggle-launch-shell 'shell-toggle-eshell)
(require 'pager) ;For smarter scrolling

(require 'follow-mouse) ;Active window follows mouse
(turn-on-follow-mouse)
(setq follow-mouse-deselect-active-minibuffer nil)

(delete-selection-mode t)

(require 'volatile-highlights)
(volatile-highlights-mode t)

;(load "~/.emacs.d/fixed-point-completion.el")
;(enable-fixed-point-completions)

(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 200)

(require 'goto-last-change)

(require 'uniquify)

(require 'ace-jump-mode)

(require 'caps-mode)

(defvar sql-sqlite-program "sqlite3")


(require 'idomenu)

;(require 'rfringe)
;(set-fringe-mode '(1 . 0))
(set-fringe-mode '(0 . 0))

(add-to-list 'load-path "~/builds/emacs-w3m-1.4.4")
(require 'w3m-e21)
(provide 'w3m-e23)
(add-hook 'w3m-mode-hook (lambda ()
                           (setq show-trailing-whitespace nil)))

;;(setq browse-url-browser-function 'browse-url-generic
;;          browse-url-generic-program "chromium")'
(setq browse-url-browser-function 'w3m-browse-url)
;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
;;(global-set-key "\C-xm" 'browse-url-at-point)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0)
(require 'c-eldoc)
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)


(setq recenter-positions '(top middle bottom))
(require 'chop)

(require 'google-translate)

(add-to-list 'load-path "~/.emacs.d/predictive/")
(require 'predictive)
(set-default 'predictive-auto-add-to-dict t)
(setq predictive-main-dict 'rpg-dictionary
      predictive-auto-learn t
      predictive-add-to-dict-ask nil
      predictive-use-auto-learn-cache nil
      predictive-which-dict t)

;;Highlight current line
(require 'hlinum)
(global-hl-line-mode 1)


;(setq line-move-visual nil)

;;______________________________________________________________________________
;;Fun
;;______________________________________________________________________________
(load-file "~/.emacs.d/minesweeper-mode.el")
(require 'reddit)
(require 'typing)

;;______________________________________________________________________________
;;Fill-column-indicator
;;______________________________________________________________________________
(require 'fill-column-indicator)
(setq fci-rule-color "gray32")
(setq-default fill-column 80)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
;;______________________________________________________________________________
;;Startup
;;______________________________________________________________________________
(setq inhibit-startup-message t)
(defun display-startup-echo-area-message ()
  (message ""))
(find-file "~/.emacs")
;(switch-to-buffer "blank")
(if (not (eq nil (get-buffer "*scratch*")))
    (kill-buffer "*scratch*"))
(if (not (eq nil (get-buffer "*Messages*")))
    (kill-buffer "*Messages*"))

;;______________________________________________________________________________
;;Clock
;;______________________________________________________________________________

;(setq display-time-day-and-date t
;      display-time-24hr-format t)
;(setq display-time-format 1)
;(setq display-time-24hr-format t)

(defface display-time-face
  '((((type x w32 mac))
     (:foreground "honeydew1")); :inherit bold))
    (((type tty))
     (:foreground "blue")))
  "Face used to display the time in the mode line.")

(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
                    'face 'display-time-face)))

(display-time)

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
 '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "Schumacher" :family "Clean"))))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))

;;______________________________________________________________________________
;;Theme
;;______________________________________________________________________________
;(require 'color-theme)
;(require 'color-theme-tomorrow)

;(add-to-list 'load-path "~/.emacs.d/solarized")
;(eval-after-load "color-theme"
;  '(progn
;     (color-theme-initialize)
;     (color-theme-hober)))
;(require 'color-theme-solarized)
;(color-theme-solarized-dark)

(if (string= (system-name) "joker")
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

(set-face-background 'modeline "slate gray")
(set-face-background 'modeline-inactive "gray36")
;(set-face-background 'modeline "#4477aa")
(set-face-attribute 'mode-line nil :box nil)
;(set-background-color "black")
;(set-face-background 'default "black")
;(set-face-background 'region "black")
;(set-face-foreground 'default "white")
;(set-face-foreground 'region "gray60")
;(set-foreground-color "white")
;(set-cursor-color "red")
;(set-cursor-color "cyan")

(set-face-background 'show-paren-match-face "gray40")
;(set-face-background 'paren-face-match "gray40") ;; from mic-paren

(set-face-foreground'vertical-border "gray22")

;;______________________________________________________________________________
;;MODELINE
;;______________________________________________________________________________
(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)

;; (setq-default mode-line-format
;;               '("  " mode-line-modified
;;                 (list 'line-number-mode "  ")
;;                 (:eval (when line-number-mode
;;                          (let ((str "L%l"))
;;                            (when (and (not (buffer-modified-p)) my-mode-line-buffer-line-count)
;;                              (setq str (concat str "/" my-mode-line-buffer-line-count)))
;;                            str)))
;;                 "  %p"
;;                 (list 'column-number-mode "  C%c")
;;                 "  " mode-line-buffer-identification
;;                 "  " mode-line-modes))

(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)

(setq which-func-modes t)
(which-func-mode 1)
;;______________________________________________________________________________
;;SML-MODELINE
;;______________________________________________________________________________
(require 'sml-modeline)
(sml-modeline-mode 1)
(scroll-bar-mode -1)

;;______________________________________________________________________________
;;Rainbow delimiters
;;______________________________________________________________________________
(require 'rainbow-delimiters)
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
;;HIGHLIGHTS/WHITESPACE
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
(setq whitespace-style '(face empty tabs trailing)) ;;removed lines-tail
(global-whitespace-mode t)

;;show-trailing-whitespace is incompatible with fci-mode
;;(setq-default show-trailing-whitespace t)
;;(set-face-attribute
;; 'trailing-whitespace nil
;; :background "gray60")

;; nuke whitespaces when writing to a file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;______________________________________________________________________________
;;DTRT-INDENT
;;______________________________________________________________________________
;(add-hook 'c-mode-common-hook
;          (lambda()
;            (require 'dert-indent)
;            (dtrt-indent-mode t)))
(require 'dtrt-indent)
(dtrt-indent-mode t)
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
;;Windows
;;______________________________________________________________________________
(require 'buffer-move)
(require 'tiling)
;(require 'window-numbering)
(setq windmove-wrap-around t)
;(window-numbering-mode 1)
(require 'win-switch)
(setq win-switch-idle-time 1000)
(setq win-switch-window-threshold 0)
(setq win-switch-other-window-first nil)
(win-switch-set-wrap-around)
(win-switch-delete-key "i" 'up)
(win-switch-delete-key "k" 'down)
(win-switch-delete-key "j" 'left)
(win-switch-delete-key "l" 'right)
(win-switch-delete-key "o" 'next-window)
(win-switch-delete-key "p" 'previous-window)
;(win-switch-delete-key "<spc>" 'other-frame)
(win-switch-delete-key "u" 'exit)
(win-switch-delete-key "I" 'enlarge-vertically)
(win-switch-delete-key "K" 'shrink-vertically)
(win-switch-delete-key "L" 'enlarge-horizontally)
(win-switch-delete-key "J" 'shrink-horizontally)
(win-switch-delete-key "h" 'split-vertically)
(win-switch-delete-key ";" 'split-horizontally)
(win-switch-delete-key "0" 'delete-window)


(win-switch-add-key "u" 'up)
(win-switch-add-key "e" 'down)
(win-switch-add-key "n" 'left)
(win-switch-add-key "i" 'right)
(win-switch-add-key "y" 'next-window)
(win-switch-add-key "l" 'previous-window)
(win-switch-add-key "<spc>" 'other-frame)
(win-switch-add-key "k" 'exit)
(win-switch-add-key "f" 'shrink-vertically)
(win-switch-add-key "s" 'enlarge-vertically)
(win-switch-add-key "r" 'enlarge-horizontally)
(win-switch-add-key "t" 'shrink-horizontally)
(win-switch-add-key ":" 'split-horizontally)
(win-switch-add-key ";" 'split-vertically)
(win-switch-add-key "\\" 'delete-window)

(win-switch-define-key "U" 'buf-move-up t)
(win-switch-define-key "E" 'buf-move-down t)
(win-switch-define-key "N" 'buf-move-left t)
(win-switch-define-key "I" 'buf-move-right t)

(win-switch-define-key "C-U" 'tiling-tile-up t)
(win-switch-define-key "C-E" 'tiling-tile-down t)
(win-switch-define-key "C-N" 'tiling-tile-left t)
(win-switch-define-key "C-I" 'tiling-tile-right t)

(win-switch-define-key "o" 'tiling-cycle t)
(win-switch-define-key "|" 'delete-other-windows t)


(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))






















;;______________________________________________________________________________
;;
;;
;;                                   MODES
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
(define-key anything-map (kbd "H-u") 'anything-previous-line)
(define-key anything-map (kbd "H-e") 'anything-next-line)


;;______________________________________________________________________________
;;ARTIST MODE
;;______________________________________________________________________________
(autoload 'artist-mode "artist" "Enter artist-mode" t)

;;______________________________________________________________________________
;;AUTO-INSERT
;;______________________________________________________________________________
(require 'autoinsert)
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates/")
(setq auto-insert-query nil)
(setq auto-insert-alist '(
                          ("\\.tex$" . ["preamble.tex" auto-update-template]);(lambda () (goto-line 40))])
                          ))


(defun insert-today ()
  "Insert today's date into buffer"
  (interactive)
  (insert (format-time-string "%e/%m - %Y" (current-time))))

(defun auto-update-template ()
  "Replace the following sequences when files are created from templates:
@@@CURSOR
@@@DATE
@@@YEAR
@@@FILENAME"
  (save-excursion
    ;;Replace @@@DATE with date
    (while (search-forward "@@@DATE" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match "")
        (insert-today)
        ))
    )
  (save-excursion
    ;;Replace @@@YEAR with year
    (while (search-forward "@@@YEAR" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match "")
        (insert (format-time-string "%Y" (current-time)))
        ))
    )
  (save-excursion
    ;;Replace @@@FILENAME with file name
    (while (search-forward "@@@FILENAME" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (file-name-nondirectory buffer-file-name) t)
        ))
    )
  ;;Move cursor to last occurence of @@@CURSOR
  (while (search-forward "@@@CURSOR" nil t)
    (save-restriction
      (narrow-to-region (match-beginning 0) (match-end 0))
      (replace-match "")
      )
    )
  )

;;______________________________________________________________________________
;;BABEL
;;______________________________________________________________________________
(autoload 'babel "babel" nil t)
(autoload 'babel-region "babel" nil t)
(autoload 'babel-as-string "babel" nil t)
(autoload 'babel-buffer "babel" nil t)

;;______________________________________________________________________________
;;BREADCRUMB
;;______________________________________________________________________________
(require 'breadcrumb)

;;______________________________________________________________________________
;;ESHELL
;;______________________________________________________________________________
(require 'eshell)
(setq eshell-directory-name "~/.emacs.d/eshell/")
(setq eshell-visual-commands '("nano"))
(setq eshell-buffer-shorthand t)
(setq eshell-hist-ignoredups t)
(setq eshell-aliases-file "~/.emacs.d/eshell/alias")
(defun m-eshell-hook ()
  (setq eshell-visual-commands '("nano"))
  (setq eshell-buffer-shorthand t)
  (setq eshell-hist-ignoredups t)
  (define-key eshell-mode-map (kbd "H-d") 'eshell-kill-input)
  (define-key eshell-mode-map (kbd "H-n") 'eshell-bol)
  (add-to-list 'eshell-visual-commands "nano")
  (add-to-list 'eshell-visual-commands "htop")
  (add-to-list 'eshell-visual-commands "irssi")
  (add-to-list 'eshell-visual-commands "emacs")
  (add-to-list 'eshell-visual-commands "alsamixer")
  (add-to-list 'eshell-visual-commands "ssh")
  (add-to-list 'eshell-visual-commands "tail")
)
(add-hook 'eshell-mode-hook 'm-eshell-hook)
(defun tyler-eshell-view-file (file)
  "A version of `view-file' which properly respects the eshell prompt."
  (interactive "fView file: ")
  (unless (file-exists-p file) (error "%s does not exist" file))
  (let ((had-a-buf (get-file-buffer file))
        (buffer (find-file-noselect file)))
    (if (eq (with-current-buffer buffer (get major-mode 'mode-class))
            'special)
        (progn
          (switch-to-buffer buffer)
          (message "Not using View mode because the major mode is special"))
      (let ((undo-window (list (window-buffer) (window-start)
                               (+ (window-point)
                                  (length (funcall eshell-prompt-function))))))
        (switch-to-buffer buffer)
        (view-mode-enter (cons (selected-window) (cons nil undo-window))
                         'kill-buffer)))))
(defun eshell/less (&rest args)
  "Invoke `view-file' on a file. \"less +42 foo\" will go to line 42 in
    the buffer for foo."
  (while args
    (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
        (let* ((line (string-to-number (match-string 1 (pop args))))
               (file (pop args)))
          (tyler-eshell-view-file file)
          (goto-line line))
      (tyler-eshell-view-file (pop args)))))
(defalias 'eshell/more 'eshell/less)

;;______________________________________________________________________________
;;EXPAND-REGION
;;______________________________________________________________________________
(require 'expand-region)
;; (defun er/add-text-mode-expansions ()
;;   (set (make-local-variable 'er/try-expand-list)
;;        (append
;;         er/try-expand-list
;;         '(mark-paragraph
;;           mark-page))))

;; (add-hook 'text-mode-hook 'er/add-text-mode-expansions)

(setq er/try-expand-list
      (append er/try-expand-list
              '(mark-paragraph
                mark-page)))


;;______________________________________________________________________________
;;FASTNAV
;;______________________________________________________________________________
(require 'fastnav)

;;______________________________________________________________________________
;;FLYMAKE
;;______________________________________________________________________________
(require 'flymake)
(require 'flymake-cursor)

;; Flymake for LaTeX
;(defun flymake-get-tex-args (file-name)
;  (list "chktex" (list "-g0" "-r" "-l" (expand-file-name "~/.chktexrc") "-I" "-q" "-v0" file-name)))
;(push
; '("^\\(\.+\.tex\\):\\([0-9+\\):\\([0-9]+\\):\\(.+\\))"
;   1 2 3 4) flymake-err-line-patterns)
;(defun flymake-get-tex-args (file-name)
;  (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;; Underline errors instead of highlight


;; Quickly show next err-menu
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line)
)

;(add-hook 'LaTeX-mode-hook 'flymake-mode)

;;______________________________________________________________________________
;;FLYSPELL
;;______________________________________________________________________________
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq flyspell-issue-welcome-flag nil)
(setq flyspell-issue-message-flag nil)
;(setq ispell-dictionary "dansk")
(setq ispell-dictionary "english")
(add-hook 'flyspell-mode-hook 'flyspell-buffer)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
(add-hook 'python-mode-hook 'flyspell-prog-mode)
(add-hook 'sml-mode 'flyspell-prog-mode)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)

(defun turn-on-flyspell ()
  "Force flyspell-mode on using a positive arg."
  (interactive)
  (flyspell-mode 1))

;; Better order of spelling suggestions
;(defadvice ispell-command-loop (before ispell-reverse-miss-list activate)
;  "reverse the first argument to ispell-command-loop"
;  (ad-set-arg 0 (reverse (ad-get-arg 0))))


;;______________________________________________________________________________
;;FULL-ACK
;;______________________________________________________________________________
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;;______________________________________________________________________________
;;GNUPLOT
;;______________________________________________________________________________
(require 'gnuplot)

;;______________________________________________________________________________
;;GRAPHVIZ
;;______________________________________________________________________________
(load-file "~/.emacs.d/graphviz-dot-mode.el")

;;______________________________________________________________________________
;;HASKELL
;;______________________________________________________________________________
;;;; Haskell setup:
;;;; Install hoogle (used in GHCi with :hoogle and :doc):
;; cabal install hoogle
;; echo >> ~/.ghci ':def hoogle \x -> return $ ":!hoogle \"" ++ x ++ "\""'
;;echo >> ~/.ghci ':def doc \x -> return $ ":!hoogle --info \"" ++ x ++ "\""'

(load "~/.emacs.d/haskell-mode/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(add-to-list 'load-path "~/.emacs.d/ghc-mod/")
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda ()
                               (ghc-init)
                               (flymake-mode)
                               (define-key haskell-mode-map "\C-c\C-c" '(lambda () (interactive)
                                                                            (ghc-flymake-toggle-command)
                                                                            (flymake-start-syntax-check)
                                                                            (message "Checkedede")))))


;; (require 'hs-lint)    ;; https://gist.github.com/1241059
;; ;;(require 'haskell-ac) ;; https://gist.github.com/1241063

;; (defun my-haskell-mode-hook ()
;;   "hs-lint binding, plus autocompletion and paredit."
;;   (local-set-key "\C-cl" 'hs-lint))

;; (eval-after-load 'haskell-mode
;;   '(progn
;;      (require 'flymake)
;;      (push '("\\.l?hs\\'" flymake-haskell-init) flymake-allowed-file-name-masks)
;;      (add-hook 'haskell-mode-hook 'flymake-haskell-enable)
;;      (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)))



;; (defun flymake-haskell-init ()
;;   "When flymake triggers, generates a tempfile containing the
;;   contents of the current buffer, runs `hslint` on it, and
;;   deletes file. Put this file path (and run `chmod a+x hslint`)
;;   to enable hslint: https://gist.github.com/1241073"
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "hlint" (list local-file))))

;; (defun flymake-haskell-enable ()
;;   "Enables flymake-mode for haskell, and sets <C-c d> as command
;;   to show current error."
;;   (when (and buffer-file-name
;;              (file-writable-p
;;               (file-name-directory buffer-file-name))
;;              (file-writable-p buffer-file-name))
;;     (local-set-key (kbd "C-c d") 'flymake-display-err-menu-for-current-line)
;;     (flymake-mode t)))

;; Forces flymake to underline bad lines, instead of fully
;; highlighting them; remove this if you prefer full highlighting.
;; (custom-set-faces
;;  '(flymake-errline ((((class color)) (:underline "red"))))
;;  '(flymake-warnline ((((class color)) (:underline "yellow")))))

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
;;IBUFFER
;;______________________________________________________________________________
(require 'ibuffer)

;; From emacs-fu
(setq ibuffer-saved-filter-groups
      (quote (("default"


               ("OSM"
                (filename . "~/Dropbox/diku/osm/"))

               ("Tex"
                (or
                 (mode . auctex)
                 (mode . latex-mode)))
               ("c"
                (mode . c-mode))
               ("Python"
                (mode . python-mode))
               ("Web"
                (or
                 (mode . html-mode)
                 (mode . css-mode)))
               ("MATLAB"
                (or
                 (mode . matlab-mode)
                 (name . "*MATLAB*")))
               ("emacs-config"
                (or
                 (filename . ".emacs")))

               ("Org" ;; all org-related buffers
                (mode . org-mode))
               ("Mail"
                (or ;; mail-related buffers
                 (mode . message-mode)
                 (mode . mail-mode)
                 ;; etc. ; all your mail related modes
                 ))
               ("ERC"
                (mode . erc-mode))

                 ))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil)

(defun idobuffer ()
  "Open ibuffer and start ido"
  (interactive)
  (ibuffer)
  (ido-switch-buffer)
  (kill-buffer "*Ibuffer*"))

(defun ibuffer-ido-find-file ()
  "Like `ido-find-file', but default to the directory of the buffer at point."
  (interactive
   (let ((default-directory (let ((buf (ibuffer-current-buffer)))
                              (if (buffer-live-p buf)
                                  (with-current-buffer buf
                                    default-directory)
                                default-directory))))
     (ido-find-file-in-dir default-directory))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (define-key ibuffer-mode-map "\C-x\C-f"
              'ibuffer-ido-find-file)))
(defadvice ibuffer (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name"
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

(defun ibuffer-ediff-marked-buffers ()
  (interactive)
  (let* ((marked-buffers (ibuffer-get-marked-buffers))
         (len (length marked-buffers)))
    (unless (= 2 len)
      (error (format "%s buffer%s been marked (needs to be 2)"
                     len (if (= len 1) " has" "s have"))))
    (ediff-buffers (car marked-buffers) (cadr marked-buffers))))

(define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)

;;______________________________________________________________________________
;;IDO
;;______________________________________________________________________________
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-file-extension-order '("/" ".tex" ".emacs" ".txt" ".py" ".pl" ".c" ".h" ".hs" ".cfg" ".asm" ".xml" ".org"))
(ido-mode 1)

;; Display ido results vertically, rather than horizontally
;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;default
;(setq ido-decorations (quote ("{" "}" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;(remove-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)



;; use ido to complete commands via M-X
(global-set-key (kbd "H-x")
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)

  (let ((ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))))
  ;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file)))))

;;______________________________________________________________________________
;;ISEARCH
;;______________________________________________________________________________
(defun sacha/isearch-yank-current-word ()
  "Pull current word from buffer into search string."
  (interactive)
  (save-excursion
    (skip-syntax-backward "w_")
    (isearch-yank-internal
     (lambda ()
       (skip-syntax-forward "w_")
       (point)))))
(define-key isearch-mode-map (kbd "C-x") 'sacha/isearch-yank-current-word)
(define-key isearch-mode-map (kbd "H-u") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "H-e") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "H-m") 'isearch-edit-string)

;;______________________________________________________________________________
;;JABBER
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/emacs-jabber-0.8.0/")
(require 'jabber-autoloads)

;;______________________________________________________________________________
;;LATEX
;;______________________________________________________________________________
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(require 'reftex-toc)
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)

(setq TeX-fold-env-spec-list t)
(setq TeX-fold-macro-spec-list t)
(setq TeX-fold-math-spec-list t)

(setq preview-auto-cache-preamble t)
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(define-key reftex-toc-map (kbd "u") 'reftex-toc-previous)
(define-key reftex-toc-map (kbd "e") 'reftex-toc-next)
;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;(setq TeX-view-program-list '(("Zathura" "zathura %o")))
;(setq TeX-view-program-selection '((output-pdf "Zathura")))
(setq TeX-view-program-list '(("Xpdf" "xpdf %o")))
(setq TeX-view-program-selection '((output-pdf "Xpdf")))

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(add-hook
 'LaTeX-mode-hook
 (lambda nil
   (visual-line-mode)
   (setq LaTeX-command "latex -file-line-error -synctex=1")))

;;______________________________________________________________________________
;;MINIMAP
;;______________________________________________________________________________
(require 'minimap)
(setq minimap-window-location 'right)
(setq minimap-width-fraction 0.8)
;(set-face-attribute 'minimap-font-face '((default :family "DejaVu Sans Mono" :height 5)))
;;______________________________________________________________________________
;;MATHEMATICA
;;______________________________________________________________________________
(autoload 'math "math" "Starts Mathematica" t)
;(autoload 'math-mode "math" "Mode for editing Mathematica" t)
;(setq auto-mode-alist (cons '("\\.m\\'".math-mode) auto-mode-alist))

;;______________________________________________________________________________
;;MATLAB
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/matlab-emacs")
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list 'auto-mode-alist
             '("\\.m$" . matlab-mode))
;(setq matlab-indent-function t)
(setq matlab-shell-command "~/programs/MATLAB/R2012a/bin/matlab")

;;______________________________________________________________________________
;;SAGE
;;______________________________________________________________________________
(add-to-list 'load-path (expand-file-name "/opt/sage/data/emacs"))
(autoload 'sage "sage")
;(setq sage-command "/opt/sage/sage")
(autoload 'sage-view "sage-view")
(add-hook 'sage-startup-hook 'sage-view 'sage-view-disable-inline-output)

;;______________________________________________________________________________
;;SHELL
;;______________________________________________________________________________
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(comint-buffer-maximum-size 10000)
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-get-old-input (lambda nil "") t)
 '(comint-input-ignoredups t)
 '(comint-input-ring-size 100)
 '(comint-move-point-for-output t)
 '(comint-process-echoes t)
 '(comint-prompt-read-only nil)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(protect-buffer-bury-p nil)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify)))
(ansi-color-for-comint-mode-on)
(defvar my-shells '("*shell*" "*shell0*" "*shell1*" "*shell2*" "*shell3*"))
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)
(defun make-my-shell-output-read-only (text)
  "Add to comint-output-filter-functions to make stdout read only in my shells."
  (if (member (buffer-name) my-shells)
      (let ((inhibit-read-only t)
            (output-end (process-mark (get-buffer-process (current-buffer)))))
        (put-text-property comint-last-output-start output-end 'read-only t))))
(add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)

;; make completion buffers disappear after 3 seconds.
;(add-hook 'completion-setup-hook
;          (lambda() (run-at-time 3 nil
;                                 (lambda () (delete-windows-on "*Completions*")))))

;;______________________________________________________________________________
;;SML
;;______________________________________________________________________________
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
;;TABBAR
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

;(tabbar-mode 1)


;; add a buffer modification state indicator in the tab label,
;; and place a space around the label to make it looks less crowd
(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (setq ad-return-value
        (if (and (buffer-modified-p (tabbar-tab-value tab))
                 (buffer-file-name (tabbar-tab-value tab)))
            (concat " + " (concat ad-return-value " "))
          (concat " " (concat ad-return-value " ")))))
;; called each time the modification state of the buffer changed
(defun ztl-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))
;; first-change-hook is called BEFORE the change is made
(defun ztl-on-buffer-modification ()
  (set-buffer-modified-p t)
  (ztl-modification-state-change))
(add-hook 'after-save-hook 'ztl-modification-state-change)
;; this doesn't work for revert, I don't know
;;(add-hook 'after-revert-hook 'ztl-modification-state-change)
(add-hook 'first-change-hook 'ztl-on-buffer-modification)


;; (defun autohide-tabbar ()
;;   "Make tabbar briefly show itself while
;; you are switching buffers with shortcuts.
;; Tested with GNU Emacs 23
;; - Sabof"
;;   (defvar *tabbar-autohide-delay* 3)

;;   (interactive)
;;   (tabbar-mode nil)
;;   (defvar *tabbar-autohide-timer* nil)
;;   (defun renew-tabbar-autohide-timer ()
;;     (if (timerp *tabbar-autohide-timer*)
;;         (cancel-timer *tabbar-autohide-timer*))
;;     (setf *tabbar-autohide-timer*
;;           (run-with-timer
;;            3 nil (lambda ()
;;                    (tabbar-mode nil)
;;                    (setf *tabbar-autohide-timer*
;;                          nil)))))

;;   (global-set-key
;;    (kbd "H-.")
;;    (lambda ()
;;      (interactive)
;;      (if tabbar-mode
;;          (tabbar-forward)
;;        (tabbar-mode t))
;;      (renew-tabbar-autohide-timer)))
;;   (global-set-key
;;    (kbd "H-,")
;;    (lambda ()
;;      (interactive)
;;      (if tabbar-mode
;;          (tabbar-backward)
;;        (tabbar-mode t))
;;      (renew-tabbar-autohide-timer))))

;; (autohide-tabbar)


(defvar tabbar-autohide-timer nil)
(defun renew-tabbar-autohide-timer ()
  (if (timerp tabbar-autohide-timer)
      (cancel-timer tabbar-autohide-timer))
  (setf tabbar-autohide-timer
        (run-with-timer
         3 nil (lambda ()
                 (tabbar-mode -1)
                 (setf tabbar-autohide-timer nil)))))

(defun tabbar-forward-renew ()
  (interactive)
  (if tabbar-mode
      (tabbar-forward)
    (tabbar-mode t))
  (renew-tabbar-autohide-timer))

(defun tabbar-backward-renew ()
  (interactive)
  (if tabbar-mode
      (tabbar-backward)
    (tabbar-mode t))
  (renew-tabbar-autohide-timer))


;;______________________________________________________________________________
;;TAGS
;;______________________________________________________________________________

(defun create-tags (dir-name)
     "Create tags file."
     (interactive "DDirectory: ")
     (eshell-command
      (format "find %s -type f -name \"*.[ch]\" | etags -L -" dir-name)))


;;;  Jonas.Jarnestrom<at>ki.ericsson.se A smarter
;;;  find-tag that automagically reruns etags when it cant find a
;;;  requested item and then makes a new try to locate it.
;;;  Fri Mar 15 09:52:14 2002
(defadvice find-tag (around refresh-etags activate)
  "Rerun etags and reload tags if tag not found and redo find-tag.
   If buffer is modified, ask about save before running etags."
  (let ((extension (file-name-extension (buffer-file-name))))
    (condition-case err
        ad-do-it
      (error (and (buffer-modified-p)
                  (not (ding))
                  (y-or-n-p "Buffer is modified, save it? ")
                  (save-buffer))
             (er-refresh-etags extension)
             ad-do-it))))
(defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently."
  (interactive)
  (shell-command (format "etags *.%s" (or extension "el")))
  (let ((tags-revert-without-query t))  ; don't query, revert silently
    (visit-tags-table default-directory nil)))

;;______________________________________________________________________________
;;Wanderlust
;;______________________________________________________________________________
;; wanderlust
(load-file "~/.email.el")

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; IMAP
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user my-email-address)
(setq elmo-imap4-default-authenticate-type 'clear)
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "Pilen")
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")

(setq wl-default-folder "%inbox")
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
(setq wl-trash-folder "%[Gmail]/Trash")

(setq wl-folder-check-async t)

(setq elmo-imap4-use-modified-utf7 t)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))
;;______________________________________________________________________________
;;
;;
;;                               FUNCTIONALITY
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
        (progn   (rename-file name new-name 1)   (rename-buffer new-name)        (set-visited-file-name new-name)        (set-buffer-modified-p nil))))))

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
 (progn         (copy-file filename newname 1)  (delete-file filename)  (set-visited-file-name newname)         (set-buffer-modified-p nil)     t))))


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
;;Jump to matching parethesis
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


;;______________________________________________________________________________
;;Swap windows
;;______________________________________________________________________________

(defun swap-with (dir)
  (interactive)
  (let ((other-window (windmove-find-other-window dir)))
    (when other-window
      (let* ((this-window  (selected-window))
             (this-buffer  (window-buffer this-window))
             (other-buffer (window-buffer other-window))
             (this-start   (window-start this-window))
             (other-start  (window-start other-window)))
        (set-window-buffer this-window other-buffer)
        (set-window-buffer other-window this-buffer)
        (set-window-start  this-window other-start)
        (set-window-start  other-window this-start)))))


;;______________________________________________________________________________
;;Eshellcontrol
;;______________________________________________________________________________

(defun my-eshell-execute-current-line ()
  "Insert text of current line in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((command (buffer-substring
                  (save-excursion
                    (beginning-of-line)
                    (point))
                  (save-excursion
                    (end-of-line)
                    (point)))))
    (let ((buf (current-buffer)))
      (unless (get-buffer eshell-buffer-name)
        (eshell))
      (display-buffer eshell-buffer-name t)
      (switch-to-buffer-other-window eshell-buffer-name)
      (end-of-buffer)
      (eshell-kill-input)
      (insert command)
      (eshell-send-input)
      (end-of-buffer)
      (switch-to-buffer-other-window buf))))

(defun eshell/clear ()
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))


;;______________________________________________________________________________
;;Narrow
;;______________________________________________________________________________

(defun narrow-toggle (beg end)
  "If narrow, widen; if not narrowed, narrow!"
  (interactive "r") ; "r" for region
  (if (narrow-p)
    (progn (widen)
      (message "Un-narrowing."))
    (progn (narrow-to-region beg end)
       (message "Narrowing to c%s - c%s." beg end))))

(defun narrow-p ()
  "Whether narrow is in effect for the current buffer"

  (let (real-point-min real-point-max)
    (save-excursion (save-restriction
    (widen)
    (setq real-point-min (point-min)
            real-point-max (point-max))))
    (or
     (/= real-point-min (point-min))
     (/= real-point-max (point-max)))))



;;______________________________________________________________________________
;;Smartscan
;;______________________________________________________________________________

(defvar smart-use-extended-syntax nil
  "If t the smart symbol functionality will consider extended
syntax in finding matches, if such matches exist.")

(defvar smart-last-symbol-name ""
  "Contains the current symbol name.

This is only refreshed when `last-command' does not contain
either `smart-symbol-go-forward' or `smart-symbol-go-backward'")

(make-local-variable 'smart-use-extended-syntax)

(defvar smart-symbol-old-pt nil
  "Contains the location of the old point")

(defun smart-symbol-goto (name direction)
  "Jumps to the next NAME in DIRECTION in the current buffer.

DIRECTION must be either `forward' or `backward'; no other option
is valid."

  ;; if `last-command' did not contain
  ;; `smart-symbol-go-forward/backward' then we assume it's a
  ;; brand-new command and we re-set the search term.
  (unless (memq last-command '(smart-symbol-go-forward
                               smart-symbol-go-backward))
    (setq smart-last-symbol-name name))
  (setq smart-symbol-old-pt (point))
  (message (format "%s scan for symbol \"%s\""
                   (capitalize (symbol-name direction))
                   smart-last-symbol-name))
  (unless (catch 'done
            (while (funcall (cond
                             ((eq direction 'forward) ; forward
                              'search-forward)
                             ((eq direction 'backward) ; backward
                              'search-backward)
                             (t (error "Invalid direction"))) ; all others
                            smart-last-symbol-name nil t)
              (unless (memq (syntax-ppss-context
                             (syntax-ppss (point))) '(string comment))
                (throw 'done t))))
    (goto-char smart-symbol-old-pt)))

(defun smart-symbol-go-forward ()
  "Jumps forward to the next symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'end) 'forward))

(defun smart-symbol-go-backward ()
  "Jumps backward to the previous symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'beginning) 'backward))

(defun smart-symbol-at-pt (&optional dir)
  "Returns the symbol at point and moves point to DIR (either `beginning' or `end') of the symbol.

If `smart-use-extended-syntax' is t then that symbol is returned
instead."
  (with-syntax-table (make-syntax-table)
    (if smart-use-extended-syntax
        (modify-syntax-entry ?. "w"))
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?- "w")
    ;; grab the word and return it
    (let ((word (thing-at-point 'word))
          (bounds (bounds-of-thing-at-point 'word)))
      (if word
          (progn
            (cond
             ((eq dir 'beginning) (goto-char (car bounds)))
             ((eq dir 'end) (goto-char (cdr bounds)))
             (t (error "Invalid direction")))
            word)
        (error "No symbol found")))))

;(global-set-key (kbd "H-n") 'smart-symbol-go-forward)
;(global-set-key (kbd "H-p") 'smart-symbol-go-backward)




;;______________________________________________________________________________
;;Dictionaries
;;______________________________________________________________________________

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "dansk") "english" "dansk")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(let ((langs '("american" "francais" "brasileiro")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))
(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))


;;______________________________________________________________________________
;;Start of line/indentation
;;______________________________________________________________________________
(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))


;;______________________________________________________________________________
;;Windows
;;______________________________________________________________________________
(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))


;;; Made by Søren Pilgård
(defun transpose-up ()
  "Move current line up"
  (interactive)
  (let ((column-number (- (point) (point-at-bol))))
    (kill-whole-line)
    (forward-line -1)
    (yank)
    (setq kill-ring (cdr kill-ring))
    (forward-line -1)
    (move-to-column column-number)))

;;; Made by Søren Pilgård
(defun transpose-down ()
  "Move current line down"
  (interactive)
  (let ((column-number (- (point) (point-at-bol))))
    (kill-whole-line)
    (forward-line 1)
    (yank)
    (setq kill-ring (cdr kill-ring))
    (forward-line -1)
    (move-to-column column-number)))


(defun new-indented-line ()
  "Insert a line below the current and indent it"
  (interactive)
  (end-of-line)
  (newline-and-indent))


(defun create-scratch-buffer ()
  "Create a scratch buffer"
  (interactive)
  (pop-to-buffer (get-buffer-create (generate-new-buffer-name "scratch"))))


;; End of .emacs, go away debugger!
(setq debug-on-error nil)

(defun sudo-edit-current-file ()
  (interactive)
  (let ((pos (point)))
    (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer))))
    (goto-char pos)))

;;______________________________________________________________________________
;;CODE FOLDING
;;______________________________________________________________________________

(defun toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))
(defun cursor-selective-display ()
  "Activate selective display based on the column at point"
  (interactive)
  (set-selective-display
   (if selective-display
       nil
     (+ 1 (current-column)))))



;;______________________________________________________________________________
;;MOVEMENT (by me)
;;______________________________________________________________________________

(defun forward-word-to-newline ()
  (interactive)
  (if (char-equal (char-after) ?\n)
      (search-forward-regexp "[a-zA-Z0-9]+")
    (search-forward-regexp "[[a-zA-Z0-9]+\\|$")))


(defun backward-word-to-newline ()
  (interactive)
  (if (char-equal (char-before) ?\n)
      (progn
        (message "before")
        (backward-char)
        (backward-char)
        (search-backward-regexp "[^a-zA-Z0-9]+[a-zA-Z0-9]+\\|$")
        (forward-char))
    (progn
      (when (char-equal (char-after) ?\n)
        (backward-char))
      (search-backward-regexp "[^a-zA-Z0-9]+[a-zA-Z0-9]+\\|$")
      (forward-char))))






;;______________________________________________________________________________
;;
;;
;;                               Function ideas
;;
;;______________________________________________________________________________

;;______________________________________________________________________________
;;Flipline
;;______________________________________________________________________________
;;abc|def
;;def|abc

;;______________________________________________________________________________
;;Delete entire word under cursor
;;______________________________________________________________________________
