;;______________________________________________________________________________
;π UNBIND
;;______________________________________________________________________________

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


;; (define-key input-decode-map [#x2000009] [#x6000069]) ; C-S-i
;; (define-key input-decode-map [#x200000d] [#x600006d]) ; C-S-m
;; (define-key input-decode-map "\C-i" [#x4000069])
;; (define-key input-decode-map "\C-m" [#x400006d])
;; (define-key input-decode-map "\C-[" [#x400005b])

;; (define-key input-decode-map [#x2000009] nil) ; C-S-i
;; (define-key input-decode-map [#x200000d] nil) ; C-S-m
;; (define-key input-decode-map "\C-i" nil)
;; (define-key input-decode-map "\C-m" nil)
;; (define-key input-decode-map "\C-[" nil)
;; (setq input-decode-map (delq '(9) input-decode-map))
;; (setq input-decode-map '(keymap))i

;; (setq local-function-key-map (remove '(kp-tab . [9]) local-function-key-map))
;; (setq function-key-map (remove '(kp-tab . [9]) function-key-map))
;; (equal (remove '(kp-tab . [9]) local-function-key-map)
;;        local-function-key-map)

;;______________________________________________________________________________
;π GLOBAL BINDINGS
;;______________________________________________________________________________

;;;; CURSOR MOVEMENTS
;; Single char cursor movement
;(global-set-key (kbd "H-n") 'backward-char)
;(global-set-key (kbd "H-i") 'forward-char)
(global-set-key (kbd "H-n") 'left-char)
(global-set-key (kbd "H-i") 'right-char)
(global-set-key (kbd "H-u") 'previous-line)
(global-set-key (kbd "H-e") 'next-line)
;; Move by word
;; (global-set-key (kbd "H-l") 'geosoft-backward-word)
(global-set-key (kbd "H-l") 'backward-word-to-newline) ;; geosoft-backward-word
(global-set-key (kbd "H-y") 'forward-word-to-newline)  ;; forward-word
(global-set-key (kbd "H-8") 'forward-same-syntax)
(global-set-key (kbd "H-*") (lambda () (interactive) (forward-same-syntax -1)))
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
(global-set-key (kbd "H-h") 'end-of-buffer)
(global-set-key (kbd "H-H") 'beginning-of-buffer)
;; isearch
;(global-set-key (kbd "H-o") 'isearch-forward)
;(global-set-key (kbd "H-O") 'isearch-backward)
 (global-set-key (kbd "H-g") 'recenter)

;;;; MAJOR EDITING COMMANDS
;; Delete previous/next char
(global-set-key (kbd "H-s") 'delete-backward-char)
(global-set-key (kbd "H-t") 'delete-forward-char)
(global-set-key (kbd "H-C-s") 'my-scroll-left)
(global-set-key (kbd "H-C-t") 'my-scroll-right)
;; Delete previous/next word
(global-set-key (kbd "H-f") 'backward-kill-word-to-newline)
(global-set-key (kbd "H-p") 'forward-kill-word-to-newline)
;; Copy Cut Paste, Paste previous
;;lobal-set-key (kbd "H-x") 'kill-region) ; C-w
;(global-set-key (kbd "H-c") 'kill-ring-save)
;(global-set-key (kbd "H-v") 'yank)
;(global-set-key (kbd "H-V") 'yank-pop)
;(global-set-key (kbd "H-C") 'copy-all)
;(global-set-key (kbd "H-X") 'cut-all)
;; Undo and redo
;(global-set-key (kbd "H-Z") 'redo)
(global-set-key (kbd "H-z") 'undo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "H-w") 'kill-ring-save)

;; Kill line
;(global-set-key (kbd "H-d") 'kill-line)
(global-set-key (kbd "H-d") 'kill-whole-line)

;;;; Textual Transformation
(global-set-key (kbd "H-S-SPC") '(lambda () (interactive) (mark-paragraph) (right-char)))
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
;(global-set-key (kbd "H-k") 'keyboard-escape-quit)
;; Mark point
(global-set-key (kbd "C-SPC") 'set-mark-command)
(global-set-key (kbd "H-a") 'execute-extended-command)
;; (global-set-key (kbd "H-A") 'shell-toggle)
(global-set-key (kbd "H-A") 'my-eshell-open)
(global-set-key (kbd "H-C-a") 'ido-M-X)

;;;; WINDOW SPLITTING
;(global-set-key (kbd "H-r") 'move-cursor-next-pane)
;(global-set-key (kbd "H-R") 'move-cursor-previous-pane)

;;;; OTHER SHORTCUTS
;(global-set-key (kbd "H-~") 'switch-to-previous-frame)
;(global-set-key (kbd "H-`") 'switch-to-next-frame)

;(global-set-key (kbd "H-8") 'extend-selection)
;(global-set-key (kbd "H-*") 'select-text-in-quote)

(global-set-key (kbd "H-v") 'goto-last-change)
(global-set-key (kbd "H-V") 'pop-to-mark-command)





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
(global-set-key (kbd "H-m") 'swiper)
(global-set-key (kbd "H-M") 'sprint-forward)
(global-set-key (kbd "H-c") 'ace-jump-char-local)
(global-set-key (kbd "H-C") 'ace-jump-char-global)

;(global-set-key (kbd "H-V") '(lambda () (interactive) (global-hl-line-mode) (my-global-auto-highlight-symbol-mode)))
(global-set-key (kbd "H-S-<return>") 'ido-goto-symbol-or-line)

(global-set-key (kbd "H-SPC") 'hippie-expand)
(global-set-key (kbd "H-C-SPC") 'my-ido-hippie-expand)
(global-set-key (kbd "H-o") 'other-window)
(global-set-key (kbd "H-O") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "H-'") 'win-switch-dispatch)
(global-set-key (kbd "H-\"") 'set-80-columns)
;(global-set-key (kbd "H-'") 'switch-to-buffer)
;(global-set-key (kbd "H-,") 'previous-buffer)
;(global-set-key (kbd "H-.") 'next-buffer)
;(global-set-key (kbd "H-g") 'goto-line)
(global-set-key (kbd "H-<return>") 'ido-switch-buffer)
;(global-set-key (kbd "H-<return>") 'idobuffer)
(global-set-key (kbd "S-<return>") 'new-indented-line)
;(global-set-key (kbd "S-<return>>") 'reindent-then-newline-and-indent)
(global-set-key (kbd "H-<backspace>") 'join-line)

;; (global-set-key (kbd "H-,") 'tabbar-backward-renew)
;; (global-set-key (kbd "H-.") 'tabbar-forward-renew)
;; (global-set-key (kbd "H-<") 'tabbar-backward-group)
;; (global-set-key (kbd "H->") 'tabbar-forward-group)
;; (global-set-key (kbd "H-<menu>") 'tabbar-press-home)
(global-set-key (kbd "H-,") '(lambda () (interactive) (ahs-highlight-now) (ahs-backward)))
(global-set-key (kbd "H-.") '(lambda () (interactive) (ahs-highlight-now) (ahs-forward)))
(global-set-key (kbd "H-<") '(lambda () (interactive) (ahs-highlight-now) (ahs-backward-definition)))
(global-set-key (kbd "H->") '(lambda () (interactive) (ahs-highlight-now) (ahs-forward-definition)))

;;(global-set-key (kbd "<menu>") 'idobuffer)
(global-set-key (kbd "<menu>") 'ibuffer)
(global-set-key (kbd "S-<menu>") 'menu-bar-mode)

(global-set-key (kbd "H-D") 'create-scratch-buffer)
;;END

;;New layout
;;(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "colemak")
;; load ErgoEmacs keybinding
;;(load "~/.emacs.d/plugins/ergoemacs-keybindings-5.3.4/ergoemacs-mode")
;; turn on minor mode ergoemacs-mode
;;(ergoemacs-mode 1)

(global-set-key (kbd "H-/") 'query-replace-with-region)
(global-set-key (kbd "H-?") 'loccur-current)
;;(global-set-key (kbd "H-?") 'query-replace-regexp)
(global-set-key (kbd "H-\\") 'delete-window)
(global-set-key (kbd "H-|") 'delete-other-windows)
(global-set-key (kbd "H-:") 'split-window-vertically)
(global-set-key (kbd "H-;") 'split-window-horizontally)
;(global-set-key (kbd "H-r") 'transpose-lines)
(global-set-key (kbd "H-r") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "H-R") 'align-regexp)
(global-set-key (kbd "H-]") 'golden-ratio)
(global-set-key (kbd "H-C-]") 'golden-ratio-toggle)
(global-set-key (kbd "H-}") 'balance-windows)

;(global-set-key (kbd "H-}") 'tiling-cycle)
;(global-set-key (kbd "H-]") '(lambda nil (interactive) (kill-buffer (current-buffer))))
;(global-set-key (kbd "H-}") 'kill-buffer-and-window)

(global-set-key (kbd "H-F") 'transpose-up)
(global-set-key (kbd "H-P") 'transpose-down)
(global-set-key (kbd "H-G") 'transpose-words)

;(global-set-key (kbd "H-q") 'goto-match-paren)
;(global-set-key (kbd "H-j") 'my-anything)
;; (global-set-key (kbd "H-j") 'recentf-ido-find-file)
;; (global-set-key (kbd "H-J") 'find-file-at-point-no-enter)
(global-set-key (kbd "H-j") 'projectile-find-file-dwim)
(global-set-key (kbd "H-J") 'recentf-ido-find-file)
(global-set-key (kbd "H-C-j") 'find-file-at-point-no-enter)

(global-set-key (kbd "H-q") 'mc/mark-next-like-this)
(global-set-key (kbd "H-Q") 'mc/edit-lines)
(global-set-key (kbd "H-C-q") 'mc/mark-all-like-this)


(global-set-key (kbd "H-<insert>") 'global-hl-line-mode)
(global-set-key (kbd "H-S-<insert>") 'linum-mode)
(global-set-key (kbd "H-<delete>") 'global-whitespace-mode)
(global-set-key (kbd "H-S-<delete>") 'auto-indent-mode)

(global-set-key (kbd "H-<home>") '(lambda nil (interactive) (defaultface)))
(global-set-key (kbd "H-<end>") '(lambda nil (interactive) (zoom 1)))
(global-set-key (kbd "H-C-<end>") (lambda () (interactive) (zoom -1)))
(global-set-key (kbd "H-S-<end>") '(lambda nil (interactive) (zoomableface)))

(global-set-key (kbd "H-<tab>") 'goto-match-paren-or-defun)
(global-set-key (kbd "<H-S-iso-lefttab>") 'switch-to-minibuffer-window)

(global-set-key (kbd "H-[") 'winner-undo)
(global-set-key (kbd "H-{") 'winner-redo)
(global-set-key (kbd "H-`") 'flymake-goto-next-error)
(global-set-key (kbd "H-~") 'flymake-mode)

(global-set-key (kbd "H-1") 'bc-set)
(global-set-key (kbd "H-2") 'bc-local-previous)
(global-set-key (kbd "H-3") 'bc-local-next)
(global-set-key (kbd "H-#") 'bc-list)
(global-set-key (kbd "H-4") 'fill-paragraph)
(global-set-key (kbd "H-$") 'fill-paragraph-from-current-line)

(global-set-key (kbd "H-7") 'toggle-selective-display)
(global-set-key (kbd "H-&") 'cursor-selective-display)

;; (global-set-key (kbd "H-λ") 'find-tag)
;; (global-set-key (kbd "H-π") 'tags-apropos)
;; (global-set-key (kbd "H-=") 'pop-tag-mark)

(global-set-key (kbd "H-9") 'smart-backward)
(global-set-key (kbd "H-0") 'smart-forward)
(global-set-key (kbd "H-(") 'beginning-of-defun)
(global-set-key (kbd "H-)") 'end-of-defun)

(global-set-key (kbd "<f1>") 'my-help)
(global-set-key (kbd "S-<f1>") 'man)
;; (global-set-key (kbd "<f1>") 'google-translate-da/en)
;; (global-set-key (kbd "S-<f1>") 'google-translate-en/da)
;; (global-set-key (kbd "H-<f1>") 'flyspell-mode)
;; (global-set-key (kbd "<f2>") 'flyspell-buffer)
(global-set-key (kbd "<f2>") 'flyspell-mode)
;; (global-set-key (kbd "H-<f2>") 'fd-switch-dictionary)
(global-set-key (kbd "S-<f2>") 'fd-switch-dictionary-flyspell)
(global-set-key (kbd "<f3>") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "<H-f3>") 'kmacro-name-last-macro)
(global-set-key (kbd "<f4>") 'kmacro-end-or-call-macro)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f7>") 'toggle-window-dedicated)
;; (global-set-key (kbd "<f8>") 'narrow-toggle)
(global-set-key (kbd "<f8>") 'narrow-to-region-indirect)
(global-set-key (kbd "C-<f8>") 'clone-buffer)
(global-set-key (kbd "S-<f8>") 'narrow-to-defun)
;(global-set-key (kbd "<f9>") 'shell-command-on-region-replace)
(global-set-key (kbd "<f9>") 'command-center)
(global-set-key (kbd "<f10>") 'reftex-toc-other-window)
(global-set-key (kbd "<f11>") 'LaTeX-environment)
(global-set-key (kbd "H-<f11>") 'LaTeX-close-environment)
(global-set-key (kbd "S-<f11>") 'LaTeX-insert-matrix)
(global-set-key (kbd "<f12>") (lambda () (interactive) (save-buffer) (preview-buffer)))
(global-set-key (kbd "H-<f12>") 'preview-clearout-buffer)

(global-set-key (kbd "<print>") 'my-magit-status)

(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "M-SPC") 'fixup-whitespace) ;make it context aware.

(global-set-key (kbd "H-C-u") 'chop-move-up)
(global-set-key (kbd "H-C-e") 'chop-move-down)


(add-hook 'comint-mode-hook (lambda ()
   (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
   (define-key comint-mode-map (kbd "<down>") 'comint-next-input)))

(global-set-key (kbd "H-C-.") '(lambda () (interactive) (if (char-equal (char-before) ?\s) (insert "->") (insert " ->")) (if (not (char-equal (char-after) ?\s )) (insert " ") (forward-char))))
(global-set-key (kbd "H-C-,") '(lambda () (interactive) (if (char-equal (char-before) ?\s) (insert "<-") (insert " <-")) (if (not (char-equal (char-after) ?\s )) (insert " ") (forward-char))))

(add-hook 'multiple-cursors-mode-enabled-hook (lambda ()
                                                (define-key mc/keymap (kbd "<return>") 'newline)))

(global-set-key (kbd "C-y") 'yank)
(global-set-key (kbd "C-S-y") 'yank-or-pop)
(global-set-key (kbd "H-C-y") (lambda () (interactive) (insert (x-get-selection-value))))

(global-set-key (kbd "H-x") 'xpdfremote/xpdf-pageDown)
(global-set-key (kbd "H-X") 'xpdfremote/xpdf-pageUp)
(global-set-key (kbd "H-C-x") 'xpdfremote/open-matching-file)

(global-set-key (kbd "H-k") 'erc-start-or-switch)
(global-set-key (kbd "H-k") 'company-complete)

;; (global-set-key (kbd "<XF86Launch1>") 'sr-speedbar-toggle)

(global-set-key (kbd "C-x C-x") (lambda () (interactive) (exchange-point-and-mark) (deactivate-mark) ))

(global-set-key (kbd "<pause>") 'stop-using-minibuffer)
