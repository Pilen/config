;;______________________________________________________________________________
;π FLYSPELL
;;______________________________________________________________________________
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq flyspell-issue-welcome-flag nil)
                                        ;(setq ispell-dictionary "dansk")
(setq ispell-dictionary "english")
;(add-hook 'flyspell-mode-hook 'flyspell-buffer)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
(add-hook 'c-mode-hook 'flyspell-prog-mode)
(add-hook 'sh-mode-hook 'flyspell-prog-mode)
(add-hook 'c++-mode-hook 'flyspell-prog-mode)
(add-hook 'ruby-mode-hook 'flyspell-prog-mode)
(add-hook 'perl-mode-hook 'flyspell-prog-mode)
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)
(add-hook 'python-mode-hook 'flyspell-prog-mode)
(add-hook 'sml-mode 'flyspell-prog-mode)


(add-hook 'LaTeX-mode-hook (lambda () (turn-on-flyspell))); (setq ispell-dictionary "dansk"))) ; Commented out as aspell-da is not working

(defun turn-on-flyspell ()
  "Force flyspell-mode on using a positive arg."
  (interactive)
  (if (and TeX-mode-p
           (string= ".log" (substring (buffer-name (current-buffer)) -4 nil)))
      (message "turn-on-flyspell called on latex .log file, but ignored")
    (flyspell-mode 1)))

;; (setq flyspell-is-on nil)
;; (defun flyspell-toggle ()
;;   (interactive)
;;   (if flyspell-is-on
;;       (progn
;;         (message "Off")
;;         (setq flyspell-is-on nil)
;;         (flyspell-mode-off))
;;     (progn
;;       (message "On")
;;       (setq flyspell-is-on t)
;;       (flyspell-mode-on)
;;       (flyspell-buffer))))

;; (defun flyspell-my-buffer ()
;;   (interactive)
;;   (setq flyspell-is-on t)
;;   (flyspell-buffer))

(add-hook 'flyspell-mode-hook (lambda () (when flyspell-mode (flyspell-buffer))))

;; Better order of spelling suggestions
;(defadvice ispell-command-loop (before ispell-reverse-miss-list activate)
;  "reverse the first argument to ispell-command-loop"
;  (ad-set-arg 0 (reverse (ad-get-arg 0))))


;;______________________________________________________________________________
;π DICTIONARIES
;;______________________________________________________________________________

(defun fd-switch-dictionary-flyspell ()
  (interactive)
  (call-interactively 'fd-switch-dictionary)
  (turn-on-flyspell))

(defun fd-switch-dictionary ()
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
