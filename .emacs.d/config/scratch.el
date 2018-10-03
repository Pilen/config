(defcustom scratch-mode-hook nil
  "Hooks for scratch mode"
  :type 'hook)

(define-derived-mode scratch-mode fundamental-mode "Scratch" "Scratch buffers"
  (interactive)
  (setq electric-indent-inhibit t)
  (run-hooks 'scratch-mode-hook))

(defun create-scratch-buffer ()
  "Create a scratch buffer"
  (interactive)
  (pop-to-buffer (get-buffer-create (generate-new-buffer-name "scratch")))
  (scratch-mode)
  (emacs-lock-mode 'exit))
