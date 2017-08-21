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
