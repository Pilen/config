
(defcustom vagrant-terminal (list "urxvtc" "-e")
  "Terminal to boot a vagrant shell in")

(defface vagrant-running-face
  '((t :foreground "green"))
  "Face for running vagrant machines"
  :group 'vagrant)
(defface vagrant-off-face
  '((t :foreground "red"))
  "Face for vagrant machines powered off"
  :group 'vagrant)
(defface vagrant-working-face
  '((t :foreground "gray50"))
  "Face for vagrant machines in a working state"
  :group 'vagrant)



(defun vagrant--get-global-status ()
  (with-temp-buffer
    (erase-buffer)
    (call-process "vagrant" nil t nil "global-status")
    (goto-char (point-min))
    (search-forward-regexp "^ *$")
    (let (end (point))
      (goto-char (point-min))
      (forward-line 2)
      (loop while (search-forward-regexp "^\\([^ ]+\\) +\\([^ ]+\\) +\\([^ ]+\\) +\\([^ ]+\\) +\\([^ ]+\\) *$" end t) collect
            `((id . ,(match-string 1))
              (name . ,(match-string 2))
              (provider . ,(match-string 3))
              (state . ,(match-string 4))
              (directory . ,(match-string 5)))))))

(defun vagrant--execute (vagrant command &rest args)
  (with-current-buffer (get-buffer-create "*vagrant-command*")
    (erase-buffer)
    (set-process-sentinel
     (apply 'start-process "*vagrant-command*" (current-buffer) "vagrant" command (alist-get 'id vagrant) args)
     'vagrant--sentinel)))

(defun vagrant--sentinel (process event)
  (vagrant-refresh))

(defun vagrant--up-p ()
  (string= "running"
           (alist-get 'state
                      (get-text-property (point) 'vagrant-properties))))

(defun vagrant--working-state ()
  (let ((inhibit-read-only t))
    (add-face-text-property (line-beginning-position) (1+ (line-end-position)) 'vagrant-working-face)))

(defun vagrant-refresh ()
  (interactive)
  (with-current-buffer (get-buffer-create "*vagrant*")
    (setq buffer-read-only t)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (dolist (row (vagrant--get-global-status))
        (let ((start (point))
              (state (pcase (alist-get 'state row)
                       ("running" '("R" 'vagrant-running-face))
                       ("poweroff" '("-" 'vagrant-off-face))
                       (_ '("?" nil)))))
          (insert
           (car state)
           " "
           (alist-get 'id row)
           "    "
           ;; (if (string= (alist-get 'name row) "default") " " (alist-get 'name row))
           ;; " "
           (alist-get 'directory row)
           "\n")
          (add-face-text-property start (point) (cdr state))
          (put-text-property start (point) 'vagrant-properties row)
          ))))
  (message "vagrant refreshed"))

(defun vagrant-up ()
  (interactive)
  (vagrant--execute
   (get-text-property (point) 'vagrant-properties)
   "up")
  (vagrant--working-state))

(defun vagrant-halt ()
  (interactive)
  (vagrant--execute
   (get-text-property (point) 'vagrant-properties)
   "halt")
  (vagrant--working-state))

(defun vagrant-reload ()
  (interactive)
  (if (vagrant--up-p)
      (progn
        (vagrant--execute
         (get-text-property (point) 'vagrant-properties)
         "reload")
        (vagrant--working-state))
    (message "Not running")))

(defun vagrant-destroy ()
  (interactive)
  (when (yes-or-no-p "Are you sure you want to destroy this?")
    (vagrant--execute
     (get-text-property (point) 'vagrant-properties)
     "destroy")
    (vagrant--working-state)))

(defun vagrant-prune ()
  (interactive)
  (vagrant--execute
   (get-text-property (point) 'vagrant-properties)
   "global-status"
   "--prune"))

(defun vagrant-terminal ()
  (interactive)
  (if (vagrant--up-p)
      (apply 'start-process "*vagrant-ssh*" nil
             (append
              vagrant-terminal
              (list "vagrant"
                    "ssh"
                    (alist-get 'id
                               (get-text-property (point) 'vagrant-properties)))))
    (message "Not running")))

(defun vagrant-open-vagrantfile ()
  (interactive)
  (find-file (concat (alist-get 'directory (get-text-property (point) 'vagrant-properties))
                     "/"
                     "Vagrantfile")))

(defvar vagrant-mode-map
  (let ((vagrant-mode-map (make-sparse-keymap)))
    (define-key vagrant-mode-map (kbd "u") 'vagrant-up)
    (define-key vagrant-mode-map (kbd "h") 'vagrant-halt)
    (define-key vagrant-mode-map (kbd "r") 'vagrant-reload)
    (define-key vagrant-mode-map (kbd "g") 'vagrant-refresh)
    (define-key vagrant-mode-map (kbd "G") 'vagrant-prune)
    (define-key vagrant-mode-map (kbd "t") 'vagrant-terminal)
    (define-key vagrant-mode-map (kbd "o") 'vagrant-open-vagrantfile)
    (define-key vagrant-mode-map (kbd "n") 'next-line)
    (define-key vagrant-mode-map (kbd "p") 'previous-line)
    vagrant-mode-map))

(define-derived-mode vagrant-mode special-mode "vagrant"
  (vagrant-refresh))

(defun vagrant ()
  (interactive)
  (pop-to-buffer (get-buffer-create "*vagrant*"))
  (vagrant-mode)
  )

(provide 'vagrant)
