;;______________________________________________________________________________
;π HELP
;;______________________________________________________________________________

(defun my-help ()
  (interactive)
  (let ((window (selected-window)))
    (case major-mode
      (python-mode (jedi:show-doc))
      (emacs-lisp-mode (describe-thing-at-point))
      (t (describe-thing-at-point)))
    (select-window window)))

(defun describe-thing-at-point ()
  (interactive)
  (help-xref-interned (symbol-at-point)))
