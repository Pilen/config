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

(setq text-quoting-style 'grave)

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

(setq-default truncate-lines t)

(setq font-lock-maximum-decoration '((arduino-mode . 2) (t . t)))
(setq echo-keystrokes 0.01)
(setq use-dialog-box nil)
;; (setq visible-bell t)

(tool-bar-mode 0)
(menu-bar-mode 0)
;(require 'linum+)
(setq linum-eager nil)
(global-linum-mode t)
(winner-mode 1)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

(setq european-calendar-style t)
(setq calendar-week-start-day 1)
(add-hook 'calendar-mode-hook
          (lambda ()
            (set-face-attribute 'calendar-today nil :bold t)))
(add-hook 'calendar-today-visible-hook
          'calendar-mark-today)

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
(setq recentf-save-file "~/.emacs.d/recentf")
(setq recentf-max-saved-items 10000)
(add-to-list 'recentf-exclude ".breadcrumb")
;; (add-to-list 'recentf-exclude ".emacs")
(add-to-list 'recentf-exclude ".ido.last")
(progn
  (when (bound-and-true-p recentf-save-timer)
    (cancel-timer recentf-save-timer)
    (setq recentf-save-timer nil))
  (setq recentf-save-timer (run-at-time t (* 60 60) (lambda () (recentf-save-list)))))

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
;; (require 'c-eldoc)
;; (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)


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

;;
(fset 'find-file-at-point-no-enter
      (lambda (&optional arg) "Keyboard macro.\nM-x find-file-at-point return return"
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

(require 'ediff)
;; This is what you probably want if you are using a tiling window
;; manager under X, such as ratpoison.
(setq ediff-window-setup-function 'ediff-setup-windows-plain) ;; Same frame
;; (setq ediff-window-setup-function 'ediff-setup-windows-default) ;; Same frame
(setq ediff-split-window-function 'split-window-horizontally)
(set-face-background 'ediff-even-diff-A "gray40")
(set-face-background 'ediff-even-diff-B "gray40")
(set-face-background 'ediff-even-diff-C "gray40")
(set-face-background 'ediff-even-diff-Ancestor "gray40")
(set-face-background 'ediff-odd-diff-A "gray40")
(set-face-background 'ediff-odd-diff-B "gray40")
(set-face-background 'ediff-odd-diff-C "gray40")
(set-face-background 'ediff-odd-diff-Ancestor "gray40")

(require 'fuzzy)

;(require 'cafeen)

(add-hook 'erlang-shell-mode-hook 'next-error-follow-minor-mode)
(add-hook 'compilation-mode-hook 'next-error-follow-minor-mode)
(add-hook 'occur-mode-hook 'next-error-follow-minor-mode)


(dimmer-mode)
(setq dimmer-percent 0.15)


(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)
(setq keyfreq-file "~/.emacs.d/keyfreq")

(require 'xpdfremote)

(require 'semantic)
;(semantic-mode 1)

(fset 'el-headlines
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217786 40 111 99 99 117 114 32 34 59 960 34 41 return] 0 "%d")) arg)))

(require 'inf-ruby)
(define-key inf-ruby-mode-map (kbd "<up>") 'comint-previous-input)
(define-key inf-ruby-mode-map (kbd "<down>") 'comint-next-input)

(setq comint-prompt-read-only t)
(define-key comint-mode-map (kbd "C-l") 'my-clear)
(defun my-clear ()
  (interactive)
  (eshell/clear)
  (comint-send-input))

(require 'help-mode)
(define-key help-mode-map (kbd "H-J") (lambda () (interactive) (goto-char (point-min)) (forward-button 1) (push-button)))

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

(setq tramp-default-method "ssh")
;; ;; http://irreal.org/blog/?p=895
;; Not needed, just works now    cd /sudo:root@smxp:/opt/
;; (add-to-list 'tramp-default-proxies-alist
;;              '(nil "\\`root\\'" "/ssh:%h:"))
;; (add-to-list 'tramp-default-proxies-alist
;;              '((regexp-quote (system-name)) nil nil))

(setq view-read-only t)

(defadvice message (after message-tail activate)
  nil)

(defadvice message (after message-tail activate)
  "Go to point max after a message"
  (unless (string-equal (buffer-name) "*Messages*")
    (with-current-buffer "*Messages*"
      (goto-char (point-max))
      (skip-syntax-backward " ")
      (let ((p (point)))
        (walk-windows
         (lambda (window)
           (if (string-equal (buffer-name (window-buffer window)) "*Messages*")
               (set-window-point window p)))
         nil
         t)))))

(glasses-mode t)
(setq glasses-original-separator "")
(setq glasses-separate-parentheses-p nil)
(setq glasses-separate-capital-groups nil)
;; (setq glasses-separator "‿")
;; (setq glasses-separator "﹀")
;; (setq glasses-separator "︿")
;; (setq glasses-separator "␣")
;; (setq glasses-separator "▿")
;; (setq glasses-separator "▾")
;; (setq glasses-separator "▶")
;; (setq glasses-separator "▷")
;; (setq glasses-separator "▹")
;; (setq glasses-separator "▸")
;; (setq glasses-separator "◣")
;; (setq glasses-separator "◺")
;; (setq glasses-separator "▲")
;; (setq glasses-separator "△")
;; (setq glasses-separator "▵")
(setq glasses-separator "▴")
(glasses-set-overlay-properties)

;; (set-face-background)
;; HTMLabs
;; abcHTMLabsDEF
;; unReadable_stuff
;; unreadableIdentifiersLikeThis


(setq browse-url-browser-function 'browse-url-default-browser)
(setq browse-url-browser-function 'browse-url-chromium)
(setq browse-url-chromium-arguments nil)
(setq browse-url-chromium-arguments '("--new-window"))


(require 'man)
(define-key Man-mode-map (kbd "u") (lambda () (interactive) (pager-scroll-screen -8)))
(define-key Man-mode-map (kbd "e") (lambda () (interactive) (pager-scroll-screen 8)))


;; If deleting the prompts is suddenly possible, it might be that comint-prompt-read-only is somehow set to nil (should be t)
(setq comint-prompt-read-only t)


(setq save-interprogram-paste-before-kill t)

(define-key minibuffer-local-map (kbd "H-u") 'previous-line-or-history-element)
(define-key minibuffer-local-map (kbd "H-e") 'next-line-or-history-element)
;; (setq minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
;; (setq minibuffer-prompt-properties (plist-put minibuffer-prompt-properties 'point-entered 'minibuffer-avoid-prompt))


(setq markdown-command "/usr/bin/pandoc")



(customize-set-variable
 'minibuffer-prompt-properties
 (quote (read-only t cursor-intangible t face minibuffer-prompt)))

;;______________________________________________________________________________
;π COMPLETIONS
;;______________________________________________________________________________

(define-key completion-list-mode-map (kbd "H-u") 'previous-completion)
(define-key completion-list-mode-map (kbd "H-e") 'next-completion)

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
(add-hook 'prog-mode-hook (lambda () (column-marker-1 fill-column)))
(add-hook 'jde-mode-hook (lambda () (column-marker-1 fill-column)))


(setq ps-paper-type 'a4)

;;______________________________________________________________________________
;π STARTUP
;;______________________________________________________________________________
(setq inhibit-startup-message t)
(with-current-buffer (get-buffer-create (generate-new-buffer-name "lock"))
  (emacs-lock-mode 'exit))
(defun display-startup-echo-area-message ()
  (message ""))
(find-file "~/.emacs.d/init.el")
                                        ;; (switch-to-buffer "blank")
(if (not (eq nil (get-buffer "*scratch*")))
    (kill-buffer "*scratch*"))
;; (if (not (eq nil (get-buffer "*Messages")))
;;    (kill-buffer "*Messages*"))

;;______________________________________________________________________________
;π SPEEDBAR
;;______________________________________________________________________________

;; (require 'sr-speedbar)
;; (setq speedbar-use-images nil)
;; (define-key speedbar-mode-map (kbd "<tab>") 'speedbar-toggle-line-expansion)
;; (define-key speedbar-mode-map (kbd "<backspace>") 'speedbar-up-directory)

;; Using neotree instead
(require 'neotree)
(setq neo-theme 'ascii)
(define-key neotree-mode-map (kbd "e") (lambda () (interactive)
                                         (let ((default-directory (neo-buffer--get-filename-current-line)))
                                           (when (not (file-directory-p default-directory))
                                             (setq default-directory (file-name-directory default-directory)))
                                           (eshell/new default-directory))))
;; (define-key neotree-mode-map (kbd "b") (lambda () (interactive) (goto-char (point-min)) (neotree-change-root)))
(define-key neotree-mode-map (kbd "b") (lambda () (interactive) (goto-char (point-min)) (neotree-next-line) (neotree-change-root)))
(define-key neotree-mode-map (kbd "b") 'neotree-select-up-node)
(define-key neotree-mode-map (kbd "c") 'neotree-change-root)
(define-key neotree-mode-map (kbd "m") 'my-neotree-move-buffer-file)
(define-key neotree-mode-map (kbd "C-x C-F") 'my-neotree-find-file-here)

(setq neo-window-width 35)
;; (setq neo-vc-integration nil)

(defun my-neotree-here ()
  (interactive)
  (neotree-dir default-directory))

(defun my-neotree ()
  (interactive)
  (if (eq major-mode 'neotree-mode)
      (neotree-hide)
    (neotree)))

(setq neo-show-hidden-files t)
(defface neo-hidden-face
  '((((background dark)) (:foreground "DimGray"))
    (t                   (:foreground "DimGray")))
  "*Face used for hidden face in neotree buffer."
  :group 'neotree :group 'font-lock-highlighting-faces)
(set-face-foreground 'neo-hidden-face "DimGray")

;; Updated to "hide" hidden files
(defun neo-buffer--insert-file-entry (node depth)
  (let ((node-short-name (neo-path--file-short-name node))
        (vc (when neo-vc-integration (neo-vc-for-node node))))
    (insert-char ?\s (* (- depth 1) 2)) ; indent
    (when (memq 'char neo-vc-integration)
      (insert-char (car vc))
      (insert-char ?\s))
    (neo-buffer--insert-fold-symbol 'leaf node-short-name)
    (insert-button node-short-name
                   'follow-link t
                   'face (if (neo-filepath-hidden-p node) ;; Inserted this
                             'neo-hidden-face             ;; Inserted this
                           (if (memq 'face neo-vc-integration)
                               (cdr vc)
                             neo-file-link-face))
                   'neo-full-path node
                   'keymap neotree-file-button-keymap
                   'help-echo (neo-buffer--help-echo-message node-short-name))
    (neo-buffer--node-list-set nil node)
    (neo-buffer--newline-and-begin)))



(defun my-neotree-keep-size (frame)
  (when (and (frame-size-changed-p frame) (neo-global--window-exists-p))
    (neo-global--reset-width)
    ;; (message "frame resized")
    ))
(push 'my-neotree-keep-size window-size-change-functions)

(defun my-neotree-find-file-here ()
  (interactive)
  (cd (neo-path--match-path-directory (neo-buffer--get-filename-current-line neo-buffer--start-node)))
  (call-interactively 'find-file))

(defun my-neotree-move-buffer-file ()
  (interactive)
  (let* ((file (neo-buffer--get-filename-current-line))
         (buffer (find-buffer-visiting file))
         (dir (read-directory-name "Move to: " (file-name-directory file)))
         (newfile (concat dir (file-name-nondirectory file))))
    (when buffer
      (with-current-buffer buffer (set-visited-file-name newfile nil t)))
    (rename-file file newfile)
    (neo-buffer--refresh t)
    newfile
    ))

;;______________________________________________________________________________
;π CONSOLE
;;______________________________________________________________________________
(xterm-mouse-mode t)

(when (display-graphic-p)
  (global-set-key (kbd "C-x C-z") nil))

;;______________________________________________________________________________
;π AUTO-SAVE
;;______________________________________________________________________________
(setq auto-save-default 1)
(setq auto-save-visited-file-name nil) ;;Dont save to current file
(setq delete-auto-save-files 1) ;;Delete autosaves on save
(setq check-auto-save 1) ;;check wether autosave is the most recent on revert-buffer
                                        ;(require 'auto-save)

;; (setq auto-save-list-file-prefix "~/Dropbox/emacs/autosaves/")
(setq auto-save-list-file-prefix "~/.emacs.d/auto-save-list/.saves-")
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


;; TODO: do better
;; (add-to-list 'load-path "~/.emacs.d/plugins/emacs-colorpicker")
;; (require 'colorpicker)

;;______________________________________________________________________________
;π DIRED
;;______________________________________________________________________________
(setq dired-listing-switches "-alhF --group-directories-first")

;;______________________________________________________________________________
;π MAGIT
;;______________________________________________________________________________
(magit-todos-mode)
(setq magit-commit-show-diff nil)
(defun my-magit-status ()
  (interactive)
  (if (derived-mode-p 'magit-status-mode)
      (let* ((status-buffers-raw (--filter (with-current-buffer it (derived-mode-p 'magit-status-mode)) (buffer-list)))
             (status-buffers (-rotate -1 status-buffers-raw))
             (names (--map (buffer-name it) status-buffers))
             (alist (-zip-pair names status-buffers))
             (selected (ido-completing-read "Magit: " names)))
        (switch-to-buffer (alist-get selected alist)))
    (call-interactively 'magit-status)))
;; (setq magit-display-file-buffer-function 'magit-display-file-buffer-traditional)
;; (setq magit-display-file-buffer-function 'magit-display-file-buffer-other-window)
(setq magit-display-file-buffer-function 'switch-to-buffer-other-window)
(setq magit-log-margin '(t "%F %T" magit-log-margin-width t 18))
(defun my-magit-refresh-hook ()
  (my-ahs-clear-overlays))
(add-hook 'magit-post-refresh-hook 'my-ahs-clear-overlays)


(defun my-async-when-done (proc &optional _change)
  "Process sentinel used to retrieve the value from the child process."
  (when (and (eq 'exit (process-status proc))
             (buffer-live-p (process-buffer proc))) ;; This is what I added, to avoid selecting deleted buffers.
    (with-current-buffer (process-buffer proc)
      (let ((async-current-process proc))
        (if (= 0 (process-exit-status proc))
            (if async-callback-for-process
                (if async-callback
                    (prog1
                        (funcall async-callback proc)
                      (unless async-debug
                        (kill-buffer (current-buffer))))
                  (set (make-local-variable 'async-callback-value) proc)
                  (set (make-local-variable 'async-callback-value-set) t))
              (goto-char (point-max))
              (backward-sexp)
              (async-handle-result async-callback (read (current-buffer))
                                   (current-buffer)))
          (set (make-local-variable 'async-callback-value)
               (list 'error
                     (format "Async process '%s' failed with exit code %d"
                             (process-name proc) (process-exit-status proc))))
          (set (make-local-variable 'async-callback-value-set) t))))))
(cl-defun magit-todos--async-start-process (name &key command finish-func)
  "Start the executable PROGRAM asynchronously.  See `async-start'.
PROGRAM is passed PROGRAM-ARGS, calling FINISH-FUNC with the
process object when done.  If FINISH-FUNC is nil, the future
object will return the process object when the program is
finished.  Set DEFAULT-DIRECTORY to change PROGRAM's current
working directory.

This is a copy of `async-start-process' that does not override
`process-connection-type'.  It also uses keyword arguments."
  (declare (indent defun))
  ;; TODO: Drop this function when possible.  See
  ;; <https://github.com/jwiegley/emacs-async/issues/102>.
  (let* ((args (cdr command))
         (command (car command))
         (buf (generate-new-buffer (concat "*" name "*")))
         (proc (apply #'start-process name buf command args)))
    (with-current-buffer buf
      (set-process-query-on-exit-flag proc nil)
      (set (make-local-variable 'async-callback) finish-func)
      (set-process-sentinel proc #'my-async-when-done)
      (unless (string= name "emacs")
        (set (make-local-variable 'async-callback-for-process) t))
      proc)))
;;______________________________________________________________________________
;π SHELL SCRIPTS
;;______________________________________________________________________________
(require 'sh-script)
(set-face-attribute 'sh-heredoc nil :weight 'normal)
;; (set-face-foreground 'sh-heredoc "dark salmon")
;; (set-face-foreground 'sh-heredoc "salmon1")
(set-face-foreground 'sh-heredoc "lightsalmon")
;; (set-face-foreground 'sh-heredoc "rosy brown")


;;______________________________________________________________________________
;π ACE-WINDOW
;;______________________________________________________________________________
(require 'ace-window)
(setq aw-scope 'visible)
(setq aw-scope 'global)
(set-face-attribute 'aw-leading-char-face nil :family "DejaVu Sans Mono")
(set-face-attribute 'aw-leading-char-face nil :height 500)
(setq aw-reverse-frame-list t)
(defun my-aw-hide-cursor (orig-func &rest args)
  (let ((cursor-type nil))
    (apply orig-func args)))
(advice-add 'ace-window :around 'my-aw-hide-cursor)

;;______________________________________________________________________________
;π SERVER
;;______________________________________________________________________________
(server-force-delete)
(server-start)
