;;______________________________________________________________________________
;π ANYTHING
;;______________________________________________________________________________
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)
                                        ;(require 'anything-config)
(defun my-anything ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-buffers+
     anything-c-source-recentf
     anything-c-source-files-in-current-dir+
     ;anything-c-source-locate
     ;anything-c-source-man-pages
     ;anything-c-source-info-libc
     ;anything-c-source-emacs-commands
     ;anything-c-source-emacs-functions
     ;anything-c-source-emacs-variables
     )
   "*my-anything*"))
(define-key anything-map (kbd "H-u") 'anything-previous-line)
(define-key anything-map (kbd "H-e") 'anything-next-line)
