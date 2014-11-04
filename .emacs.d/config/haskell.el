;;______________________________________________________________________________
;π HASKELL
;;______________________________________________________________________________
;;;; Haskell setup:
;;;; Install hoogle (used in GHCi with :hoogle and :doc):
;; cabal install hoogle
;; echo >> ~/.ghci ':def hoogle \x -> return $ ":!hoogle \"" ++ x ++ "\""'
;;echo >> ~/.ghci ':def doc \x -> return $ ":!hoogle --info \"" ++ x ++ "\""'

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; ghc-mod not installed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11
;; (add-to-list 'load-path "~/.emacs.d/plugins/ghc-mod/")
;; (autoload 'ghc-init "ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda ()
;;                                (ghc-init)
;;                                (flymake-mode)
;;                                (define-key haskell-mode-map "\C-c\C-c" '(lambda () (interactive)
;;                                                                           (ghc-flymake-toggle-command)
;;                                                                           (flymake-start-syntax-check)))))


;; (require 'hs-lint)    ;; https://gist.github.com/1241059
;; ;;(require 'haskell-ac) ;; https://gist.github.com/1241063

;; (defun my-haskell-mode-hook ()
;;   "hs-lint binding, plus autocompletion and paredit."
;;   (local-set-key "\C-cl" 'hs-lint))

;; (eval-after-load 'haskell-mode
;;   '(progn
;;      (require 'flymake)
;;      (push '("\\.l?hs\\'" flymake-haskell-init) flymake-allowed-file-name-masks)
;;      (add-hook 'haskell-mode-hook 'flymake-haskell-enable)
;;      (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)))



;; (defun flymake-haskell-init ()
;;   "When flymake triggers, generates a tempfile containing the
;;   contents of the current buffer, runs `hslint` on it, and
;;   deletes file. Put this file path (and run `chmod a+x hslint`)
;;   to enable hslint: https://gist.github.com/1241073"
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "hlint" (list local-file))))

;; (defun flymake-haskell-enable ()
;;   "Enables flymake-mode for haskell, and sets <C-c d> as command
;;   to show current error."
;;   (when (and buffer-file-name
;;              (file-writable-p
;;               (file-name-directory buffer-file-name))
;;              (file-writable-p buffer-file-name))
;;     (local-set-key (kbd "C-c d") 'flymake-display-err-menu-for-current-line)
;;     (flymake-mode t)))

;; Forces flymake to underline bad lines, instead of fully
;; highlighting them; remove this if you prefer full highlighting.
;; (custom-set-faces
;;  '(flymake-errline ((((class color)) (:underline "red"))))
;;  '(flymake-warnline ((((class color)) (:underline "yellow")))))
