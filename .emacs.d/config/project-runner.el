
(defun project-runner--recursive-escape (raw)
  (combine-and-quote-strings
   (mapcar
    (lambda (item)
      (if (consp item)
          (project-runner--recursive-escape item)
        (format "%s" item)))
    raw)
   " "))



(string-remove-prefix "$" "$foo")
(let ((string (symbol-name '$foo)))
  (when (s-starts-with? "$" string)
    (s-chop-prefix "$" string)
    ))

;; (define-transient-command )

(defvar project-runner--history nil)
(setq project-runner--history nil)

(defun project-runner ()
  (interactive)
  (let* ((project-file-name "project.ep")
         (project-dir (locate-dominating-file default-directory project-file-name))
         (project-file (expand-file-name project-file-name project-dir))
         (commands nil)
         (commands-alist nil)
         (sexp)
         (current)
         (sorted-commands nil)
         (selected-name)
         (selected-key)
         (command-string)
         (selected-dir)
         )
    (save-buffer)
    (unless project-dir (error "Not inside a project"))

    ;; Read commands
    (with-temp-buffer
      (insert-file-contents project-file)
      (ignore-errors
        (while (setq sexp (read (current-buffer)))
          (push sexp commands)
          ))
      (setq commands (reverse commands)))

    ;; Create alist of commands
    (setq commands
          (mapcar (lambda (command)
                    `((,project-file . ,(plist-get command :name)) . ,command))
                  commands))

    ;; Sort commands
    (dolist (key project-runner--history)
      (when (string= (car key) project-file)
        (setq current (assoc key commands))
        (if current
            (progn
              (push current sorted-commands)
              (setq commands (delete current commands)))
          ;; (delete key project-runner--history)
          )
      ))
    (dolist (command commands)
      (push command sorted-commands))
    (setq sorted-commands (reverse sorted-commands))

    ;; Select
    (setq selected-name (ivy-read "Command: " (mapcar (lambda (command) (cdar command)) sorted-commands) :require-match t :sort nil))
    (setq selected-key (cons project-file selected-name))
    (setq project-runner--history (delete selected-key project-runner--history))
    (push selected-key project-runner--history)
    (setq selected-command (cdr (assoc selected-key sorted-commands)))

    ;; directory
    (setq selected-dir (plist-get selected-command :dir))
    (setq selected-dir (pcase selected-dir
                         ('default-directory default-directory)
                         ('project project-dir)
                         ('nil project-dir)
                         ((pred stringp) selected-dir)
                         (_ (error "Invalid :dir"))))

    ;; Run command
    (setq command-string (project-runner--recursive-escape (plist-get selected-command :command)))
    (let ((default-directory selected-dir))
      (pcase (plist-get selected-command :method)
        ((or 'compile 'nil)
         (compile command-string))
        ('shell (start-process-shell-command "*project-runner*" (get-buffer-create "*project-runner*") command-string))))))
