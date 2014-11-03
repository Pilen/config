;;______________________________________________________________________________
;π SHELL
;;______________________________________________________________________________
(ansi-color-for-comint-mode-on)
(defvar my-shells '("*eshell*" "*shell*" "*shell0*" "*shell1*" "*shell2*" "*shell3*"))
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)
(defun make-my-shell-output-read-only (text)
  "Add to comint-output-filter-functions to make stdout read only in my shells."
  (if (member (buffer-name) my-shells)
      (let ((inhibit-read-only t)
            (output-end (process-mark (get-buffer-process (current-buffer)))))
        (put-text-property comint-last-output-start output-end 'read-only t))))
(add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)

;; make completion buffers disappear after 3 seconds.
;(add-hook 'completion-setup-hook
;          (lambda() (run-at-time 3 nil
;                                 (lambda () (delete-windows-on "*Completions*")))))
