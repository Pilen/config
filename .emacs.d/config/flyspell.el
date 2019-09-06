;;______________________________________________________________________________
;π FLYSPELL
;;______________________________________________________________________________
;; Aspell is better than hunspell
;; Ubuntu: aspell-da

(require 'flyspell)
;(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq flyspell-issue-welcome-flag nil)
                                        ;(setq ispell-dictionary "dansk")
(setq ispell-dictionary "english")
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; (add-hook 'c-mode-common-hook 'flyspell-prog-mode)
;; (add-hook 'c-mode-hook 'flyspell-prog-mode)
;; (add-hook 'sh-mode-hook 'flyspell-prog-mode)
;; (add-hook 'c++-mode-hook 'flyspell-prog-mode)
;; (add-hook 'ruby-mode-hook 'flyspell-prog-mode)
;; (add-hook 'perl-mode-hook 'flyspell-prog-mode)
;; (add-hook 'haskell-mode-hook 'flyspell-prog-mode)
;; (add-hook 'python-mode-hook 'flyspell-prog-mode)
;; (add-hook 'sml-mode-hook 'flyspell-prog-mode)


;; (add-hook 'LaTeX-mode-hook 'turn-on-flyspell); (setq ispell-dictionary "dansk"))) ; Commented out as aspell-da is not working

;; Do this to avoid fireing both flyspell-correct-word and mouse-yank-primary
(add-hook 'flyspell-mode-hook (lambda ()
                                (define-key flyspell-mouse-map [down-mouse-2] 'ignore)
                                (define-key flyspell-mouse-map [mouse-2] #'flyspell-correct-word)))

(defun turn-on-flyspell ()
  "Force flyspell-mode on using a positive arg."
  (interactive)
  (if (and (boundp 'TeX-mode-p)
           TeX-mode-p
           (string= ".log" (substring (buffer-name (current-buffer)) -4 nil)))
      (message "turn-on-flyspell called on latex .log file, but ignored")
    (flyspell-mode 1)))

;; TODO: fix
;; There seems to be a bug in flyspell causing the following error:
;; Blocking call to accept-process-output with quit inhibited!!
;;
;; This is probably what has caused the trouble, when that is out of the way we
;; can probably go forward with either an idle-timer pr. buffer, or with an
;; idle-timer looping until no more buffers are listed.
;;

;; (defvar flyspell-turn-on-delay 3 "The amount of time to idle before turning on flyspell in the buffer")
;; (defvar flyspell-init-timer nil)
;; (defvar flyspell-buffers-awaiting nil)

;; (defun turn-on-flyspell ()
;;   "Turn flyspell on.
;; Flyspell wont be turned on until Emacs has been idle for some time.
;; This way opening serveral buffers wont stall everything. "
;;   (interactive)
;;   (message "init flyspell")
;;   (if (and (boundp 'TeX-mode-p)
;;            TeX-mode-p
;;            (string= ".log" (substring (buffer-name (current-buffer)) -4 nil)))
;;       (message "turn-on-flyspell called on latex .log file, but ignored")
;;     (setq flyspell-init-timer
;;           (run-with-idle-timer flyspell-turn-on-delay nil
;;                                (lambda (buffer)
;;                                  (message "Spellchecking")
;;                                  (when (buffer-live-p buffer)
;;                                    (with-current-buffer buffer
;;                                      (with-local-quit
;;                                        (flyspell-mode 1)))))
;;                                (current-buffer)))))

;; (progn
;;   (cancel-timer flyspell-init-timer)
;;   (setq flyspell-init-timer nil)
;;   (setq flyspell-buffers-awaiting nil))

;; (defun turn-on-flyspell ()
;;   "Turn flyspell on.
;; Flyspell wont be turned on until Emacs has been idle for some time.
;; This way opening serveral buffers wont stall everything. "
;;   (interactive)
;;   (message "init flyspell")
;;   (if (and (boundp 'TeX-mode-p)
;;            TeX-mode-p
;;            (string= ".log" (substring (buffer-name (current-buffer)) -4 nil)))
;;       (message "turn-on-flyspell called on latex .log file, but ignored")
;;     (add-to-list 'flyspell-buffers-awaiting (current-buffer))
;;     (message "Adding buffer '%s' to flyspell list" (buffer-name))
;;     (flyspell-start-timer)))

;; (defun flyspell-start-timer ()
;;   "Start a timer that will actually run flyspell"
;;   (message "start-timer started")
;;   (unless (timerp flyspell-init-timer)
;;     (message "no timer active")
;;     (setq flyspell-init-timer
;;           (run-with-idle-timer 3 3
;;                           (lambda ()
;;                             (message "running timer")
;;                             ;; (run-with-idle-timer
;;                             ;; flyspell-turn-on-delay nil
;;                             ;; (lambda ()
;;                             (if (null flyspell-buffers-awaiting)
;;                                 (progn
;;                                   (message "cancelling timer")
;;                                   (cancel-timer flyspell-init-timer)
;;                                   (setq flyspell-init-timer nil))
;;                               (message "timer doing stuff")
;;                               (let ((buffer (pop flyspell-buffers-awaiting)))
;;                                 (when (buffer-live-p buffer)
;;                                   (with-current-buffer buffer
;;                                     (message "spellchecking buffer '%s'" (buffer-name))
;;                                     (with-local-quit
;;                                       (flyspell-mode 1))
;;                                     (internal-timer-start-idle))))
;;                               ;; (flyspell-run-timer)))))))))
;;                               ))))))

;; (defun flyspell-prog-mode ()
;;   "Turn on `flyspell-mode' for comments and strings."
;;   (interactive)
;;   (setq flyspell-generic-check-word-predicate
;;         'flyspell-generic-progmode-verify)
;;   (turn-on-flyspell)
;;   (run-hooks 'flyspell-prog-mode-hook))


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



(require 'flyspell-correct-ivy)
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


;; Dansk is fucked up, ispell-get-word generates the following regex:
;; "[A-Z\306\330\305a-z\346\370\345]+\\([']?[A-Z\306\330\305a-z\346\370\345]+\\)?"
;; But it should probably be something like this:
;; "[A-ZÆØÅa-zæøå]+\\([']?[A-ZÆØÅa-zæøå]+\\)?"
;; From
;; ("dansk"				; Dansk.aff
;;      "[A-Z\306\330\305a-z\346\370\345]" "[^A-Z\306\330\305a-z\346\370\345]"
;;      "[']" nil ("-C") nil iso-8859-1)
;; To
;; '("[A-Z\306\330\305a-z\346\370\345]" "[^A-Z\306\330\305a-z\346\370\345]"
;;   "[']" nil ("-C") nil iso-8859-1)

;; (let ((dansk (alist-get "dansk" ispell-dictionary-base-alist nil nil 'equal)))
;;   (setf (alist-get "dansk" ispell-dictionary-base-alist nil nil 'equal)
;;         '("[A-ZÆØÅa-zæøå]" "[^A-ZÆØÅa-zæøå]"
;;           "[']" nil ("-C") nil iso-8859-1)))
