;;______________________________________________________________________________
;π IDO-IMENU
;;______________________________________________________________________________

;;(require 'idomenu) ;; I use ido-goto-symbol instead as it merges the groups

;; (defun ido-goto-symbol (&optional symbol-list)
;;   "Refresh imenu and jump to a place in the buffer using Ido."
;;   (interactive)
;;   (unless (featurep 'imenu)
;;     (require 'imenu nil t))
;;   (cond
;;    ((not symbol-list)
;;     (let ((ido-mode ido-mode)
;;           (ido-enable-flex-matching
;;            (if (boundp 'ido-enable-flex-matching)
;;                ido-enable-flex-matching t))
;;           name-and-pos symbol-names position)
;;       (unless ido-mode
;;         (ido-mode 1)
;;         (setq ido-enable-flex-matching t))
;;       (while (progn
;;                (imenu--cleanup)
;;                (setq imenu--index-alist nil)
;;                (ido-goto-symbol (imenu--make-index-alist))
;;                (setq selected-symbol
;;                      (ido-completing-read "Symbol? " symbol-names))
;;                (string= (car imenu--rescan-item) selected-symbol)))
;;       (unless (and (boundp 'mark-active) mark-active)
;;         (push-mark nil t nil))
;;       (setq position (cdr (assoc selected-symbol name-and-pos)))
;;       (cond
;;        ((overlayp position)
;;         (goto-char (overlay-start position)))
;;        (t
;;         (goto-char position)))))
;;    ((listp symbol-list)
;;     (dolist (symbol symbol-list)
;;       (let (name position)
;;         (cond
;;          ((and (listp symbol) (imenu--subalist-p symbol))
;;           (ido-goto-symbol symbol))
;;          ((listp symbol)
;;           (setq name (car symbol))
;;           (setq position (cdr symbol)))
;;          ((stringp symbol)
;;           (setq name symbol)
;;           (setq position
;;                 (get-text-property 1 'org-imenu-marker symbol))))
;;         (unless (or (null position) (null name)
;;                     (string= (car imenu--rescan-item) name))
;;           (add-to-list 'symbol-names name)
;;           (add-to-list 'name-and-pos (cons name position))))))))

;; (defun ido-goto-symbol ()
;;   "Will update the imenu index and then use ido to select a
;;    symbol to navigate to"
;;   (interactive)
;;   (imenu--make-index-alist)
;;   (let ((name-and-pos '())
;;         (symbol-names '()))
;;     (flet ((addsymbols (symbol-list)
;;                        (when (listp symbol-list)
;;                          (dolist (symbol symbol-list)
;;                            (let ((name nil) (position nil))
;;                              (cond
;;                               ((and (listp symbol) (imenu--subalist-p symbol))
;;                                (addsymbols symbol))

;;                               ((listp symbol)
;;                                (setq name (car symbol))
;;                                (setq position (cdr symbol)))

;;                               ((stringp symbol)
;;                                (setq name symbol)
;;                                (setq position (get-text-property 1 'org-imenu-marker symbol))))

;;                              (unless (or (null position) (null name))
;;                                (add-to-list 'symbol-names name)
;;                                (add-to-list 'name-and-pos (cons name position))))))))
;;       (addsymbols imenu--index-alist))
;;     (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
;;            (position (cdr (assoc selected-symbol name-and-pos))))
;;       (goto-char position))))

(setq imenu-auto-rescan t)

(defun ido-goto-symbol-or-line ()
  "Will update the imenu index and then use ido to select a
   symbol to navigate to"
  (interactive)
  (condition-case e (progn
                      (imenu--make-index-alist)
                      (let ((name-and-pos '())
                            (symbol-names '()))
                        (flet ((addsymbols (symbol-list)
                                           (when (listp symbol-list)
                                             (dolist (symbol symbol-list)
                                               (let ((name nil) (position nil))
                                                 (cond
                                                  ((and (listp symbol) (imenu--subalist-p symbol))
                                                   (addsymbols symbol))

                                                  ((listp symbol)
                                                   (setq name (car symbol))
                                                   (setq position (cdr symbol)))

                                                  ((stringp symbol)
                                                   (setq name symbol)
                                                   (setq position (get-text-property 1 'org-imenu-marker symbol))))

                                                 (unless (or (null position) (null name))
                                                   (add-to-list 'symbol-names name)
                                                   (add-to-list 'name-and-pos (cons name position))))))))
                          (addsymbols (reverse imenu--index-alist)))
                        (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
                               (position (cdr (assoc selected-symbol name-and-pos))))
                          (push-mark)
                          (cond ((overlayp position)
                                 (goto-char (overlay-start position)))

                                ((string-integer-p selected-symbol)
                                 (goto-line (string-to-number selected-symbol)))

                                (t
                                 (goto-char position))))))
    (error (call-interactively 'goto-line))))


(defun string-integer-p (string)
   (if (string-match "\\`[-+]?[0-9]+\\'" string)
       t
     nil))



;; (defun .emacs-imenu-create-index ()
;;   (interactive)
;;   (goto-char (point-max))
;;   (let ((index-alist '())
;;         (name nil)
;;         (pos nil))
;;     (while (search-backward-regexp ";π[ ]*" nil t)
;;       (search-forward-regexp ";π[ ]*\\([a-zA-Z-]+\\)")
;;       (setq name (match-string 1))
;;       ;(setq pos (match-beginning 0))
;;       (goto-char (match-beginning 0))
;;       (push (cons name (if imenu-use-markers (point-marker) (point)))
;;             index-alist))
;;       index-alist))

;; (setq imenu-create-index-function '.emacs-imenu-create-index)
;; (setq imenu--index-alist nil)




;;______________________________________________________________________________
;π COUNSEL-IMENU
;;______________________________________________________________________________
;; Expanded from from counsel.el

;;** `counsel-imenu'
(defvar imenu-auto-rescan)
(defvar imenu-auto-rescan-maxout)
(declare-function imenu--subalist-p "imenu")
(declare-function imenu--make-index-alist "imenu")

(defun counsel-imenu-get-candidates-from (alist &optional prefix)
  "Create a list of (key . value) from ALIST.
PREFIX is used to create the key."
  (cl-mapcan (lambda (elm)
               (if (imenu--subalist-p elm)
                   (counsel-imenu-get-candidates-from
                    (cl-loop for (e . v) in (cdr elm) collect
                         (cons e (if (integerp v) (copy-marker v) v)))
                    ;; pass the prefix to next recursive call
                    (concat prefix (if prefix ".") (car elm)))
                 (let ((key (concat
                             (when prefix
                               (concat
                                (propertize prefix 'face 'compilation-info)
                                ": "))
                             (car elm))))
                   (list (cons key
                               ;; create a imenu candidate here
                               (cons key (if (overlayp (cdr elm))
                                             (overlay-start (cdr elm))
                                           (cdr elm))))))))
             alist))

(defvar counsel-imenu-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-l") 'ivy-call-and-recenter)
    map))

;;;###autoload
(defun my-counsel-imenu (&optional initial-input)
  "Jump to a buffer position indexed by imenu."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (let* ((imenu-auto-rescan t)
         (imenu-auto-rescan-maxout (if current-prefix-arg
                                       (buffer-size)
                                     imenu-auto-rescan-maxout))
         (items (ignore-errors (imenu--make-index-alist t))))

    (if (null items)
        (call-interactively 'goto-line)
      (setq items (delete (assoc "*Rescan*" items) items))
      (ivy-read "imenu items: " (counsel-imenu-get-candidates-from items)
                :preselect (thing-at-point 'symbol)
                :initial-input initial-input
                :require-match nil
                :action (lambda (candidate)
                          (if (stringp candidate)
                              (let ((numeric (cl-parse-integer candidate :junk-allowed t)))
                                (if numeric
                                    (goto-line numeric)
                                  (beginning-of-buffer)
                                  (swiper candidate)))
                            (with-ivy-window
                              ;; In org-mode, (imenu candidate) will expand child node
                              ;; after jump to the candidate position
                              (imenu (cdr candidate)))))
                :keymap counsel-imenu-map
                :caller 'counsel-imenu))))

(ivy-configure 'counsel-imenu :update-fn 'auto)

(require 'imenu-list)
(setq imenu-list-position 'right) ;; If left it will compete with neotree about being first
(setq imenu-list-size 30)
(setq imenu-list-mode-line-format '(" %e" (:eval (buffer-name imenu-list--displayed-buffer))))
(setq imenu-list-persist-when-imenu-index-unavailable t)
(setq org-imenu-depth 10)

(defun imenu-list--depth-string (depth)
  "Return a prefix string representing an entry's DEPTH."
  (let ((indents (cl-loop for i from 1 to depth collect " "))) ;; One space
    (format "%s%s"
            (mapconcat #'identity indents "")
            (if indents " " ""))))

(add-hook 'imenu-list-major-mode-hook #'my-imenu-list-hide-linum)
(defun my-imenu-list-hide-linum ()
  (message "hej %s %s" (boundp 'linum-mode) linum-mode)
  (linum-mode -1)
  ;; (when (and (boundp 'linum-mode)
  ;;            (not (null linum-mode)))
  ;;   (message "disable")
  ;;   (linum-mode -1))
  )


(defun my-imenu-list-toggle-width ()
  (interactive)
  (setq imenu-list-size
        (case imenu-list-size
          (30 45)
          (t 30)))
  (message "%s" imenu-list-size))
(define-key imenu-list-major-mode-map (kbd "w") #'my-imenu-list-toggle-width)

(defun my-imenu-list ()
  (interactive)
  (message "%s" (or (buffer-file-name) "Not a file"))
  (if (eq major-mode 'imenu-list-major-mode)
      (imenu-list-minor-mode -1)
    (imenu-list-minor-mode 1)
    (imenu-list-show)
    ;; (imenu-list)
    ))

;; (defun my-imenu-list ()
;;   (interactive)
;;   (imenu-list-smart-toggle)
;;   (message "%s" (or (buffer-file-name) "Not a file")))


(set-face-attribute 'imenu-list-entry-face-0 nil :foreground "DarkSlateGray1")
(set-face-attribute 'imenu-list-entry-face-1 nil :foreground "DarkSlateGray2")
(set-face-attribute 'imenu-list-entry-face-2 nil :foreground "DarkSlateGray3")
(set-face-attribute 'imenu-list-entry-face-3 nil :foreground "DarkSlateGray4")

(set-face-attribute 'imenu-list-entry-face-0 nil :foreground "DarkSlateGray1")
(set-face-attribute 'imenu-list-entry-face-1 nil :foreground "Aquamarine1")
(set-face-attribute 'imenu-list-entry-face-2 nil :foreground "SeaGreen1")
(set-face-attribute 'imenu-list-entry-face-3 nil :foreground "DarkOliveGreen1")
(set-face-attribute 'imenu-list-entry-subalist-face-0 nil :weight 'unspecified)
(set-face-attribute 'imenu-list-entry-subalist-face-1 nil :weight 'unspecified)
(set-face-attribute 'imenu-list-entry-subalist-face-2 nil :weight 'unspecified)
(set-face-attribute 'imenu-list-entry-subalist-face-3 nil :weight 'unspecified)


;; ;; https://github.com/dsedivec/dot-emacs-d/blob/ddc3fec6a2a884ce4adf730a2eb255dab97834b7/recipes/imenu-list-in-side-buffer.el
;; (defun my:imenu-list-install-display-buffer ()
;;   "Put imenu-list buffer on a dedicated side window with a preserved size."
;;   (let* ((side (cl-ecase imenu-list-position
;;                  (above 'top)
;;                  (below 'bottom)
;;                  ((left right) imenu-list-position)))
;;          (preserve-dimen (if (memq side '(left right))
;;                              'window-width
;;                            'window-height)))
;;     (setf (alist-get (concat "^" (regexp-quote imenu-list-buffer-name) "$")
;;                      display-buffer-alist nil nil #'equal)
;;           `(display-buffer-in-side-window
;;             (side . ,side)
;;             ;; It is not totally clear to me if `imenu-list-size' is
;;             ;; supposed to be the window's body height/width or the
;;             ;; window's total height/width.  The way we're using it
;;             ;; here it is definitely the total, not the body.
;;             ;;
;;             ;; If it's supposed to be the body height/width then I
;;             ;; think it might be best to pass a function as the value
;;             ;; for the `window-height'/`window-width' here, and then
;;             ;; have the function compute it once the imenu-list window
;;             ;; has come into existence.  (See documentation for those
;;             ;; alist entries in the docstring for `display-buffer'.)
;;             (,preserve-dimen . ,imenu-list-size)
;;             (preserve-size . ,(if (eq preserve-dimen 'window-width)
;;                                   '(t . nil)
;;                                 '(nil . t)))
;;             (dedicated . t)))))
;; (advice-add 'imenu-list-install-display-buffer :override
;;             #'my:imenu-list-install-display-buffer)
;; (when (featurep 'imenu-list)
;;   ;; Too late, imenu-list already loaded.  Call our new setup function.
;;   (my:imenu-list-install-display-buffer))
