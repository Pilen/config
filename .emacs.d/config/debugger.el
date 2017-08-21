

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Debuggers.html
;; GUD is the grand unified debugger, having an interface to gdb in gud-gdb
;; To further improve it, there is an additional layer on top of it specific to gdb.
;; So use the `gdb' function.

(setq gdb-many-windows nil)


(unless (boundp 'gdb-mode-hook)
  (defvar gdb-mode-hook ()))

(add-hook 'gdb-mode-hook 'my-gdb-setup)

(defun my-gud-setup ()
  (message "WHAT? my-gud-setup executed"))

(defun my-gdb-setup ()
  (message "my-gdb-setup is executing")
  (defun gdb-display-buffer (buf)
    "Show buffer BUF, and dont make that window dedicated."
    (let ((window (display-buffer buf)))
      window))
  (defun gdb-set-window-buffer (name &optional ignore-dedicated window)
    "Hack to let window not be dedicated"
    (unless window (setq window (selected-window)))
    (set-window-buffer window (get-buffer name)))


  (let ((gud (current-buffer)))
    (previous-buffer)
    (message "fisk")
    (print gud)
    (lexical-let ((frame (make-frame)))
      (with-current-buffer gud
        (add-hook 'kill-buffer-hook (lambda ()
                                      (gdb-reset)
                                      ;; (set-fringe-mode '(0 . 0))
                                      (delete-frame frame))
                  nil t)

        ;; (set-fringe-mode (cons 2 0))
        (with-selected-frame frame
          (set-background-color "#2D2433")
          (let ((breakpoints (window-buffer (gdb-display-breakpoints-buffer)))
                (stack (window-buffer (gdb-display-stack-buffer)))
                (locals (window-buffer (gdb-display-locals-buffer)))
                (io (window-buffer (gdb-display-io-buffer)))
                (height))
            (delete-other-windows)
            (setq height (/ (window-height) 6))

            (switch-to-buffer "*compilation*" t t)
            (setq mode-line-format '("%e" (:eval (propertize (window-numbering-get-number-string) 'face 'window-numbering-face)) ":" mode-line-modified " " mode-line-buffer-identification))
            (set-window-dedicated-p (get-buffer-window) t)

            (split-window-vertically height)
            (switch-to-buffer breakpoints t t)
            (setq mode-line-format '("%e" (:eval (propertize (window-numbering-get-number-string) 'face 'window-numbering-face)) ":" mode-line-modified " " mode-line-buffer-identification))
            (set-window-dedicated-p (get-buffer-window) t)

            (split-window-vertically height)
            (switch-to-buffer stack)
            (setq mode-line-format '("%e" (:eval (propertize (window-numbering-get-number-string) 'face 'window-numbering-face)) ":" mode-line-modified " " mode-line-buffer-identification))
            (set-window-dedicated-p (get-buffer-window) t)

            (split-window-vertically height)
            (switch-to-buffer locals t t)
            (setq mode-line-format '("%e" (:eval (propertize (window-numbering-get-number-string) 'face 'window-numbering-face)) ":" mode-line-modified " " mode-line-buffer-identification))
            (set-window-dedicated-p (get-buffer-window) t)

            (split-window-vertically height)
            (switch-to-buffer gud t t)
            (setq mode-line-format '("%e" (:eval (propertize (window-numbering-get-number-string) 'face 'window-numbering-face)) ":" mode-line-modified " " mode-line-buffer-identification))
            (set-window-dedicated-p (get-buffer-window) t)

            (split-window-vertically height)
            (switch-to-buffer "*eshell*" t t)
            (set-window-dedicated-p (get-buffer-window) t)
            (other-window -2)

            (split-window-horizontally)
            (switch-to-buffer io)
            (setq mode-line-format '("%e" (:eval (propertize (window-numbering-get-number-string) 'face 'window-numbering-face)) ":" mode-line-modified " " mode-line-buffer-identification))
            (set-window-dedicated-p (get-buffer-window) t)

            (other-window 1)
            (balance-windows)))))))
