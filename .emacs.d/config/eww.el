;; (unless (boundp 'my-eww-evaled) (setq my-eww-evaled t) (eval-buffer))
(require 'eww)
(require 'shr)

(defface my-shr-monoface
  '((t ;; :foreground "cyan"
       ;; :background "DeepSkyBlue4"
       ;; :background "SlateGray4"
       :background "Gray40"
       ;; :weight bold
       ;; :underline t
       ))
  "")


;; (defun my-shr-tag-pre (dom)
;;   (let ((shr-folding-mode 'none)
;;         (shr-current-font 'my-shr-monoface))
;;     (shr-ensure-newline)
;;     (insert "my-pre-tag was inserted here QQQQ")
;;     (shr-generic dom)
;;     (shr-ensure-newline)))

(defun my-shr-tag-pre (dom)
  (let ((shr-folding-mode 'none)
        (shr-current-font 'my-shr-monoface)
        )
    (shr-ensure-newline)
    (shr-generic dom)
    (shr-ensure-newline)
    ))

(add-to-list 'shr-external-rendering-functions '(pre . my-shr-tag-pre))




(defun shr-insert (text)
  (when (and (not (bolp))
             (get-text-property (1- (point)) 'image-url))
    (insert "\n"))
  (cond
   ((eq shr-folding-mode 'none)
    (let ((start (point)))
      (insert text)
      (save-restriction
        (narrow-to-region start (point))
        (shr--translate-insertion-chars)
        (goto-char (point-max)))
      (put-text-property start (point) 'face (or shr-current-font 'variable-pitch)))) ;; Pilen inserted this line
   (t
    (let ((font-start (point)))
      (when (and (string-match "\\`[ \t\n\r]" text)
                 (not (bolp))
                 (not (eq (char-after (1- (point))) ? )))
        (insert " "))
      (let ((start (point))
            (bolp (bolp)))
        (insert text)
        (save-restriction
          (narrow-to-region start (point))
          (goto-char start)
          (when (looking-at "[ \t\n\r]+")
            (replace-match "" t t))
          (while (re-search-forward "[ \t\n\r]+" nil t)
            (replace-match " " t t))
          (shr--translate-insertion-chars)
          (goto-char (point-max)))
        ;; We may have removed everything we inserted if it was just
        ;; spaces.
        (unless (= font-start (point))
          ;; Mark all lines that should possibly be folded afterwards.
          (when bolp
            (shr-mark-fill start))
          (when shr-use-fonts
            (put-text-property font-start (point)
                               'face
                               (or shr-current-font 'variable-pitch)))))))))


;; (with-current-buffer
;;     (get-buffer-create "font")
;;   (insert "entaisretnire nstienr sietnr iesntir")
;;   (put-text-property (point-min) (point-max) 'face 'my-shr-monoface))

;; (eww "docs.python.org/3/library/re.html")
