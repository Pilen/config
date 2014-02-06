
(defcustom toast-time "8 minutes"
  "How long it shoud take to bake a toast.
The values should be either a number of seconds or a string with
a relative time (the acceptable formats are those recognized by
`timer-duration'")

(defun toast ()
  "Make a toast"
  (interactive)
  (run-at-time toast-time nil
               (lambda ()
                 (switch-to-buffer (generate-new-buffer "Toast"))
                 (toast-mode)
                 (insert "Your toast is done")))
  (message (concat "Your toast is done in " toast-time)))

(define-derived-mode toast-mode fundamental-mode "Toast"
  "A toast mode"
  (use-local-map toast-mode-map)
  ;;(read-only-mode)
)

(setq toast-mode-map
  (let ((fn (lambda () (interactive) (kill-buffer (current-buffer))))
        (map (make-sparse-keymap)))
    (define-key map (kbd "SPC") fn)
    (define-key map (kbd "a") fn)
    (define-key map (kbd "H-a") fn)
    (define-key map (kbd "<return>") fn)
    (mapc (lambda (x) (define-key map (kbd x) fn))
          (split-string "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ" "" t))
    map))
