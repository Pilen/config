;;______________________________________________________________________________
;π HELP
;;______________________________________________________________________________

(defun my-help ()
  (interactive)
  (let ((window (selected-window)))
    (case major-mode
      (python-mode (jedi:show-doc))
      (emacs-lisp-mode (describe-thing-at-point))
      (t (describe-thing-at-point)))
    (select-window window)))

(defun describe-thing-at-point ()
  (interactive)
  (help-xref-interned (symbol-at-point)))

(defun my-documentation ()
  (interactive)
  (case major-mode
    (python-mode (my-documentation-python))
    (emacs-lisp-mode (info "elisp")))
  )

(defvar my-documentation--cache nil)

(defun my-documentation-python ()
  (interactive)
  (let ((cached (assoc 'python-mode my-documentation--cache)))
    (unless cached
      (setq cached
            (let* ((url "http://docs.python.org/3/library/index.html")
                   (html (with-current-buffer (url-retrieve-synchronously url)
                           (libxml-parse-html-region (point-min) (point-max) url t)))
                   (html2 (with-current-buffer "py.html"
                            (libxml-parse-html-region (point-min) (point-max) nil t)))
                   (map (mapcar
                         (lambda (node)
                           (cons (dom-texts node)
                                 (concat "http://docs.python.org/3/library/"  (dom-attr node 'href))))
                         (dom-by-class (car (dom-by-class html "toctree-wrapper")) "reference"))))
              map))
      (push (cons 'python-mode cached) my-documentation--cache))
    (let ((choice (cdr (assoc  (ivy-completing-read "Section: " cached) cached))))
      (when choice
        (eww choice)))))

;; (setq my-documentation--cache nil)
;; (my-documentation-python)
