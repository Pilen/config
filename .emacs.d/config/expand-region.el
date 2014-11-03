;;______________________________________________________________________________
;π EXPAND-REGION
;;______________________________________________________________________________
(add-to-list 'load-path "~/.emacs.d/plugins/expand-region/")
;; (load-file "~/.emacs.d/plugins/expand-region/expand-region.el")
(require 'expand-region)

;; (defun er/add-text-mode-expansions ()
;;   (set (make-local-variable 'er/try-expand-list)
;;        (append
;;         er/try-expand-list
;;         '(mark-paragraph
;;           mark-page))))

;; (add-hook 'text-mode-hook 'er/add-text-mode-expansions)
(defun er/add-text-mode-expansions ()
  (make-variable-buffer-local 'er/try-expand-list)
  (setq er/try-expand-list (append
                            er/try-expand-list
                            '(mark-paragraph
                              mark-page))))

(er/enable-mode-expansions 'text-mode 'er/add-text-mode-expansions)

;; (setq er/try-expand-list
;;       (append er/try-expand-list
;;               '(mark-paragraph
;;                 mark-page)))

(require 'smart-forward)
