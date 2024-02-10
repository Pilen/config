;;______________________________________________________________________________
;π SQL
;;______________________________________________________________________________
;; (defvar sql-last-prompt-pos 1
;;   "position of last prompt when added recording started")
;; (make-variable-buffer-local 'sql-last-prompt-pos)
;; (put 'sql-last-prompt-pos 'permanent-local t)

;; (defun sql-add-newline-first (output)
;;   "Add newline to beginning of OUTPUT for `comint-preoutput-filter-functions'
;;     This fixes up the display of queries sent to the inferior buffer
;;     programatically."
;;   (let ((begin-of-prompt
;;          (or (and comint-last-prompt-overlay
;;                   ;; sometimes this overlay is not on prompt
;;                   (save-excursion
;;                     (goto-char (overlay-start comint-last-prompt-overlay))
;;                     (looking-at-p comint-prompt-regexp)
;;                     (point)))
;;              1)))
;;     (if (> begin-of-prompt sql-last-prompt-pos)
;;         (progn
;;           (setq sql-last-prompt-pos begin-of-prompt)
;;           (concat "\n" output))
;;       output)))

;; (defun sqli-add-hooks ()
;;   "Add hooks to `sql-interactive-mode-hook'."
;;   (add-hook 'comint-preoutput-filter-functions
;;             'sql-add-newline-first))

;; (add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)

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

(defun pilen-sql-clear ()
  (interactive)
  ;; Based on (eshell/clear)
  (goto-char (point-max))
  (beginning-of-line)
  (let ((inhibit-read-only t)
        (current (buffer-substring (point) (point-max))))
    (delete-region (point) (point-max))
    (erase-buffer)
    (comint-send-input)
    (insert current))
  (setq sql-last-prompt-pos 1))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (define-key sql-interactive-mode-map (kbd "C-l") 'pilen-sql-clear)))
;; (add-hook 'sql-mode-hook
;;           (lambda () (local-set-minor-mode-key 'sql-mode (kbd "C-l") 'sql-clear)))



;; ;;; """
;;                 DELETE FROM abc 1 def,
;;                       WHERE jkl
;;                       WHERE def = ?
;;   WHERE XXXXXXXXXXXXXXXXXXX foo
;;                       WHERE foo
;; ;;; ""
(defun my-sql-align ()
  (interactive)
  (save-excursion
    (let ((start 0)
          (end 0)
          (end-line 0)
          (start-column 1000000)
          (max-keyword-width 0)
          (case-fold-search nil)
          (x 0)
          (keyword-width 0)
          )
      (if (region-active-p)
          (setq start (min (region-beginning) (region-end))
                end (max (region-beginning) (region-end)))
        (search-backward "\"\"\"")
        (search-forward-regexp "[A-Z]")
        (setq start (point))
        (search-forward "\"\"\"")
        (search-backward-regexp "[A-Za-z]")
        (setq end (point))
        )
      (setq end-line (+ (line-number-at-pos end) 1))
      (goto-char start)
      (back-to-indentation)
      (setq start-column (current-column))
      (while (< (line-number-at-pos) end-line)
        (back-to-indentation)
        ;; (setq start-column (min start-column (current-column)))
        (setq x (point))
        (search-forward-regexp "[^A-Z ]")
        (backward-char 1)
        (setq max-keyword-width
              (max max-keyword-width
                   (- (point) x)))
        (forward-line 1)
        )
      (goto-char start)
      (while (< (line-number-at-pos) end-line)
        (back-to-indentation)
        (if (< (current-column) start-column)
            (insert (make-string (- start-column (current-column)) ?\ ))
          (delete-char (- start-column (current-column))))
        (setq x (point))
        (search-forward-regexp "[^A-Z ]")
        (backward-char 1)
        (setq keyword-width (- (point) x))
        (when (looking-back "[A-Z]")
          (incf keyword-width))
        (back-to-indentation)
        (insert (make-string (- max-keyword-width keyword-width) ?\ ))
        (forward-line 1)
        )
      )))

(defun my-sql-mode-hook ()
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  )
(add-hook 'sql-mode-hook 'my-sql-mode-hook)








(fmakunbound 'sql-clear)

(setq sql-sqlite-options '("-batch" "-interactive"))
(defun sql-add-newline-first (output) nil)
(defun sqli-add-hooks () nil)
;; (setq sql-interactive-mode-hook nil)
(setq comint-preoutput-filter-functions nil)

(setq sql-electric-stuff 'semicolon)
