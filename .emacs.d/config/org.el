
;; Alert Caro not to disturb me when clocking in, and that it is okay agin when clocking out
;; org-clock-in-hook
;; org-clock-out-hook
;; org-clock-cancel-hook

(require 'org-mouse)
(defun my-org-clock-in ()
  )


;; By default org-beamer will export *text* as \alert{text} not \textbf{text}, revert this
(defun my-beamer-bold (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

(require 'ox)
(add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)


(defun my-org-shift-return ()
  (interactive)
  (if (org-at-table-p)
  ;; (if (org-table-check-inside-data-field t)
      ;; (call-interactively 'org-table-copy-down)
      ;; (call-interactively 'org-table-insert-row)
      (org-table-insert-row 'below)
    (call-interactively 'new-indented-line))
  ;; (call-interactively 'new-indented-line)
  )

(define-key org-mode-map (kbd "S-<return>") 'my-org-shift-return)

(setq org-html-postamble nil)

(setq org-export-allow-bind-keywords t)

(defun my-org-sentence-end (text backend info)
  (replace-regexp-in-string "\\.\\(\n\\|$\\)" ".<span class='sentence-end'></span>\\1" text)
  )

(setq org-cycle-separator-lines 3)

(setq org-edit-src-content-indentation 0)

(message "remember to (require 'org-tempo)")
;; (require 'org-tempo)


(add-to-list 'org-babel-load-languages '(python . t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

(setq org-confirm-babel-evaluate nil)

(setq org-src-preserve-indentation t)

(setq org-src-tab-acts-natively t)

(defun my-org-return ()
  (interactive)
  (if (org-in-src-block-p t)
      (org-return-indent)
    (org-return)))
(define-key org-mode-map (kbd "<return>") 'my-org-return)

;; https://emacs.stackexchange.com/questions/7629/the-syntax-highlight-and-indentation-of-source-code-block-in-exported-html-file
;(setq org-html-htmlize-output-type 'css)

(setq org-babel-min-lines-for-block-output 10000)

;; (setq org-babel-python-command "python ")
