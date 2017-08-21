
;; look into cmake-ide?
;; and rtags


(defun c-find-header ()
    (interactive)
    (let ((header-name (concat (file-name-sans-extension (buffer-file-name)) ".h")))
      (if (file-exists-p header-name)
          (find-file header-name)
        (if (not (yes-or-no-p "Create header?"))
            (call-interactively 'ido-find-file))
        (find-file header-name)
        (let ((name (upcase (replace-regexp-in-string "-" "_" (file-name-base (buffer-file-name)))))
              (prefix (upcase (read-string "Prefix: "))))
          (insert "#ifndef " prefix "_" name "_H\n")
          (insert "#define " prefix "_" name "_H\n")
          (insert "\n\n\n")
          (insert "#endif")
          (forward-line -2)))
      (current-buffer)))

(defun c-add-to-header ()
  (interactive)
  (save-excursion
    (let* ((start (progn (beginning-of-defun) (point)))
           (end (progn (search-forward "{") (search-backward ")") (forward-char 1) (point)))
           (func (buffer-substring-no-properties start end)))
      (c-find-header)
      (goto-char (point-max))
      (search-backward "#endif")
      (search-backward-regexp ".\n")
      (goto-char (match-end 0))
      (search-backward-regexp "")
      (insert func ";\n"))))
