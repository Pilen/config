
(require 'cl)

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


(defun bookmanager--sort (field)
  "Sort lines by fields, but uses the bookmanagers notion of fields."
  (save-excursion
    (let ;; To make `end-of-line' and etc. to ignore fields.
        ((inhibit-field-text-motion t))
      (goto-char (point-min))
      (search-forward-regexp ".") ;; Find first nonempty line
      (backward-char)
      (lexical-let ((field field))
        (sort-subr nil
                   'forward-line
                   'end-of-line
                   (lambda () (dotimes (_ field) (search-forward "|")) nil)
                   (lambda () (search-forward-regexp "|\\|$") nil)
                   )))))

(defun bookmanager-sort-author ()
  (interactive)
  (bookmanager--sort 0))

(defun bookmanager-sort-title ()
  (interactive)
  (bookmanager--sort 1))

(defun bookmanager-sort-series ()
  (interactive)
  (bookmanager--sort 2))

(defun bookmanager-sort-place ()
  (interactive)
  (bookmanager--sort 3))

(defun bookmanager-sort-type ()
  (interactive)
  (bookmanager--sort 4))

(defun bookmanager-sort-language ()
  (interactive)
  (bookmanager--sort 5))

(defun bookmanager-sort-status ()
  (interactive)
  (bookmanager--sort 6))


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
     ["author" (bookmanager-sort-author) t]
     ["title" (bookmanager-sort-title) t]
     ["series" (bookmanager-sort-series) t]
     ["place" (bookmanager-sort-place) t]
     ["type" (bookmanager-sort-type) t]
     ["language" (bookmanager-sort-language) t]
     ["status" (bookmanager-sort-status) t]
     )))


(add-to-list 'auto-mode-alist '("\\.bmn?$" . bookmanager-mode))
(provide 'bookmanager)
