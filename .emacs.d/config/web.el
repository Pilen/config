(require 'web-mode)
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; (setq web-mode-enable-element-tag-fontification nil)

(defun my-web-close-tag ()
  (interactive)
  (unless (member (web-mode-element-tag-name (web-mode-element-parent-position))
                  web-mode-void-elements)
    (if (looking-at ">")
        (forward-char)
      (insert ">")
      (web-mode-element-close))))

;; from web-mode.el web-mode-on-post-command:
;; (and (not (eobp))
;;      (eq (char-after) ?\<)
;;      (eq (get-text-property (point) 'tag-type) 'end)
;;      (looking-back ">\n[ \t]*" (point-min))
;;      (setq n (length (match-string-no-properties 0)))
;;      (eq (get-text-property (- (point) n) 'tag-type) 'start)
;;      (string= (get-text-property (- (point) n) 'tag-name)
;;               (get-text-property (point) 'tag-name))
;;      )
(defun my-web-mode-on-post-command ()
  (when (and
         (member this-command '(newline electric-newline-and-maybe-indent newline-and-indent))
         (not (eobp))
         (eq (char-after) ?\<)
         (looking-back ">\n[ \t]*" (point-min))
         )
    (newline-and-indent)
    (forward-line -1)
    (indent-according-to-mode)))
(defun my-html-mode-hook ()
  (add-hook 'post-command-hook 'my-web-mode-on-post-command nil t))
(add-hook 'html-mode-hook 'my-html-mode-hook)

(add-hook 'js2-mode-hook 'electric-pair-local-mode)
(add-to-list 'wrap-region-except-modes 'web-mode)
(add-to-list 'wrap-region-except-modes 'html-mode)
(defun my-web-insert-quote ()
  (interactive)
  (unless (looking-back "\"")
    (if (looking-at "\"")
        (forward-char)
      (insert "\""))))

(defun my-html-close-tag ()
  (interactive)
  (insert ">")
  (sgml-close-tag))

(defun my-html-close-tag ()
  (interactive)
  (if (looking-at ">")
      (forward-char)
    (insert ">")
    (save-excursion
      ;; (let ((tag (elt (save-excursion (sgml-parse-tag-backward)) 4)))
      (let ((tag (sgml-tag-name (save-excursion (sgml-parse-tag-backward)))))
        (if (not (or (member tag sgml-empty-tags)
                     (member tag web-mode-void-elements)))
            (progn
              (sgml-close-tag)
              (message "fisk"))
          (backward-char 2)
          (unless (looking-at "/")
            (forward-char)
            (insert "/"))
          )))))
(define-key web-mode-map (kbd ">") 'my-web-close-tag)
(define-key web-mode-map (kbd "\"") 'my-web-insert-quote)
(define-key html-mode-map (kbd ">") 'my-html-close-tag)
(define-key html-mode-map (kbd "\"") 'my-web-insert-quote)


(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(defun httpd-serve-current-directory (&optional directory)
  (interactive)
  (httpd-serve-directory (or directory
                             (file-name-directory (buffer-file-name)))))

(defun my-web-save-and-reload ()
  (interactive)
  (save-buffer)
  (skewer-eval "location.reload()"))
(define-key js2-mode-map (kbd "C-x C-s") 'my-web-save-and-reload)


(defun my-html-forward-slurp-word ()
  (interactive)
  (let ((insert-point (point))
        after-tag
        )
    (unless (looking-at "</[^>]+>")
      (error "Not at a place to slurp"))
    (goto-char (match-end 0))
    (setq after-tag (point))
    (forward-word)
    (kill-region after-tag (point))
    (goto-char insert-point)
    (yank)
    )
  )
(define-key html-mode-map (kbd "H-3") 'my-html-forward-slurp-word)

(defhydra my-html-hydra
  (:exit t)
  "html functions"
  )
;; Modes installed and their uses
;; simple-httpd (httpd-start httpd-serve-directory)
;;   A simple webserver build into Emacs for serving files
;; Skewer
;;   Open a websocket with the browser, allows sending and evaluation of javascript code.
;;   uses simple-httpd, but also sets up an endpoint at localhost:8080/skewer/demo
;; livid-mode
;;   Auto eval buffer with skewer when edited
;; impatient-mode
;;   Uses simple-httpd to serve the current buffer (NOT FILE) under localhost:8080/imp/
;;   Autoupdates on changes
;; kite
;;   interface for the webkit remote-debugger
;;   Hangs when I try to do anything
;; jss
;;   interface for the webkit remote-debugger
;;
;;
;; Other interesting modes
;; tern
;;   Tern is a stand-alone code-analysis engine for JavaScript. http://ternjs.net/
;; jade
;;
