(defun bookmanager-insert ()
  (interactive)
  (end-of-buffer)
  (insert (read-string "Titel: "))
  (insert " | ")
  (insert (read-string "Forfatter: "))
  (insert " | ")
  (insert (read-string "Stack: "))
  (align-regexp (point-min) (point-max) "\\(\\s-*\\)|" 1 1 t))

(defun bookmanager-sort-title ())
(defun bookmanager-sort-author ())
(defun bookmanager-sort-stack ())
;; isearch
;; isearch from beginning
;; occur
