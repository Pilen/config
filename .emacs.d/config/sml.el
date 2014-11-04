;;______________________________________________________________________________
;π SML
;;______________________________________________________________________________
;; Kig i user-init-file

;;(add-to-list 'load-path "~/.emacs.d/plugins/sml-mode-4.1/")

;; (require 'sml-mode "sml-mode-6.4")
(require 'sml-mode)
(setq auto-mode-alist (cons '("\\.sml$" . sml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sig$" . sml-mode) auto-mode-alist))
(add-hook 'sml-mode-hook
          (lambda() ;;; *** SML-mode Customization
            (define-key inferior-sml-mode-map (kbd "<return>") (lambda ()
                                                                 (interactive)
                                                                 (end-of-buffer)
                                                                 (when (not (looking-back "; *"))
                                                                   (insert ";"))
                                                                 (comint-send-input)))
            (define-key inferior-sml-mode-map (kbd "S-<return>") 'comint-send-input)
            (setq sml-program-name "mosml")
            (setq sml-default-arg "-P full")
            ;; (setq sml-default-arg "-Ccontrol.poly-eq-warn=false")
            (setq sml-indent-level 2)        ; conserve on horizontal space
            (setq words-include-escape t)    ; \ loses word break status
            (setq indent-tabs-mode nil)))    ; never ever indent with tabs

(defvar sml-current-file "")

(defun sml-compile ()
  (interactive)
  (save-buffer)
  (unless (string= sml-current-file (buffer-file-name))
    (save-window-excursion
      (setq sml-current-file (buffer-file-name))
      (sml-prog-proc-switch-to)
      (comint-send-eof)
      (sleep-for 1)))
  (call-interactively 'sml-prog-proc-load-file))
