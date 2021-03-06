;;______________________________________________________________________________
;π SQL
;;______________________________________________________________________________
(defvar sql-last-prompt-pos 1
  "position of last prompt when added recording started")
(make-variable-buffer-local 'sql-last-prompt-pos)
(put 'sql-last-prompt-pos 'permanent-local t)

(defun sql-add-newline-first (output)
  "Add newline to beginning of OUTPUT for `comint-preoutput-filter-functions'
    This fixes up the display of queries sent to the inferior buffer
    programatically."
  (let ((begin-of-prompt
         (or (and comint-last-prompt-overlay
                  ;; sometimes this overlay is not on prompt
                  (save-excursion
                    (goto-char (overlay-start comint-last-prompt-overlay))
                    (looking-at-p comint-prompt-regexp)
                    (point)))
             1)))
    (if (> begin-of-prompt sql-last-prompt-pos)
        (progn
          (setq sql-last-prompt-pos begin-of-prompt)
          (concat "\n" output))
      output)))

(defun sqli-add-hooks ()
  "Add hooks to `sql-interactive-mode-hook'."
  (add-hook 'comint-preoutput-filter-functions
            'sql-add-newline-first))

(add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)

(defun sql-send-line ()
  (interactive)
  (save-excursion
    (let ((start (progn (beginning-of-line) (point)))
          (end (progn (end-of-line) (point))))
      (sql-send-region start end))))

(defun sql-send-string (str)
  "Send the string STR to the SQL process."
  (interactive "sSQL Text: ")

  (when (not (string= ";" (substring str -1)))
    (setq str (concat str ";")))

  (let ((comint-input-sender-no-newline nil)
        (s (replace-regexp-in-string "[[:space:]\n\r]+\\'" "" str)))
    (if (sql-buffer-live-p sql-buffer)
        (progn
          ;; Ignore the hoping around...
          (save-excursion
            ;; Set product context
            (with-current-buffer sql-buffer
              ;; Send the string (trim the trailing whitespace)
              (sql-input-sender (get-buffer-process sql-buffer) s)

              ;; Send a command terminator if we must
              (if sql-send-terminator
                  (sql-send-magic-terminator sql-buffer s sql-send-terminator))

              (message "Sent string to buffer %s." sql-buffer)))

          ;; Display the sql buffer
          (if sql-pop-to-buffer-after-send-region
              (pop-to-buffer sql-buffer)
            (display-buffer sql-buffer)))

      ;; We don't have no stinkin' sql
      (message "No SQL process started."))))

(defun sql-clear ()
  (interactive)
  (eshell/clear)
  (comint-send-input)
  (setq sql-last-prompt-pos 1))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (define-key sql-interactive-mode-map (kbd "C-l") 'sql-clear)))
;; (add-hook 'sql-mode-hook
;;           (lambda () (local-set-minor-mode-key 'sql-mode (kbd "C-l") 'sql-clear)))
