
;; Alert Caro not to disturb me when clocking in, and that it is okay agin when clocking out
;; org-clock-in-hook
;; org-clock-out-hook
;; org-clock-cancel-hook
(require 'org)
(require 'org-mouse)
(require 'org-table)
(require 'org-clock)
(defun my-org-clock-in ()
  )

(setq org-startup-folded nil)

;; By default org-beamer will export *text* as \alert{text} not \textbf{text}, revert this
(defun my-beamer-bold (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

(require 'ox)
(add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)


(defun my-org-shift-return ()
  (interactive)
  (if (org-at-table-p)
  ;; (if (org-table-check-inside-data-field t)
      ;; (call-interactively 'org-table-copy-down)
      ;; (call-interactively 'org-table-insert-row)
      (org-table-insert-row 'below)
    (call-interactively 'new-indented-line))
  ;; (call-interactively 'new-indented-line)
  )

(define-key org-mode-map (kbd "S-<return>") 'my-org-shift-return)

(setq org-html-postamble nil)

(setq org-export-allow-bind-keywords t)

(defun my-org-sentence-end (text backend info)
  (replace-regexp-in-string "\\.\\(\n\\|$\\)" ".<span class='sentence-end'></span>\\1" text)
  )

(setq org-cycle-separator-lines 3)

(setq org-edit-src-content-indentation 0)

(message "remember to (require 'org-tempo)")
(require 'org-tempo)


(add-to-list 'org-babel-load-languages '(python . t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

(setq org-confirm-babel-evaluate nil)

(setq org-src-preserve-indentation t)

(setq org-src-tab-acts-natively t)

(defun my-org-return ()
  (interactive)
  (cond
   ((org-in-src-block-p t)
    (org-return-indent))
   ((looking-at "[ \t\n]")
    (org-return-indent))
   ((org-in-regexp org-link-any-re)
    (org-open-at-point))
   (t
    (org-return))))
(define-key org-mode-map (kbd "<return>") 'my-org-return)

;; https://emacs.stackexchange.com/questions/7629/the-syntax-highlight-and-indentation-of-source-code-block-in-exported-html-file
;(setq org-html-htmlize-output-type 'css)

(setq org-babel-min-lines-for-block-output 10000)

;; (setq org-babel-python-command "python ")


(setq org-agenda-files '("/home/spi/status/status.org"))
(setq org-agenda-clockreport-parameter-plist '(:link nil :maxlevel 99 :compact t :step day :stepskip0 t))

(setq org-duration-format `((special . h:mm)))

;; (defun my-org-extract-text ())

;; look at org-clock.el.gz
;; org-clock-update-mode-line
;; org-clock-get-clock-string
;; (org-clock-get-clocked-time)
;; (org-clocking-p)


(defface my-org-not-clocked-in-face
  '((t
     :foreground "OrangeRed1"
     ;; :background "DeepSkyBlue4"
     :weight bold
     ;; :underline t
     )) "")
(set-face-background 'my-org-not-clocked-in-face nil)
(set-face-foreground 'my-org-not-clocked-in-face "OrangeRed1")
(set-face-foreground 'my-org-not-clocked-in-face "coral3")
(set-face-bold 'my-org-not-clocked-in-face t)




(defun my-org-insert-file-link ()
  (interactive)
  (let ((path (read-file-name "file:"))
        (description (read-string "Description:")))
    (org-insert-link nil (concat "file:" path) description)))

(setq org-link-frame-setup
      '((vm . vm-visit-folder-other-frame)
        (vm-imap . vm-visit-imap-folder-other-frame)
        (gnus . org-gnus-no-new-news)
        (file . find-file-other-window)
        (wl . wl-other-frame)))


(defun my-org-clock-in-hook ()
  (force-mode-line-update t)
  )
(add-hook 'org-clock-in-hook 'my-org-clock-in-hook)
(defun my-org-clock-out-hook ()
  (setq org-mode-line-string (propertize
                              " [Not clocked in]"
                              'face 'my-org-not-clocked-in-face
                              'local-map org-clock-mode-line-map))
  (force-mode-line-update t)
  )
(add-hook 'org-clock-out-hook 'my-org-clock-out-hook)

(my-org-clock-out-hook)


(setq org-clock-history-length 30)

;; (org-clock-in '(4))
;; (org-clock-select-task)
(defun my-org-clock-in-menu ()
  (interactive)
  (let (candidates
        selected-task
        selected

        cat task heading prefix
        )
    (dolist (marker org-clock-history)
      (when (and (not (equal marker (cadr candidates)))
                 (marker-buffer marker))
        (with-current-buffer (org-base-buffer (marker-buffer marker))
          (org-with-wide-buffer
           (ignore-errors
             (goto-char marker)
             (setq cat (org-get-category)
                   heading (org-get-heading 'notags)
                   prefix (save-excursion
                            (org-back-to-heading t)
                            (looking-at org-outline-regexp)
                            (match-string 0))
                   ;; task (substring ;-no-properties
                   ;;       (org-fontify-like-in-org-mode
                   ;;        (concat prefix heading)
                   ;;        org-odd-levels-only)
                   ;;       (length prefix))
                   task (progn (set-text-properties 0 (length heading) nil heading) heading)
                   )
             (when (and cat task)
               (push (cons task marker) candidates)))))))
    (push (cons "[New task]" 'new-task) candidates)
    (setq candidates (reverse candidates))
    (when (org-clocking-p)
      (push (cons "[Clock out]" 'clock-out) candidates)
      )
    (setq selected-task (ivy-read "Task:" candidates))
    (setq selected (cdr (assoc selected-task candidates)))
    (case selected
      ((clock-out) (org-clock-out))
      ((new-task)
       (let ((task (read-from-minibuffer "Task: ")))
         (with-current-buffer (org-base-buffer (marker-buffer (car org-clock-history))) ;; This can fail if marker is in no buffer, eg if buffer is closed (even if reopened)
           (with-selected-window (get-buffer-window (current-buffer) t)
             (goto-char (point-max))
             ;; (search-backward-regexp "^\\*\\* Tasks")
             ;; (goto-char (match-end 0))
             ;; (search-forward-regexp "^\\*\\* ")
             ;; (goto-char (match-beginning 0))
             (insert "\n")
             (insert "*** " task "\n\n")
             (backward-char 1)
             (beginning-of-line)
             (org-clock-in))
           ))
       )
      (otherwise
       (with-current-buffer (org-base-buffer (marker-buffer selected))
         (goto-char selected)
        (org-clock-in))))))


;; (with-current-buffer (org-base-buffer (marker-buffer (car org-clock-history)))
;;          (goto-char (point-max))
;;          (search-backward-regexp "^\\*\\* Tasks")
;;          (goto-char (match-end 0))
;;          (search-forward-regexp "^\\*\\* ")
;;          (goto-char (match-beginning 0))
;;          (insert "λ")
;;          )
















(defvar my-org-day nil)

(defun my-org-status-new-daily-entry ()
  (interactive)
  (goto-char (point-max))
  (when (not (search-backward-regexp "^\\*\\* Days" nil t))
  ;; (when (string= (format-time-string "%A") "Monday")
  ;; (when (string= (format-time-string "%A") "Tuesday")
  ;; (when (string= (format-time-string "%A") "Thursday")
    (setq org-clock-history nil) ;; Reset history
    (insert (format-time-string "\n* Week %V\n"))
    (insert "** Days\n")
    (insert "** Tasks\n")
    (insert "#+BEGIN: clocktable :scope subtree :maxlevel 50 :compact t :properties (\"Issue\" \"Registered\" \"TODO\") :formula \"@2$2=vsum(@3$2..@>$2);U\"\n")
    (insert "#+END:\n\n")
    (insert "#+BEGIN: clocktable :scope subtree :block week :step day :stepskip0 t :maxlevel 50 :compact t\n")
    (insert "#+END:\n\n")
    (insert "*** Monday Morning Meeting\n")
    (search-backward-regexp "^\\*\\* Days")
    )
  ;; (search-backward-regexp "^\\*\\* Days")
  (org-forward-heading-same-level 1)
  (insert (format-time-string "*** %A %Y-%m-%d\n"))
  (insert "#+BEGIN_QUOTE\n")
  (let ((p (point)))
    (insert "\n#+END_QUOTE\n\n")
    (goto-char p))
;; (forward-char -1)
  ;; (forward-line -1)
  (org-clock-in)
  (setq my-org-day (copy-marker (car org-clock-history)))
  (org-clock-out)
  ;; (goto-char (point-max))
  )

(defun my-org-archive-week ()
  (interactive)
  (goto-char (point-min))
  (search-forward-regexp "^\\* Week \\([0-9]+\\)")
  (org-archive-subtree)
  )

(defun my-org-suspend ()
  (with-current-buffer (marker-buffer my-org-day)
    (goto-char (marker-position my-org-day))
    (org-clock-in)
    (org-clock-out)
    )
  )


(defun my-org-status-daily-standup ()
  (interactive)
  (goto-char (point-max))
  (let (today
        last ;; last working day
        start ;; point
        end ;; point
        did
        plan
        bullet-last?
        bullet-today?
        )
    (search-backward-regexp "^\\*\\* ")
    (setq today (point))
    (search-backward-regexp "^\\*\\* ")
    (setq last (point))

    (goto-char last)
    (unless (looking-at "** Tasks")
      (search-forward "#+BEGIN_QUOTE\n")
      (search-forward "#+END_QUOTE")
      (while (eq (char-after) ?\n) (forward-char))
      (setq start (point))
      (when (eq (char-after) ?-) (setq bullet-last? t))
      (search-forward-regexp "^\\*")
      (goto-char (match-beginning 0))
      (while (eq (char-before) ?\n) (backward-char))
      (setq end (point))
      (setq did (buffer-substring-no-properties start end)))

    (goto-char today)
    (search-forward "#+BEGIN_QUOTE\n")
    (while (eq (char-after) ?\n) (forward-char))
    (setq start (point))
    (when (eq (char-after) ?-) (setq bullet-today? t))
    (search-forward "#+END_QUOTE")
    (goto-char (match-beginning 0))
    (while (eq (char-before) ?\n) (backward-char))
    (setq end (point))
    (setq plan (buffer-substring-no-properties start end))

    (with-current-buffer (get-buffer-create "*Daily Standup status*")
      (erase-buffer)
      (when did
        (if bullet-last?
            (insert "Yesterday:\n")
          (insert "Yesterday, "))
        (insert (replace-regexp-in-string "$DAY" (lambda (x) (pcase x ("$day" "yesterday") ("$DAY" "Yesterday") (_ "Yesterday"))) did t))
        (insert "\n\n"))
      (if bullet-today?
          (insert "Today:\n")
        (insert "Today, "))
      (insert plan)
      (replace-regexp "^# .*\n" "" nil (point-min) (point-max))
      (kill-ring-save (point-min) (point-max))
      (goto-char (point-max))
      )
    (goto-char (point-max))
    ))


;; (defun my-org-status-weekly-status-email ()
;;   (interactive)
;;   (goto-char (point-max))
;;   (let (day ;; string
;;         week ;; string
;;         start ;; point
;;         end ;; point
;;         did)
;;     (search-backward-regexp "^\\* Week \\([0-9]+\\)")
;;     (setq week (match-string 1))
;;     (with-current-buffer (get-buffer-create "*Daily Standup status*") (erase-buffer))
;;     (search-forward-regexp "^\\*\\* Tasks")
;;     (while (search-forward-regexp "^\\*\\* \\([a-zA-Z]+\\)" nil t)
;;       (setq day (match-string 1))
;;       (search-forward "#+BEGIN_QUOTE\n")
;;       (search-forward "#+END_QUOTE")
;;       (while (eq (char-after) ?\n) (forward-char))
;;       (setq start (point))
;;       (if (search-forward-regexp "^\\*" nil t)
;;         (goto-char (match-beginning 0))
;;         (goto-char (point-max)))
;;       (while (eq (char-before) ?\n) (backward-char))
;;       (setq end (point))
;;       (setq did (buffer-substring-no-properties start end))

;;       (with-current-buffer (get-buffer-create "*Daily Standup status*")
;;         (insert day)
;;         (insert ":\n")
;;         (setq start (point))
;;         (insert (replace-regexp-in-string "$DAY" (lambda (x) (pcase x ("$day" (downcase day)) ("$DAY" (capitalize day)) (_ (capitalize day)))) did t))
;;         (setq end (point))
;;         (goto-char start)
;;         (capitalize-word 1)
;;         (goto-char end)
;;         (insert "\n\n")))
;;     (with-current-buffer (get-buffer-create "*Daily Standup status*")
;;       (let* ((items (list
;;                      "an acceptable"
;;                      "an excellent"
;;                      "an exceptional"
;;                      "a fine"
;;                      "a good"
;;                      "a great"
;;                      "a happy"
;;                      "a nice"
;;                      "a satisfactory"
;;                      "a superb"
;;                      "a wonderful"
;;                      "a cool"
;;                      ))
;;              (item (nth (random (length items)) items)))
;;         (insert "Have " item " weekend!\nBR, Søren\n"))
;;       (insert "Status Email - Week " week)
;;       (replace-regexp "^# .*\n" "" nil (point-min) (point-max))
;;       (kill-ring-save (point-min) (point-max))
;;       )))
;; (defun my-org-status-weekly-status-email ()
;;   (interactive)
;;   (goto-char (point-max))
;;   (let (week ;; string
;;         did)
;;     (search-backward-regexp "^\\* Week \\([0-9]+\\)")
;;     (setq week (match-string 1))
;;     (with-current-buffer (get-buffer-create "*Daily Standup status*") (erase-buffer))
;;     (search-forward-regexp "^\\*\\* Tasks")
;;     ;; (search-forward-regexp "^\\*\\*\\* ")
;;     (beginning-of-line)
;;     ;; (while (looking-at "^\\*\\*\\* ")
;;     (while (search-forward-regexp "^\\*\\*\\* " nil t)
;;       (setq did (my-org--extract-title-and-text))
;;       ;; (search-forward-regexp "^\\*\\*\\* ")
;;       ;; (beginning-of-line)
;;       (with-current-buffer (get-buffer-create "*Daily Standup status*")
;;         (insert "* ")
;;         (insert (car did))
;;         (unless (string= "" (string-trim (cdr did)))
;;           (insert ":\n")
;;           (insert (cdr did)))
;;         (while (eq (char-before) ?\n) (delete-char -1))
;;         (insert "\n\n")
;;         ))
;;     (with-current-buffer (get-buffer-create "*Daily Standup status*")
;;       (let* ((items (list
;;                      "an acceptable"
;;                      "an excellent"
;;                      "an exceptional"
;;                      "a fine"
;;                      "a good"
;;                      "a great"
;;                      "a happy"
;;                      "a nice"
;;                      "a satisfactory"
;;                      "a superb"
;;                      "a wonderful"
;;                      "a cool"
;;                      ))
;;              (item (nth (random (length items)) items)))
;;         (insert "Have " item " weekend!\nBR, Søren\n"))
;;       (insert "Status Email - Week " week)
;;       (replace-regexp "^# .*\n" "" nil (point-min) (point-max))
;;       (kill-ring-save (point-min) (point-max))
;;       )))
(defun my-org-status-weekly-status-email ()
  (interactive)
  (goto-char (point-max))
  (let (week ;; string
        did
        level
        title
        body
        p)
    (search-backward-regexp "^\\* Week \\([0-9]+\\)")
    (setq week (match-string 1))
    (with-current-buffer (get-buffer-create "*Daily Standup status*") (erase-buffer))
    (search-forward-regexp "^\\*\\* \\(.*\\) *Tasks")
    ;; (search-forward-regexp "^\\*\\*\\* ")
    (beginning-of-line)
    ;; (while (looking-at "^\\*\\*\\* ")
    (while (search-forward-regexp "^\\*\\*\\(\\*+\\) " nil t)
      (unless (org-entry-is-todo-p)
        (setq level (- (length (match-string 1)) 2))
        (setq did (my-org--extract-title-and-text))
        (setq title (car did))
        (setq body (string-trim (replace-regexp-in-string "^#.*$" "" (cdr did))))
        (setq title (replace-regexp-in-string "^\\[[^]]+\\]* *" "" title))
        (setq title (replace-regexp-in-string " *<[^>]*>" "" title))
        (message "<%s>" body)
        ;; (search-forward-regexp "^\\*\\*\\* ")
        ;; (beginning-of-line)
        (with-current-buffer (get-buffer-create "*Daily Standup status*")
          (dotimes (n level)
            (insert "*"))
          (insert " ")
          (insert title)
          (unless (string= "" body)
            (insert ":\n")
            (setq p (point))
            (insert body)
            (indent-region p (point) 2)
            (while (eq (char-before) ?\n) (delete-char -1))
            (insert "\n"))
          ;; (while (eq (char-before) ?\n) (delete-char -1))
          ;; (insert "\n\n")
          (insert "\n")
          )))
    (with-current-buffer (get-buffer-create "*Daily Standup status*")
      (insert "\n")
      (let* ((items (list
                     "an acceptable"
                     "an excellent"
                     "an exceptional"
                     "a fine"
                     "a good"
                     "a great"
                     "a happy"
                     "a nice"
                     "a satisfactory"
                     "a superb"
                     "a wonderful"
                     ;; "a cool"
                     ))
             (item (nth (random (length items)) items)))
        (insert "Have " item " weekend!\nBR, Søren\n"))
      (insert "Status Email - Week " week)
      ;; (replace-regexp "^# .*\n" "" nil (point-min) (point-max))
      (kill-ring-save (point-min) (point-max))
      )))

(require 'request)
(setq my-org-status-synchronize-time-with-gitlab-should-post-comment nil)
(defun my-org-status-synchronize-time-with-gitlab ()
  (interactive)
  (unless (y-or-n-p "Are you sure you want to synchronize time registered with Gitlab?")
    (user-error "Aborted synchronization"))
  (goto-char (point-max))
  ;; (org-show-all) ;; Unfortunately needed so we can iterate through all (no, dont do this)
  (search-backward-regexp "^* ")
  (org-next-visible-heading 1)
  (org-next-visible-heading 1)
  (while (not (eobp))
    (if (catch 'break
          (let ((clocked (org-clock-sum-current-item))
                (issue-url (org-entry-get (point) "issue"))
                (registered (org-entry-get (point) "registered"))
                (registered-minutes 0)
                delta
                project-encoded
                issue-id
                api
                new-registered
                spend
                response
                org-last-set-property
                org-last-set-property-value
                )
            (message "issue-url: %s" issue-url)
            (unless issue-url (throw 'break t))
            (when registered
              (unless (string-match "^\\(\\([0-9]+\\):\\)?\\([0-9]+\\)$" registered)
                (user-error "Invalid value for registered time: %s" registered))
              (setq registered-minutes (+ (* (string-to-number (or (match-string 2 registered) "0"))
                                             60)
                                          (string-to-number (match-string 3 registered)))))
            (setq delta (- clocked registered-minutes))
            (when (< delta 0) (user-error "I am not sure this handles negative amount yet"))
            (when (zerop delta) (throw 'break 'nil))
            (setq new-registered (format "%d:%02d" (/ clocked 60) (mod clocked 60)))
            (setq issue-url (or (cdr (assoc issue-url my-org-named-issues)) issue-url)) ;; Lookup in named issues and use that if there
            (unless (string-match "^https://[^/]+/\\(.+\\)/-/issues/\\([0-9]+\\)$" issue-url)
              (user-error "Unknown url format: %s" issue-url))
            (setq project-encoded (url-hexify-string (match-string 1 issue-url)))
            (setq issue-id (match-string 2 issue-url))
            (when (and (zerop registered-minutes) my-org-status-synchronize-time-with-gitlab-should-post-comment)
              (setq api (format "https://gitlab.isynet.net/api/v4/projects/%s/issues/%s/notes" project-encoded issue-id))
              (setq response
                    (request
                      api
                      :data `(("body" . ,(concat ":clock5:\n" (my-org-status--convert-entry-to-md))))
                      :headers `(("PRIVATE-TOKEN" . ,private-gitlab-token))
                      :type "POST"
                      :parser 'json-read
                      :sync t
                      ))
              (unless (eq 'success (request-response-symbol-status response))
                (user-error "An error occured while talking to Gitlab. Could not post comment"))
              )
            (setq api (format "https://gitlab.isynet.net/api/v4/projects/%s/issues/%s/add_spent_time" project-encoded issue-id))
            (setq spend (format "%dm" delta))
            (message "/spend %s on %s" spend api)
            (setq response
                  (request
                    api
                    :data `(("duration" . ,spend))
                    :headers `(("PRIVATE-TOKEN" . ,private-gitlab-token))
                    :type "POST"
                    :parser 'json-read
                    :sync t
                    ;; :success (cl-function (lambda (&key data &allow-other-keys) (message "my success")))
                    ;; :error (cl-function (lambda (&key data &allow-other-keys) (message "my error")))
                    ))
            (if (eq 'success (request-response-symbol-status response))
                (org-set-property "registered" new-registered)
              (org-set-property "registered" (format "%s?" registered)) ;; This will break the next instance from running before clearing
              (user-error "An error occured while talking to Gitlab. Please check registered time manually!"))
            nil
            )
          )
        (org-next-visible-heading 1)
      (let ((previous (point)))
        ;; (org-forward-heading-same-level 1)
        (org-next-visible-heading 1) ;; (fix dont do this, will break nested timetracking)
        (when (= previous (point))
          (goto-char (point-max))))
  ))
  (message "Done")
  )

(setq org-agenda-start-with-follow-mode t)
(setq org-agenda-start-with-log-mode t)
(setq org-agenda-start-with-clockreport-mode t)
(add-hook 'org-agenda-mode-hook 'my-ahs-clear-overlays)
;; (fmakunbound 'my-org-status-show-timetable)
;; (defun my-org-status-show-timetable ()
;;   (interactive)
;;   (org-agenda-list)
;;   (display-buffer "*Org Agenda*")
;;   (with-selected-window (get-buffer-window "*Org Agenda*")
;;     (my-ahs-clear-overlays)
;;     ;; (unless org-agenda-follow-mode
;;     ;;   (org-agenda-follow-mode))
;;     ;; (unless org-agenda-show-log
;;     ;;   (org-agenda-log-mode))
;;     ))



(defun my-org--extract-title-and-text ()
  (org-back-to-heading t)
  (let* ((elt (org-element-at-point))
         (title (org-element-property :title elt))
         (beg (progn (org-end-of-meta-data t) (point))) ;; skips to actual text
         (end (progn (unless (eq (char-after) ?*) (org-next-visible-heading 1))
                     (while (eq (char-before) ?\n) (backward-char))
                     (point)))
         (text (buffer-substring-no-properties beg end)))
    (cons title text))
  )

(require 'ox-md)
(defun my-org-status--convert-entry-to-md ()
  (save-excursion
    (let ((entry (my-org--extract-title-and-text))
          (org-export-with-toc nil)
          md-buffer)
      (with-temp-buffer
        (setq md-buffer (current-buffer))
        (with-temp-buffer
          (insert (cdr entry))
          (org-export-to-buffer 'md md-buffer nil nil nil t))
        (goto-char (point-max))
        (while (eq (char-before) ?\n) (delete-char -1))
        (if (= (point-max) 1)
            (insert (car entry))
          (goto-char (point-min))
          (insert "#### " (car entry) "\n"))
        (buffer-substring-no-properties (point-min) (point-max)))))

  )


(defun my-org-total-work-duration ()
  (let* ((re (concat "^\\(\\*+\\)[ \t]\\|^[ \t]*" org-clock-string "[ \t]*\\(?:\\(\\[.*?\\]\\)-+\\(\\[.*?\\]\\)\\|=>[ \t]+\\([0-9]+\\):\\([0-9]+\\)\\)"))
         time
           )
      (save-excursion
        (re-search-forward re)
        (unless (match-end 2) (error "wrong match"))
        (setq time (apply #'encode-time (org-parse-time-string (match-string 2))))
        (list (float-time time)
              time)
        ;; (apply #'encode-time ))
      )
    ))
