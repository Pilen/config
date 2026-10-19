;;; send-to-claude.el --- Paste current buffer into the Claude desktop window  -*- lexical-binding: t; -*-

(require 'subr-x)
(require 'seq)

(defvar my/claude-classname "com.anthropic.Claude"
  "X window classname of the Claude app.")

(defun my/claude--hex-to-number (s)
  (string-to-number (string-remove-prefix "0x" s) 16))

(defun my/claude--window-id ()
  "Return the X window id of the single running Claude window.
Only windows managed by bspwm count, which filters out the hidden
helper windows Electron apps tend to create."
  (let* ((managed (mapcar #'my/claude--hex-to-number
                          (process-lines "bspc" "query" "-N" "-n" ".window")))
         (found (mapcar #'string-to-number
                        (process-lines-ignore-status
                         "xdotool" "search" "--classname" my/claude-classname)))
         (ids (seq-filter (lambda (id) (memql id managed)) found)))
    (pcase (length ids)
      (0 (user-error "Claude is not running"))
      (1 (car ids))
      (_ (user-error "Found %d Claude windows, expected one" (length ids))))))

(defun my/claude--set-clipboard (text)
  "Put TEXT on the X clipboard."
  (if (display-graphic-p)
      (gui-set-selection 'CLIPBOARD text)
    ;; Terminal Emacs: hand it to xclip.  DESTINATION 0 means don't wait,
    ;; since xclip stays alive in the background to serve the selection.
    (with-temp-buffer
      (insert text)
      (call-process-region (point-min) (point-max)
                           "xclip" nil 0 nil "-selection" "clipboard"))))

(defun my/send-buffer-to-claude ()
  "Copy the buffer, trimmed, focus the Claude window and paste it there."
  (interactive)
  (let ((text (string-trim (buffer-substring-no-properties (point-min) (point-max)))))
    (when (string-empty-p text)
      (user-error "Buffer is empty"))
    (let ((win (my/claude--window-id)))
      (my/claude--set-clipboard text)
      (unless (zerop (call-process "bspc" nil nil nil
                                   "node" (format "0x%08X" win) "-f"))
        (error "bspc failed to focus window 0x%08X" win))
      ;; Give the window a moment to actually receive focus.
      (sleep-for 0.1)
      (call-process "xdotool" nil nil nil "key" "--clearmodifiers" "ctrl+v"))))

(provide 'send-to-claude)
;;; send-to-claude.el ends here
