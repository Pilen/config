;;______________________________________________________________________________
;π FLYMAKE
;;______________________________________________________________________________
(require 'flymake)
(require 'flymake-cursor)
(setq flymake-no-changes-timeout 5)

;; Flymake for LaTeX
;(defun flymake-get-tex-args (file-name)
;  (list "chktex" (list "-g0" "-r" "-l" (expand-file-name "~/.chktexrc") "-I" "-q" "-v0" file-name)))
;(push
; '("^\\(\.+\.tex\\):\\([0-9+\\):\\([0-9]+\\):\\(.+\\))"
;   1 2 3 4) flymake-err-line-patterns)
;(defun flymake-get-tex-args (file-name)
;  (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;; Underline errors instead of highlight


;; Quickly show next err-menu
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line)
  )

;(add-hook 'LaTeX-mode-hook 'flymake-mode)


(defun flyc/show-stored-error-now ()
  "Displays the stored error in the minibuffer."
  (interactive)
  (let ((editing-p (= (minibuffer-depth) 0)))
    (if (and flyc--e-at-point editing-p)
        (progn
          (message "%s" (replace-regexp-in-string "\0" "\n" (flyc/maybe-fixup-message flyc--e-at-point)))
          (setq flyc--e-display-timer nil)))))
