
;;______________________________________________________________________________
;π LATEX
;;______________________________________________________________________________

;; TODO: look at the xenops package https://github.com/dandavison/xenops that replaces preview

(require 'tex-site) ;; Auctex
(require 'preview) ;; preview-latex
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
(require 'reftex-toc)
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-clean-confirm nil)

(setq TeX-fold-env-spec-list t)
(setq TeX-fold-macro-spec-list t)
(setq TeX-fold-math-spec-list t)

(setq reftex-plug-into-AUCTeX t)

(setq preview-auto-cache-preamble t)

(define-key LaTeX-mode-map (kbd "<f10>") 'reftex-toc-other-window)
(define-key LaTeX-mode-map (kbd "<f11>") 'LaTeX-environment)
(define-key LaTeX-mode-map (kbd "H-<f11>") 'LaTeX-close-environment)
(define-key LaTeX-mode-map (kbd "S-<f11>") 'LaTeX-insert-matrix)
(define-key LaTeX-mode-map (kbd "<f12>") (lambda () (interactive) (save-buffer) (preview-buffer)))

(define-key reftex-toc-mode-map (kbd "u") 'reftex-toc-previous)
(define-key reftex-toc-mode-map (kbd "e") 'reftex-toc-next)
;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;(setq TeX-view-program-list '(("Zathura" "zathura %o")))
;(setq TeX-view-program-selection '((output-pdf "Zathura")))
(setq TeX-view-program-list '(("Xpdf" "xpdf -fullscreen -cont -z 100 %o")))
(setq TeX-view-program-selection '((output-pdf "Xpdf")))

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(defun my-latex-mode-hook ()
  ;; (visual-line-mode)
  (reftex-mode t)
  (LaTeX-math-mode)
  (auto-fill-mode)
  (set-face-foreground 'font-latex-bold-face "OliveDrab3")
  (set-face-foreground 'font-latex-italic-face "OliveDrab3")
  (setq LaTeX-command "latex -file-line-error -synctex=1"))
(add-hook 'LaTeX-mode-hook 'my-latex-mode-hook)


(eval-after-load "tex"
  '(push `("LaTeX-updatexpdf"
           ,(concat "%`%l%(mode)%' %t; xpdf -remote " xpdfremote/server-name " -exec reload")
           TeX-run-TeX nil
           (latex-mode doctex-mode)
           :help "Run LaTeX")
         TeX-command-list))

(defun run-latex ()
  (interactive)
  (TeX-save-document (TeX-master-file))
  (if (xpdfremote/live)
      (TeX-command "LaTeX-updatexpdf" 'TeX-master-file)
    (TeX-command "LaTeX" 'TeX-master-file))
  ;(TeX-clean nil))
  )

(defun check-item-entry ()
  "This function is meant to be used as advice for the
`LaTeX-insert-item' function. The purpose behind this is to delete
the extra blank line that is naively added by `LaTeX-insert-item'
when not already on an item line."
  (interactive)
  (save-excursion
    ;; Backward one line, check if it happened if the line we're
    ;; looking is empty, delete it
    (if (and (= (forward-line -1) 0)
             (looking-at "^\\s-*$"))
        (kill-line))))

(defadvice LaTeX-insert-item (after remove-whitespace-first-item activate)
  "This advice is meant to fix the issue where an extra blank
line is naively added by `LaTeX-insert-item' when not already on
an item line."
  (check-item-entry))


(setq LaTeX-insert-matrix-type "bmatrix")
(defun LaTeX-insert-matrix ()
  (interactive)
  (let ((r (concat"\\begin{" LaTeX-insert-matrix-type "}\n"))
        (i " "))
    (while (not (string= i ""))
      (setq i (read-string "row: "))
      (setq r (concat r
                      "  "
                      (replace-regexp-in-string " +" " & " i)
                        " \\\\\n")))
    (setq r (substring r 0 -10))
    (setq r (concat r "\n\\end{" LaTeX-insert-matrix-type "}\n"))
    ;;(message r)
    (insert r)))



(defun pad-center (s n)
  (let* ((f (/ (- n (length s)) 2))
         (l (+ f (length s))))
    (format (format "%%%ds" (- n)) (format (format "%%%ds" l) s))))

(defun LaTeX-insert-matrix ()
  (interactive)

  (flet
      ((maximum-map (a b)
                    ;; a = string list, b = int list
                    (loop with r = '()
                          for i below (max (length a) (length b))
                          collect (max-nil (length (nth i a))
                                           (nth i b))))
       (max-nil (a b)
            (if (eq a nil) b
              (if (eq b nil) a
                (max a b))))
       (populate (m n)
                 (interactive)
                 (loop for r in m
                       collect (append r (loop repeat (- n (length r))
                                               collect " "))))
       (format-rows (m maxlen)
                    (mapconcat
                     (lambda (r)
                       (loop for v in r
                             for m in maxlen
                             collect (pad-center v m) into nr
                             finally return
                             (concat "  " (mapconcat 'identity nr " & "))))
                     m
                     " \\\\\n")))

  (loop with i = (read-string "row: ")
        with splitted
        with maxlen

        until (string= i "") do
        (setq splitted (split-string i))
        (setq maxlen (maximum-map splitted maxlen))
        (setq i (read-string "row: "))
        collect splitted into matrix

        finally (insert "\\begin{pmatrix}\n"
                        (format-rows (populate matrix (length maxlen))
                                     maxlen)
                        "\n\\end{pmatrix}\n"))))

(defun reftex-toc-other-window ()
  (interactive)
  (save-excursion
    (pop-to-buffer "*toc*"))
  (reftex-toc))
