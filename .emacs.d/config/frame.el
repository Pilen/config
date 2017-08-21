
(defvar my-frame-main (selected-frame) "Main frame")

(defun my-frame-new ()
  "Create a new frame"
  (interactive)
  (make-frame '((:background-color "yellow"))))

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
