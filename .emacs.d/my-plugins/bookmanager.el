(defun bookmanager-insert ()
  (interactive)
  (end-of-buffer)
  (insert (read-string "Author: "))
  (insert " | ")
  (insert (read-string "Title: "))
  (insert " | ")
  (insert (read-string "Series: "))
  (insert " | ")
  (insert (read-string "Place: "))
  (insert " | ")
  (insert (read-string "Type: "))
  (insert " | ")
  (insert (read-string "Language: "))
  (insert " | ")
  (insert (read-string "Status: "))
  (insert "\n")
  (bookmanager-format))

(defun bookmanager-format ()
  (interactive)
  (align-regexp (point-min) (point-max) "\\(\\s-*\\)|" 1 1 t))

(defun bookmanager-sort-title ()
  (interactive)
  (sort-regexp-fields nil "^.*$" "|.*$" (point-min) (point-max)))

(defun bookmanager-sort-author ()
  (interactive)
  (sort-lines nil (point-min) (point-max)))

(defun bookmanager-sort-placement ())

(defun bookmanager-sort-series ()
  (interactive)
  (sort-regex-fields nill "^.*$" "|.*$" "|.*$" (point-min) (point-max)))

(defvar bookmanager-mode-map nil "Keymap for bookmanager mode")
(when (not bookmanager-mode-map)
  (setq bookmanager-mode-map (make-sparse-keymap))
  (define-key bookmanager-mode-map (kbd "C-i") 'bookmanager-insert))

(define-derived-mode bookmanager-mode fundamental-mode
  "bookmanager mode"
  (hl-line-mode))

(easy-menu-define bookmanager-menu bookmanager-mode-map "bookmanager"
  '("bookmanager"
    ["insert" (bookmanager-insert) t]
    ["format" (bookmanager-format) t]
    ["search" (progn (beginning-of-buffer) (isearch-forward)) t]
    ["occur" (call-interactively 'occur) t]
    ("sort"
     ["title" (bookmanager-sort-title) t]
     ["author" (bookmanager-sort-author) t]
     ["series" (bookmanager-sort-series) t])))


(add-to-list 'auto-mode-alist '("\\.bmn?$" . bookmanager-mode))
(provide 'bookmanager)
