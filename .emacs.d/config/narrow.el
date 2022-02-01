;;______________________________________________________________________________
;π NARROW
;;______________________________________________________________________________

(defun narrow-toggle (beg end)
  "If narrow, widen; if not narrowed, narrow!"
  (interactive "r") ; "r" for region
  (if (narrow-p)
      (progn (widen)
             (message "Un-narrowing."))
    (progn (narrow-to-region beg end)
           (message "Narrowing to c%s - c%s." beg end))))

(defun narrow-p ()
  "Whether narrow is in effect for the current buffer"

  (let (real-point-min real-point-max)
    (save-excursion (save-restriction
                      (widen)
                      (setq real-point-min (point-min)
                            real-point-max (point-max))))
    (or
     (/= real-point-min (point-min))
     (/= real-point-max (point-max)))))


(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (lexical-let ((start start)
                (end end))
    (run-with-idle-timer
     0 nil
     (lambda ()
       (let ((buf (clone-indirect-buffer nil nil)))
         (with-current-buffer buf
           (narrow-to-region start end))
         (switch-to-buffer buf)
         (when linum-mode (linum-mode -1) (linum-mode)))))))
