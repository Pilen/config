;;______________________________________________________________________________
;π AUTO-INSERT
;;______________________________________________________________________________
(require 'autoinsert)
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates/")
(setq auto-insert-query nil)
(setq auto-insert-alist '(
                          ("\\.tex$" . ["preamble.tex" auto-update-template]);(lambda () (goto-line 40))])
                          ))


(defun insert-today ()
  "Insert today's date into buffer"
  (interactive)
  (insert (format-time-string "%e/%m - %Y" (current-time))))

(defun auto-update-template ()
  "Replace the following sequences when files are created from templates:
@@@CURSOR
@@@DATE
@@@YEAR
@@@FILENAME"
  (save-excursion
    ;;Replace @@@DATE with date
    (while (search-forward "@@@DATE" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match "")
        (insert-today)
        ))
    )
  (save-excursion
    ;;Replace @@@YEAR with year
    (while (search-forward "@@@YEAR" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match "")
        (insert (format-time-string "%Y" (current-time)))
        ))
    )
  (save-excursion
    ;;Replace @@@FILENAME with file name
    (while (search-forward "@@@FILENAME" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (file-name-nondirectory buffer-file-name) t)
        ))
    )
  ;;Move cursor to last occurence of @@@CURSOR
  (while (search-forward "@@@CURSOR" nil t)
    (save-restriction
      (narrow-to-region (match-beginning 0) (match-end 0))
      (replace-match "")
      )
    )
  )
