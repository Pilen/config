;;______________________________________________________________________________
;π JUMP TO MATCHING PARETHESIS
;;______________________________________________________________________________

;; (defun goto-match-paren (arg)
;;   "Go to the matching parenthesis if on parenthesis, otherwise insert the character typed."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;         ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;                                         ;(t (self-insert-command (or arg 1)))))
;;         ))

(defun goto-match-paren-or-defun (arg)
  (interactive "p")
  (let ((pos (point)))
    (ignore-errors (call-interactively 'goto-match-paren))
    (when (equal (point) (point-min))
      (goto-char pos)
      (beginning-of-defun))))

(defun goto-match-paren ()
  "Go to the matching parenthesis if on parenthesis. Else go to the
   opening parenthesis one level up."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1))
        (t
         (backward-char 1)
         (cond ((looking-at "\\s\)")
                (forward-char 1) (backward-list 1))
               (t
                (while (not (looking-at "\\s("))
                  (backward-char 1)
                  (cond ((looking-at "\\s\)")
                         (message "->> )")
                         (forward-char 1)
                         (backward-list 1)
                         (backward-char 1)))
                  ))))))

(defun comment-or-uncomment-region-or-line ()
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (save-excursion
    (comment-or-uncomment-region (progn (beginning-of-line) (point))
                                 (progn (end-of-line) (point))))))
