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

(defun next-scratch-buffer ()
  (interactive)
  (let* ((current-name (buffer-name))
         (buffer-names (mapcar #'buffer-name (buffer-list)))
         (filtered (seq-filter (lambda (name) (string-prefix-p "scratch" name)) buffer-names))
         (sorted (sort filtered #'string-collate-lessp))
         (sorted2 sorted)
         (first (car sorted))
         (selected (catch 'return
                     (while sorted
                       (when (string= (car sorted) current-name)
                         (throw 'return (or (cadr sorted) first)))
                       (setq sorted (cdr sorted)))
                     first)))
    (switch-to-buffer selected)))
