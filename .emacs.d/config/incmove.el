;;______________________________________________________________________________
;π INCMOVE
;;______________________________________________________________________________
(defvar incmove-jump 0)
(setq incmove-jump 0)

(defun incmove-up ()
  (interactive)
  (incmove-move 'incmove-up))

(defun incmove-down ()
  (interactive)
  (incmove-move 'incmove-down))

(defun incmove-left ()
  (interactive)
  (incmove-move 'incmove-left))

(defun incmove-right ()
  (interactive)
  (incmove-move 'incmove-right))

(defun incmove-move (dir)
  (setq this-command dir)
  (when (not (eq last-command dir))
    (setq incmove-jump 0))
  (incf incmove-jump 1)

  (let ((amount (incmove-calc incmove-jump)))
    (cond
     ((eq dir 'incmove-up)
      (line-move (- amount)))
     ((eq dir 'incmove-down)
      (line-move amount))
     ((eq dir 'incmove-left)
      (forward-char (- amount)))
     ((eq dir 'incmove-right)
      (forward-char amount)))))

(defun incmove-calc (n)
  (min (/ (+ (incmove-fib n) n) 2) (window-height)))

(defun incmove-fib (m)
  (flet ((f (n l h)
            (if (= n 0)
                l
              (f (- n 1) h (+ l h)))))
    (f m 0 1)))

(defun incmove-calc (n)
  (min n (window-height)))

;; (global-set-key (kbd "H-C-u") 'incmove-up)
;; (global-set-key (kbd "H-C-e") 'incmove-down)
;; (global-set-key (kbd "H-C-n") 'incmove-left)
;; (global-set-key (kbd "H-C-i") 'incmove-right)
