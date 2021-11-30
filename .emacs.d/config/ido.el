;;______________________________________________________________________________
;π IDO
;;______________________________________________________________________________
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-file-extension-order '("/" ".tex" ".emacs" ".txt" ".py" ".pl" ".c" ".h" ".hs" ".cfg" ".asm" ".xml" ".org"))
(setq ido-default-buffer-method 'selected-window)
(setq ido-case-fold t)
(setq ido-auto-merge-work-directories-length -1)
;; (setq ido-use-virtual-buffers t) :; Not used, rather slow
(setq ido-completion-buffer nil)
(ido-mode 1)

(set-face-attribute
 'ido-only-match nil
 :foreground "lime green")

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;default
;(setq ido-decorations (quote ("{" "}" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;(remove-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

(add-hook 'ido-setup-hook 'ido-my-keys)

(add-hook 'ido-setup-hook
          (lambda ()
            ;; Go straight home
            (define-key ido-file-completion-map
              (kbd "~")
              (lambda ()
                (interactive)
                (if (looking-back "/")
                    (insert "~/")
                  (call-interactively 'self-insert-command))))))

(defun ido-my-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map (kbd "H-e") 'ido-next-match)
  (define-key ido-completion-map (kbd "H-u") 'ido-prev-match)
  (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
  (define-key ido-completion-map (kbd "<up>") 'ido-prev-match))


;; use ido to complete commands via M-X
(defun ido-M-X ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (all-completions "" obarray 'commandp)))))

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)

  (let ((ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))))
;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

    (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file)))))

;(load-file "~/.emacs.d/plugins/ido-better-flex-0.0.2.el")
;(ido-better-flex/enable)

; sort ido filelist by mtime instead of alphabetically
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime);'(lambda () (ido-sort-mtime) (ido-better-flex/enable)))
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime);'(lambda () (ido-sort-mtime) (ido-better-flex/enable)))
;(add-hook 'ido-make-buffer-list-hook '(lambda () (ido-better-flex/enable)))

;; (defun ido-sort-mtime ()
;;   (setq ido-temp-list
;;         (sort ido-temp-list
;;               (lambda (a b)
;;                 (time-less-p
;;                  (sixth (file-attributes (concat ido-current-directory b)))
;;                  (sixth (file-attributes (concat ido-current-directory a)))))))
;;   (ido-to-end  ;; move . files to end (again)
;;    (delq nil (mapcar
;;               (lambda (x) (and (char-equal (string-to-char x) ?.) x))
;;               ido-temp-list))))

(defun ido-sort-mtime ()
  (setq ido-temp-list
        (sort ido-temp-list
              (lambda (a b)
                (let ((a-tramp-file-p (string-match-p ":\\'" a))
                      (b-tramp-file-p (string-match-p ":\\'" b)))
                  (cond
                   ((and a-tramp-file-p b-tramp-file-p)
                    (string< a b))
                   (a-tramp-file-p nil)
                   (b-tramp-file-p t)
                   (t (if (or (null (file-attributes (concat ido-current-directory b)))
                              (null (file-attributes (concat ido-current-directory a))))
                          nil
                      (time-less-p
                       (sixth (file-attributes (concat ido-current-directory b)))
                       (sixth (file-attributes (concat ido-current-directory a)))))))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
              (lambda (x) (and (char-equal (string-to-char x) ?.) x))
              ido-temp-list))))

(defun my-find-file-in-selected-window ()
  "https://emacs.stackexchange.com/questions/9447/pick-a-window-for-ido-find-file-other-window-and-ido-switch-buffer-other-window"
  (interactive)
  (if (not (window-parent))
      (ido-find-file-other-window)
    (let* ((start-window (selected-window))
           (buffer (find-file-noselect (ido-read-file-name "File: ")))
           (aw-scope 'visible)
           (window (aw-select " window: ")))
      (unwind-protect
          (progn
            (aw-switch-to-window window)
            (switch-to-buffer buffer))
        (aw-switch-to-window start-window)))))
