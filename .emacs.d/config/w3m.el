;;______________________________________________________________________________
;π W3M
;;______________________________________________________________________________
(when (executable-find "w3m")
  (require 'w3m-load))

;; (add-to-list 'load-path "~/builds/emacs-w3m-1.4.4")
;; (require 'w3m-e21)
;; (provide 'w3m-e23)

;; (autoload 'w3m-link-numbering-mode "w3m-lnum" nil t)
;; (add-hook 'w3m-mode-hook (lambda ()
;;                            (setq show-trailing-whitespace nil)
;;                            ;;(w3m-lnum-mode)
;;                            (w3m-link-numbering-mode)))
;; ;;(setq browse-url-browser-function 'browse-url-generic
;; ;;          browse-url-generic-program "chromium")'
;; (setq browse-url-browser-function 'w3m-browse-url)
;; ;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; ;; optional keyboard short-cut
;; ;;(global-set-key "\C-xm" 'browse-url-at-point)


;; (defvar w3m-isearch-links-do-wrap t
;;   "Used internally for fast search wrapping.")

;; (defun w3m-isearch-links (&optional regexp)
;;   (interactive "P")
;;   (let ((isearch-wrap-function
;;          #'(lambda ()
;;              (setq w3m-isearch-links-do-wrap nil)
;;              (if isearch-forward
;;                  (goto-char (window-start))
;;                (goto-char (window-end)))))
;;         (isearch-search-fun-function
;;          #'(lambda () 'w3m-isearch-links-search-fun))
;;         post-command-hook               ;inhibit link echoing
;;         do-follow-link
;;         (isearch-mode-end-hook
;;          (list  #'(lambda nil
;;                     (when (and (not isearch-mode-end-hook-quit)
;;                                (w3m-anchor))
;;                       (setq do-follow-link t))))))
;;     (setq w3m-isearch-links-do-wrap t)
;;     (isearch-mode t
;;                   regexp
;;                   ;; fast wrap
;;                   #'(lambda nil
;;                       (if isearch-success
;;                           (setq w3m-isearch-links-do-wrap t)
;;                         (when w3m-isearch-links-do-wrap
;;                           (setq w3m-isearch-links-do-wrap nil)
;;                           (setq isearch-forward
;;                                 (not isearch-forward))
;;                           (isearch-repeat isearch-forward))))
;;                   t)
;;     (when do-follow-link
;;       (w3m-view-this-url))))
;; (defun w3m-isearch-links-search-fun (string &optional bound no-error)
;;   (let* (isearch-search-fun-function
;;          (search-fun  (isearch-search-fun))
;;          error
;;          (bound  (if isearch-forward
;;                      (max (or bound 0)
;;                           (window-end))
;;                    (min (or bound (window-start))
;;                         (window-start)))))
;;     (condition-case err
;;         (while (and (apply search-fun (list string bound))
;;                     (not (w3m-anchor (point)))))
;;       (error (setq error err)))
;;     (if error
;;         (if (not no-error)
;;             (signal (car error) (cadr error)))
;;       (point))))
;; (require 'w3m)
;; (define-key w3m-mode-map [?f] 'w3m-isearch-links)
