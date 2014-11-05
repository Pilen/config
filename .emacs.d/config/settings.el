;;______________________________________________________________________________
;;
;;
;π                                  SETTINGS
;;
;;______________________________________________________________________________

;;______________________________________________________________________________
;π SETTINGS
;;______________________________________________________________________________
(require 'cl)

(setq inhibit-startup-message t)
(setq default-frame-alist (append (list
                                   '(width  . 80)  ; Width set to 80 characters
                                   '(height . 40)) ; Height set to 60 lines
                                  default-frame-alist))
(setq frame-title-format "%b")
(fset 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(setq-default fill-column 80)
(setq sentence-end-double-space nil)
(setq colon-double-space nil)

(show-paren-mode t)
(setq show-paren-delay 0)
;(require 'mic-paren)
;(paren-activate)
(setq show-paren-style 'expression)

(set-default 'truncate-lines t)

(setq echo-keystrokes 0.01)
(setq use-dialog-box nil)
;; (setq visible-bell t)

(tool-bar-mode 0)
(menu-bar-mode 0)
;(require 'linum+)
(global-linum-mode t)
(winner-mode 1)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq european-calendar-style t)
(setq calendar-week-start-day 1)
(add-hook 'calendar-mode-hook
          (lambda ()
            (set-face-attribute 'calendar-today nil :bold t)))

(setq temporary-file-directory "/tmp/")
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))
(require 'shell-toggle)
(setq shell-toggle-launch-shell 'shell-toggle-eshell)
(require 'pager) ;For smarter scrolling

;enabling this will cause an encoding warning as of Emacs 24.3
;(require 'follow-mouse) ;Active window follows mouse
;(turn-on-follow-mouse)
;(setq follow-mouse-deselect-active-minibuffer nil)

;(delete-selection-mode t)

(require 'volatile-highlights)
(volatile-highlights-mode t)

;(load "~/.emacs.d/plugins/fixed-point-completion.el")
;(enable-fixed-point-completions)

(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 10000)
(add-to-list 'recentf-exclude ".breadcrumb")
(add-to-list 'recentf-exclude ".emacs")
(add-to-list 'recentf-exclude ".ido.last")
(setq recentf-save-timer (run-at-time t (* 60 60) (lambda () (recentf-save-list))))
;(cancel-timer recentf-save-timer)

(require 'goto-last-change)

(require 'uniquify)

(require 'caps-mode)

(defvar sql-sqlite-program "sqlite3")


;(require 'rfringe)
;(set-fringe-mode '(1 . 0))
(set-fringe-mode '(0 . 0))
;; -i dont like $ or \ to be displayed at lines too long (forced from Emacs 24.3)
(set-display-table-slot standard-display-table 'truncation ?\n)
(set-display-table-slot standard-display-table 'wrap ?\n)

(defalias 'el 'emacs-lisp-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0)
(require 'c-eldoc)
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)


(setq recenter-positions '(top middle bottom))
(require 'chop)

(require 'google-translate)
(setq google-translate-default-source-language "da")
(setq google-translate-default-target-language "en")

(defun google-translate-da/en ()
  (interactive)
  (if (region-active-p)
      (google-translate-translate "da" "en" (buffer-substring (region-beginning) (region-end)))
    (let ((google-translate-default-source-language "da")
          (google-translate-default-target-language "en"))
      (google-translate-query-translate))))

(defun google-translate-en/da ()
  (interactive)
  (if (region-active-p)
      (google-translate-translate "en" "da" (buffer-substring (region-beginning) (region-end)))
    (let ((google-translate-default-source-language "en")
          (google-translate-default-target-language "da"))
      (google-translate-query-translate))))

;; (add-to-list 'load-path "~/.emacs.d/plugins/predictive/")
;; (require 'predictive)
;; (set-default 'predictive-auto-add-to-dict t)
;; (setq predictive-main-dict 'rpg-dictionary
;;       predictive-auto-learn t
;;       predictive-add-to-dict-ask nil
;;       predictive-use-auto-learn-cache nil
;;       predictive-which-dict t)

;;Highlight current line
(require 'hlinum)
(global-hl-line-mode 1)


;(setq line-move-visual nil)

;; uses find-file-at-point
(fset 'find-file-at-point-no-enter
      (lambda (&optional arg) "Keyboard macro."
        (interactive "p")
        (kmacro-exec-ring-item
         (quote ([16777313 102 105 110 100 45 102 105 108 101 45 97 116 45 112 111 105 110 116 return return] 0 "%d")) arg)))


(setq prolog-system (quote gnu))

(require 'visible-mark)
(set-face-background 'visible-mark-face1 "DarkSlateGray4")
(set-face-background 'visible-mark-face1 "SkyBlue4")
(set-face-background 'visible-mark-face1 "DodgerBlue4")
(global-visible-mark-mode)
(setq visible-mark-inhibit-trailing-overlay nil)


;; (add-to-list 'load-path "~/.emacs.d/plugins/multiple-cursors/")
;; (load-file "~/.emacs.d/plugins/multiple-cursors/multiple-cursors.el")
(require 'multiple-cursors)

;; This is what you probably want if you are using a tiling window
;; manager under X, such as ratpoison.
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(require 'fuzzy)

(require 'cafeen)

(add-hook 'erlang-shell-mode-hook 'next-error-follow-minor-mode)
(add-hook 'compilation-mode-hook 'next-error-follow-minor-mode)
(add-hook 'occur-mode-hook 'next-error-follow-minor-mode)



(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)
(setq keyfreq-file "~/Dropbox/emacs/keyfreq")

(require 'xpdfremote)

(require 'semantic)
;(semantic-mode 1)

(fset 'el-headlines
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217786 40 111 99 99 117 114 32 34 59 960 34 41 return] 0 "%d")) arg)))

(require 'inf-ruby)
(define-key inf-ruby-mode-map (kbd "<up>") 'comint-previous-input)
(define-key inf-ruby-mode-map (kbd "<down>") 'comint-next-input)

(require 'help-mode)
(define-key help-mode-map (kbd "H-J") 'help-goto-file)
(fset 'help-goto-file
   [?\M-: ?\( ?b ?e ?g ?i ?n ?n ?i ?n ?g ?- ?o ?f ?- ?b ?u ?f ?f ?e ?r ?\) return ?\M-: ?\( ?s ?e ?a ?r ?c ?h ?- ?f ?o ?r ?w ?a ?r ?d ?  ?\" ?` ?\" ?\) return return])

(require 'smex)
(smex-initialize)
(setq smex-save-file "~/.emacs.d/.smex-items")


(setq-default require-final-newline t)

(setq delete-active-region nil)

(require 'wrap-region)
(wrap-region-global-mode)
(wrap-region-add-wrapper "(" ")" ")")
(wrap-region-add-wrapper "[" "]" "]")
(wrap-region-add-wrapper "{" "}" "}")
(wrap-region-add-wrapper "<" ">" ">")
(wrap-region-add-wrapper "``" "''" "`")
(wrap-region-add-wrapper "``" "''" "'")

(defun wrap-region-with (left right)
  "Wraps region with LEFT and RIGHT."
  (run-hooks 'wrap-region-before-wrap-hook)
  (let ((beg (region-beginning))
        (end (region-end))
        (pos (point))
        (deactivate-mark nil))
    (save-excursion
      (goto-char beg)
      (insert left)
      (goto-char (+ end (length left)))
      (insert right))
    (if (= pos end) (forward-char (length right)))
    (if wrap-region-keep-mark
        (let* ((beg-p (eq beg pos))
               (beg* (+ beg (length left)))
               (end* (+ end (length left))))
          (push-mark (if beg-p end* beg*) nil t)
          (goto-char (if beg-p beg* end*)))
      (deactivate-mark)))
  (run-hooks 'wrap-region-after-wrap-hook))

(require 'zeal-at-point)

(require 'lorem-ipsum)

;;______________________________________________________________________________
;π FILL-COLUMN-INDICATOR
;;______________________________________________________________________________
;; (require 'fill-column-indicator)
;; (setq fci-rule-color "gray32")
;; (setq-default fill-column 80)
;; (setq fci-always-use-textual-rule 1)
;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (global-fci-mode 1)

;; todo why is this not working add hook to fundamental mode
(require 'column-marker)
(column-marker-1 fill-column)
(set-face-attribute 'column-marker-1 nil
                    ;; :background "gray44")
                    :background "gray20")
(column-marker-1 fill-column)
(add-hook 'prog-mode-hook (lambda () (column-marker-1 fill-column)))

;;______________________________________________________________________________
;π STARTUP
;;______________________________________________________________________________
(setq inhibit-startup-message t)
(defun display-startup-echo-area-message ()
  (message ""))
(find-file "~/.emacs.d/init.el")
                                        ;(switch-to-buffer "blank")
(if (not (eq nil (get-buffer "*scratch*")))
    (kill-buffer "*scratch*"))
(if (not (eq nil (get-buffer "*Messages*")))
    (kill-buffer "*Messages*"))

;;______________________________________________________________________________
;π SPEEDBAR
;;______________________________________________________________________________

;; (require 'sr-speedbar)
;; (setq speedbar-use-images nil)
;; (define-key speedbar-mode-map (kbd "<tab>") 'speedbar-toggle-line-expansion)
;; (define-key speedbar-mode-map (kbd "<backspace>") 'speedbar-up-directory)

;;______________________________________________________________________________
;π CONSOLE
;;______________________________________________________________________________
(xterm-mouse-mode t)

;;______________________________________________________________________________
;π AUTO-SAVE
;;______________________________________________________________________________
(setq auto-save-default 1)
(setq auto-save-visited-file-name nil) ;;Dont save to current file
(setq delete-auto-save-files 1) ;;Delete autosaves on save
(setq check-auto-save 1) ;;check wether autosave is the most recent on revert-buffer
                                        ;(require 'auto-save)

(setq auto-save-list-file-prefix "~/Dropbox/emacs/autosaves/")
;; (setq auto-save-file-name-transforms
;;       (quote ((".*" . "~/Dropbox/emacs/autosavefiles"))))


;;______________________________________________________________________________
;π BACKUPS
;;______________________________________________________________________________
(setq make-backup-files t)
(setq backup-by-copying t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups"))))
(setq delete-old-versions t)

;;______________________________________________________________________________
;π BUFFERS
;;______________________________________________________________________________
(setq default-major-mode 'text-mode)

;;Highlight lines
;(global-hl-line-mode 1)


;;______________________________________________________________________________
;π CURSOR
;;______________________________________________________________________________
(setq default-cursor-type 'box)
(defadvice overwrite-mode (after overwrite-mode)
  (if overwrite-mode
      (setq cursor-type '(bar . 1))
    (setq cursor-type 'box)))
(ad-activate 'overwrite-mode)


;;______________________________________________________________________________
;π SAVE POSITION BETWEEN SESSIONS
;;______________________________________________________________________________
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)
