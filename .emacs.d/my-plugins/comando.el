(defvar comando-key-map nil "Keymap for comando mode")

(defvar comando-key "M-")

(defun comando-define (key command  &optional break &optional nonglobal)
  "Defines a new key in the global keymap as well as in the comando mode"
  ;;(if (or nonglobal)
      (global-set-key (kbd key) command))
  (define-key comando-mode-map (if (string= (substring key 0 (string-width comando-key)) comando-key)
                                   (substring key (string-width comando-key))
                                 (key))
    command)


(define-minor-mode comando-mode
  "Toggle comando mode.
With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

When comando mode is on comando-key is substracted from all keypresses.
Hopefully this might reduce the amount of buttonmashing sometimes needed when navigating documents."
  :init-value nil
  :lighter " cmdo "
  :global t
  :keymap comando-key-map)

(provide 'commando)
