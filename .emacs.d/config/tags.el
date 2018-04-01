;;______________________________________________________________________________
                                        ;π TAGS
;;______________________________________________________________________________

;; ;; etags system:
;; (defun create-tags (dir-name)
;;   "Create tags file."
;;   (interactive "DDirectory: ")
;;   (eshell-command
;;    (format "find %s -type f -name \"*.[ch]\" | etags -L -" dir-name)))


;; ;;;  Jonas.Jarnestrom<at>ki.ericsson.se A smarter
;; ;;;  find-tag that automagically reruns etags when it cant find a
;; ;;;  requested item and then makes a new try to locate it.
;; ;;;  Fri Mar 15 09:52:14 2002
;; (defadvice find-tag (around refresh-etags activate)
;;   "Rerun etags and reload tags if tag not found and redo find-tag.
;;    If buffer is modified, ask about save before running etags."
;;   (let ((extension (file-name-extension (buffer-file-name))))
;;     (condition-case err
;;         ad-do-it
;;       (error (and (buffer-modified-p)
;;                   (not (ding))
;;                   (y-or-n-p "Buffer is modified, save it? ")
;;                   (save-buffer))
;;              (er-refresh-etags extension)
;;              ad-do-it))))
;; (defun er-refresh-etags (&optional extension)
;;   "Run etags on all peer files in current dir and reload them silently."
;;   (interactive)
;;   (shell-command (format "etags *.%s" (or extension "el")))
;;   (let ((tags-revert-without-query t))  ; don't query, revert silently
;;     (visit-tags-table default-directory nil)))

;; GNU Global - Gtags:
(add-to-list 'load-path "/usr/share/emacs/site-lisp/global")
(require 'gtags)
(defun gtags-create-or-update ()
  "create or update the gnu global tag file"
  (interactive)
  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
      (let ((olddir default-directory)
            (topdir (read-directory-name
                     "gtags: top of source tree:" default-directory)))
        (cd topdir)
        (shell-command "gtags && echo 'created tagfile'")
        (cd olddir)) ; restore
    ;;  tagfile already exists; update it
    (shell-command "global -u && echo 'updated tagfile'")))

(add-hook 'gtags-mode-hook
          (lambda ()
            ;; (local-set-key (kbd "H-λ") 'gtags-find-tag)
            ;; (local-set-key (kbd "H-=") 'gtags-pop-stack)
            ;; (local-set-key (kbd "H-π") 'gtags-find-rtag)))
            (define-key gtags-mode-map (kbd "H-λ") 'gtags-find-tag-other-window)
            (define-key gtags-mode-map (kbd "H-=") 'gtags-pop-stack)
            (define-key gtags-mode-map (kbd "H-π") 'gtags-find-rtag)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (gtags-mode)))

(setq tags-revert-without-query t)

(require 'ivy-xref) ; unless installed from a package
;; (setq xref-show-xrefs-function 'xref--show-xref-buffer)
(setq xref-show-xrefs-function 'ivy-xref-show-xrefs)


;; So GNU Global supplies gtags.el (in /usr/share/gtags)
;; ggtags is an external mode build on top of GNU Global providing an alternative interface
;; look into ggtags




(defun my-xref--read-identifier (prompt)
  "Return the identifier at point or read it from the minibuffer."
  (let* ((backend (xref-find-backend))
         (id (xref-backend-identifier-at-point backend))
         (actual-prompt (if id
                            (format "%s (default %s): "
                                    (substring prompt 0 (string-match "[ :]+\\'" prompt))
                                    id)
                          prompt))
         (ivy-re-builders-alist '((t . ivy--regex-fuzzy))))
    (ivy-completing-read prompt
                     (xref-backend-identifier-completion-table backend)
                     nil nil nil
                     'xref--read-identifier-history id)))
(defun my-xref-find-definitions-other-window (identifier)
  "Like `xref-find-definitions' but switch to the other window."
  (interactive (list (my-xref--read-identifier "Find definitions of: ")))
  (xref--find-definitions identifier 'window))
