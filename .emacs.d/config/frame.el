
(defvar my-frame-main (selected-frame) "Main frame")

(defun my-frame-new ()
  "Create a new frame"
  (interactive)
  (with-selected-frame (make-frame-command)
    ;; (set-background-color "grey28")
    (if (frame-live-p my-frame-main)
        (my-frame-random-background (length (frame-list)))
      (setq my-frame-main (selected-frame)))))

(defun my-frame-close ()
  "Close current frame"
  (if (eq my-frame-main (selected-frame))
      (message "Cant delete main frame")
    (delete-frame)))

(defun my-frame-close-extra ()
  "Delete all other frames than the main"
  (interactive)
  (dolist (frame (frame-list))
    (unless (eq frame my-frame-main)
      (delete-frame frame))))

(defun my-frame-close-others ()
  "Close all other frames than this"
  (interactive)
  (if (eq my-frame-main (selected-frame))
      (delete-other-frames)
    (if (yes-or-no-p "Delete main frame?")
        (progn
          (setq my-frame-main (selected-frame))
          (delete-other-frames))
        (message "No frames closed"))))


(defun my-frame-random-background (&optional c)
  (interactive)
  0.27951899509803924
  (let* ((h (if c (+ (* 0.37 c) (random* 0.1))
              (random* 1.0)))
         (s (+ 0.25 (random* 0.05)))
         (l (+ 0.15 (random* 0.05))))
    (while (> h 1.0)
      (decf h))
    (set-background-color (apply 'color-rgb-to-hex (color-hsl-to-rgb h s l)))))

(defun my-frame-reset-background ()
  (interactive)
  (set-background-color (frame-parameter my-frame-main 'background-color)))

(defvar my-nice-background-colors '("#203538" "#1e2034" "#1d2031"))
;; (frame-parameter nil 'background-color)


(defun my-frame-select-color ()
  (interactive)
  (let* ((colors `(("timesheet" . "#1fc61bf133a9")
                   ("four" . "#1e74326d34a1")
                   ("dusty" . ,(apply 'color-rgb-to-hex (color-hsl-to-rgb 0.53 0.22 0.22)))
                   ("dusty2" . ,(apply 'color-rgb-to-hex (color-hsl-to-rgb 0.53 0.13 0.28)))
                   ))
         (color-names (mapcar #'car colors))
         (selected-name (ido-completing-read "select background color: " color-names nil t))
         (selected-color (alist-get selected-name colors)))
    (set-background-color selected-color)))
;; (my-frame-select-color)
