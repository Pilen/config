
;; Alert Caro not to disturb me when clocking in, and that it is okay agin when clocking out
;; org-clock-in-hook
;; org-clock-out-hook
;; org-clock-cancel-hook


(defun my-org-clock-in ()
  )


;; By default org-beamer will export *text* as \alert{text} not \textbf{text}, revert this
(defun my-beamer-bold (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

(add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)


(defun my-org-shift-return ()
  (interactive)
  (if (org-table-check-inside-data-field t)
      (call-interactively 'org-table-copy-down)
    (call-interactively 'new-indented-line)))

(define-key org-mode-map (kbd "S-<return>") 'my-org-shift-return)

(setq org-html-postamble nil)


(setq org-export-allow-bind-keywords t)

(defun my-org-sentence-end (text backend info)
  (replace-regexp-in-string "\\.\\(\n\\|$\\)" ".<span class='sentence-end'></span>\\1" text)
  )

