;;______________________________________________________________________________
;π ISEARCH
;;______________________________________________________________________________
(defun sdacha/isearch-yank-current-word ()
  "Pull current word from buffer into search string."
  (interactive)
  (save-excursion
    (skip-syntax-backward "w_")
    (isearch-yank-internal
     (lambda ()
       (skip-syntax-forward "w_")
       (point)))))
(define-key isearch-mode-map (kbd "C-x") 'sacha/isearch-yank-current-word)
(define-key isearch-mode-map (kbd "H-u") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "H-e") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "H-m") 'isearch-edit-string)
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(define-key isearch-mode-map (kbd "H-v") (lambda () (interactive) (isearch-yank-string (buffer-substring (region-beginning) (region-end)))))
(define-key isearch-mode-map (kbd "H-n") (lambda () (interactive) (isearch-done) ;; (push-mark)
                                           (goto-char isearch-other-end)))

(defun isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string
             (regexp-quote isearch-string))))
  (let ((current-pos (format "%d:" (count-lines 1 (point)))))
    (other-window 1)
    (search-forward current-pos)))

(define-key isearch-mode-map (kbd "H-m") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "H-M") 'isearch-repeat-backward)
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)
