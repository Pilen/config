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
            (local-set-key (kbd "H-λ") 'gtags-find-tag)
            (local-set-key (kbd "H-=") 'gtags-pop-stack)
            (local-set-key (kbd "H-π") 'gtags-find-rtag)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (gtags-mode)))
