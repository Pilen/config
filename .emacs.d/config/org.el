
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
