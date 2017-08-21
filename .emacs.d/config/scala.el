
(setq scala--mode-hook
      '((lambda ()
          (setq scala-mode-hook nil)
          (define-key 'scala-mode-map (kbd "<tab>") (lambda () (message "hej")))))) ;; Unbind ensime-company-complete-or-indent
