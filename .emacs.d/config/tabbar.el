;;______________________________________________________________________________
;π TABBAR
;;______________________________________________________________________________

;; I dont use tabbar anymore, but it might be usefull some day (or to someone).

;; (require 'tabbar)
;; (set-face-attribute
;;  'tabbar-default nil
;;  :background "gray30")
;; (set-face-attribute
;;  'tabbar-unselected nil
;;  :background "gray60"
;;  :foreground "gray30"
;;  :box nil)
;; (set-face-attribute
;;  'tabbar-selected nil
;;  :background "#f2f2f6"
;;  :foreground "black"
;;  :box nil)
;; (set-face-attribute
;;  'tabbar-button nil
;;  :box '(:line-width 1 :color "gray72" :style released-button))
;; (set-face-attribute
;;  'tabbar-separator nil
;;  :height 0.7)

;; ;(tabbar-mode 1)


;; ;; add a buffer modification state indicator in the tab label,
;; ;; and place a space around the label to make it looks less crowd
;; (defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
;;   (setq ad-return-value
;;         (if (and (buffer-modified-p (tabbar-tab-value tab))
;;                  (buffer-file-name (tabbar-tab-value tab)))
;;             (concat " + " (concat ad-return-value " "))
;;           (concat " " (concat ad-return-value " ")))))
;; ;; called each time the modification state of the buffer changed
;; (defun ztl-modification-state-change ()
;;   (tabbar-set-template tabbar-current-tabset nil)
;;   (tabbar-display-update))
;; ;; first-change-hook is called BEFORE the change is made
;; (defun ztl-on-buffer-modification ()
;;   (set-buffer-modified-p t)
;;   (ztl-modification-state-change))
;; (add-hook 'after-save-hook 'ztl-modification-state-change)
;; ;; this doesn't work for revert, I don't know
;; ;;(add-hook 'after-revert-hook 'ztl-modification-state-change)
;; (add-hook 'first-change-hook 'ztl-on-buffer-modification)


;; ;; (defun autohide-tabbar ()
;; ;;   "Make tabbar briefly show itself while
;; ;; you are switching buffers with shortcuts.
;; ;; Tested with GNU Emacs 23
;; ;; - Sabof"
;; ;;   (defvar *tabbar-autohide-delay* 3)

;; ;;   (interactive)
;; ;;   (tabbar-mode nil)
;; ;;   (defvar *tabbar-autohide-timer* nil)
;; ;;   (defun renew-tabbar-autohide-timer ()
;; ;;     (if (timerp *tabbar-autohide-timer*)
;; ;;         (cancel-timer *tabbar-autohide-timer*))
;; ;;     (setf *tabbar-autohide-timer*
;; ;;           (run-with-timer
;; ;;            3 nil (lambda ()
;; ;;                    (tabbar-mode nil)
;; ;;                    (setf *tabbar-autohide-timer*
;; ;;                          nil)))))

;; ;;   (global-set-key
;; ;;    (kbd "H-.")
;; ;;    (lambda ()
;; ;;      (interactive)
;; ;;      (if tabbar-mode
;; ;;          (tabbar-forward)
;; ;;        (tabbar-mode t))
;; ;;      (renew-tabbar-autohide-timer)))
;; ;;   (global-set-key
;; ;;    (kbd "H-,")
;; ;;    (lambda ()
;; ;;      (interactive)
;; ;;      (if tabbar-mode
;; ;;          (tabbar-backward)
;; ;;        (tabbar-mode t))
;; ;;      (renew-tabbar-autohide-timer))))

;; ;; (autohide-tabbar)


;; (defvar tabbar-autohide-timer nil)
;; (defun renew-tabbar-autohide-timer ()
;;   (if (timerp tabbar-autohide-timer)
;;       (cancel-timer tabbar-autohide-timer))
;;   (setf tabbar-autohide-timer
;;         (run-with-timer
;;          3 nil (lambda ()
;;                  (tabbar-mode -1)
;;                  (setf tabbar-autohide-timer nil)))))

;; (defun tabbar-forward-renew ()
;;   (interactive)
;;   (if tabbar-mode
;;       (tabbar-forward)
;;     (tabbar-mode t))
;;   (renew-tabbar-autohide-timer))

;; (defun tabbar-backward-renew ()
;;   (interactive)
;;   (if tabbar-mode
;;       (tabbar-backward)
;;     (tabbar-mode t))
;;   (renew-tabbar-autohide-timer))
