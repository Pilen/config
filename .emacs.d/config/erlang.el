;;______________________________________________________________________________
;π ERLANG
;;______________________________________________________________________________
(when (file-exists-p "/usr/lib/erlang/lib")
  (add-to-list 'load-path (concat (car (directory-files "/usr/lib/erlang/lib/" t "^tools-.")) "/emacs/"))
  (require 'erlang-start)

  (add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
  (add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

  (setq erlang-root-dir "/usr/lib/erlang")
  (add-to-list 'exec-path "/usr/lib/erlang/bin")
  (setq erlang-man-root-dir "/usr/lib/erlang/man")


  (add-hook 'erlang-mode-hook (lambda ()
                                ;; when starting an Erlang shell in Emacs, default in the node name
                                (setq inferior-erlang-machine-options '("-sname" "emacs"))))
  (defun inferior-erlang-compile (arg)
    "Compile the file in the current buffer.

With prefix arg, compiles for debug.

Should Erlang return `{error, nofile}' it could not load the object
module after completing the compilation.  This is due to a bug in the
compile command `c' when using the option `outdir'.

There exists two workarounds for this bug:

  1) Place the directory in the Erlang load path.

  2) Set the Emacs variable `erlang-compile-use-outdir' to nil.
     To do so, place the following line in your `~/.emacs'-file:
        (setq erlang-compile-use-outdir nil)"
    (interactive "P")
    (call-interactively 'save-buffer)
    (inferior-erlang-prepare-for-input)
    (let* ((dir (inferior-erlang-compile-outdir))
;;; (file (file-name-nondirectory (buffer-file-name)))
           (noext (substring (buffer-file-name) 0 -4))
           (opts (append (list (cons 'outdir dir))
                         (if current-prefix-arg
                             (list 'debug_info 'export_all))
                         erlang-compile-extra-opts))
           end)
      (save-excursion
        (set-buffer inferior-erlang-buffer)
        (compilation-forget-errors))
      (setq end (inferior-erlang-send-command
                 (inferior-erlang-compute-compile-command noext opts)
                 nil))
      (sit-for 0)
      (inferior-erlang-wait-prompt)
      (save-excursion
        (set-buffer inferior-erlang-buffer)
        (setq compilation-error-list nil)
        (set-marker compilation-parsing-end end))
      (setq compilation-last-buffer inferior-erlang-buffer)))

  )
