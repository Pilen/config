
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;π New
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (insert (gui-get-selection nil 'text/html))
;; (insert (gui-get-selection 'PRIMARY 'text/html))
;; (call-process-region (point-min) (point-max) "xclip" nil nil nil "-in" "-selection" "clipboard" "-target" "text/html")

;; (let ((org-export-with-toc nil)
;;       (org-export-with-section-numbers nil)
;;       (org-export-preserve-breaks t)
;;       )
;;   (org-html-convert-region-to-html))


(defun my-status-email ()
  (interactive)
  (let* ((status-buffer (current-buffer))
         (org-export-with-toc nil)
         (org-export-with-section-numbers nil)
         (org-export-preserve-breaks t)
         (org-html-toplevel-hlevel 1)
         ;; (org-export-with-tasks 'done)
         (org-export-with-tasks '("TODO" "ACTIVE" "BLOCKED" "DONE"))
         (my-status-email-head "
<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\">
<style>
h1 {
  font-size: 13.5pt;
  margin: 10px 0px 0px 0px;
}
h2 {
  font-size: 12pt;
  margin: 2px 0px 0px 0px;
  font-weight: 400;
}
h3 {
  font-size: 12pt;
  font-weight: 400;
  margin: 2px 0px 0px 0px;
}
p {
  margin: 0px;
  font-size: 11pt;
}
.TODO, .ACTIVE, .BLOCKED, .DONE {
  font-size: 8px;
  border-radius: 2px;
  background: #ddd;
}
.TODO {
  background: #b0e2ff;
}
.ACTIVE {
  background: #c1ffc1;
}
.BLOCKED {
  background: #ffe7ba;
}
.DONE {
  background: #ddd;
}
.outline-1 {
  margin-left: 0px;
}
.outline-2, .outline-text-1 {
  margin-left: 10px;
}
.outline-3, .outline-text-2 {
  margin-left: 20px;
}
.outline-4, .outline-text-3 {
  margin-left: 30px;
}

</style>
<span data-olk-copy-source=\"MailCompose\"></span>
")
         (descriptions (list
                        ;; "an acceptable"
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
                        "a relaxing"
                        ;; "a cool"
                        ))
         (description (nth (random (length descriptions)) descriptions))
         (filename (buffer-name))
         (week (or (and (string-match "^status-\\([0-9]+\\)\\.org$" filename) (match-string 1 filename)) (read-string "Uge nummer: ")))
         ;; (org-html-head "")
         ;; (org-html-head-extra "")
         ;; (org-html-head-include-default-style nil)
         ;; (org-html-head-include-scripts nil)
         ;; (org-html-preamble nil)
         ;; (org-html-postamble nil)
         ;; (org-html-use-infojs nil)
         )
    (with-current-buffer (get-buffer-create "*status-email*")
      (erase-buffer)
      (insert-buffer-substring status-buffer)
      (set-mark 0)                      ;; Mark entire buffer
      (org-html-convert-region-to-html) ;; Does not insert preamble stuff
      ;; (insert "<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\">\n")
      (insert "<br><br>Have " description " weekend!")
      (goto-char 0)
      (insert my-status-email-head)
      (goto-char 0)
      ;; Insert : on headlines where needed
      (while (re-search-forward "^<h[0-9] " nil t)
        (forward-line 1)
        (unless (looking-at-p "^</div>")
          (search-backward "</h")
          (insert ":")))
      (goto-char 0)
      ;; Remove id attributes
      (while (re-search-forward "^<\\([^>]+\\) id=\"[^\"]*\"\\([^>]*\\)>" nil t)
        (replace-match "<\\1\\2>"))
      (call-process-region (point-min) (point-max) "xclip" nil nil nil "-in" "-selection" "clipboard" "-target" "text/html")
      (gui-set-selection 'PRIMARY (concat "Status Email - Week " week))
      )
    ))
;; □
;; △
;; Notes:  `SCHEDULED` triggers a :


;; (org-next-visible-heading)
;; (buffer-substring-no-properties (line-beginning-position) (line-end-position))
;; (org-current-level)
;; (org-get-todo-state)
;; (org-entry-is-todo-p)


(defun my-status-create ()
  (interactive)
  (let* ((last-week (current-buffer))                                                      ;; Buffer
         (this-week (find-file-noselect (format-time-string "~/status/%Y/status-%V.org"))) ;; Buffer
         left-window
         right-window
         stack ;; ([level text transfered] [...] ...)

         current-level
         text
         )

    ;; Window configuration
    (delete-other-windows)
    (setq left-window (selected-window))
    (switch-to-buffer this-week)
    (setq right-window (split-window-right))
    (select-window right-window)
    (switch-to-buffer last-week)
    (select-window right-window)
    (goto-char (point-min))

    ;; Copy options
    (while (looking-at-p "#")
      (setq text (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
      (select-window left-window)
      (insert text)
      (org-ctrl-c-ctrl-c)
      (insert "\n")
      (select-window right-window)
      (forward-line 1)
      )

    ;; Loop
    (while (not (eobp))
      (org-next-visible-heading 1)
      (setq current-level (org-current-level))
      (setq text (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
      (while (and stack (<= current-level (aref (car stack) 0)))
        ;; Replace top of stack
        (pop stack))
      (push (vector current-level text nil) stack)
      (when (and (org-entry-is-todo-p) (y-or-n-p "Copy this?"))
        (dolist (elem stack)
          (unless (aref elem 2)
            (select-window left-window)
            (beginning-of-line)
            (insert (aref elem 1))
            (insert "\n")
            (forward-line -1)
            (aset elem 2 t)
            (when (= (aref elem 0) 1)
              (insert "\n"))
            (select-window right-window)
            ))
        (select-window left-window)
        (goto-char (point-max))
        (select-window right-window)
        ))))
