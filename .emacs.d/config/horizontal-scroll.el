;;______________________________________________________________________________
;π HORIZONTAL SCROLL
;;______________________________________________________________________________
(setq my-horizontal-scroll-factor 3)

(defun my-scroll-right (&optional reverse)
  (interactive)
  (let* ((eol (save-excursion
               (end-of-line)
               (point)))
        (bol (save-excursion
               (beginning-of-line)
               (point)))
        (width (/ (window-width) my-horizontal-scroll-factor))
        (width (if reverse (- width) width)))

    (cond
     ((< (+ (point) width) bol)
      (goto-char bol))
     ((> (+ (point) width) eol)
      (goto-char eol))
     (t
      (goto-char (+ (point) width))))))

(defun my-scroll-left ()
  (interactive)
  (my-scroll-right t))
