;;______________________________________________________________________________
;π AUTO-HIGHLIGHT-SYMBOL
;;______________________________________________________________________________
(require 'auto-highlight-symbol)
(ahs-set-idle-interval 0.2)
(setq ahs-default-range 'ahs-range-whole-buffer)

(setq auto-highlight-symbol-mode-map nil)
(set-face-background 'ahs-plugin-defalt-face "olive drab")
(set-face-foreground 'ahs-plugin-defalt-face nil)

(set-face-background 'ahs-face "grey40")
(set-face-foreground 'ahs-face nil)

;; (set-face-background 'ahs-plugin-whole-buffer-face "olive drab")
;; (set-face-foreground 'ahs-plugin-whole-buffer-face nil)
(set-face-background 'ahs-plugin-whole-buffer-face (face-background 'default))
(set-face-background 'ahs-plugin-whole-buffer-face "SteelBlue4")
(set-face-foreground 'ahs-plugin-whole-buffer-face nil)

(setq my-ahs-ignored-modes '(ag-mode grep-mode))
(defun ahs-mode-maybe ()
  "Fire up `auto-highlight-symbol-mode' if major-mode in ahs-modes."
  (when (and (not (minibufferp (current-buffer)))
             (not (string-prefix-p "*" (buffer-name)))
             (not (memq major-mode my-ahs-ignored-modes))
             )
    (auto-highlight-symbol-mode t)))

(global-auto-highlight-symbol-mode 1)


;; Hack to make ahs work with emacs 25.1, simply ignore all errors
(defun my-ignore-errors-in-func (orig-fun &rest args)
  (ignore-errors
    (apply orig-fun args)))
(advice-add 'ahs-fontify :around 'my-ignore-errors-in-func)

;; Delete all ahs overlays in buffer
(defun my-ahs-clear-overlays ()
  (interactive)
  (dolist (overlay (overlays-in (point-min) (point-max)))
    (let ((face (overlay-get overlay 'face)))
      (when (or (eq face 'ahs-face)
                (eq face 'ahs-plugin-whole-buffer-face)
                (eq face 'ahs-definition-face))
        (delete-overlay overlay)))))

(add-hook 'ag-search-finished-hook 'my-ahs-clear-overlays)


;; Looks like auto-highlight-symbol-mode is inconsistent of its use of variables
(setq ahs-default-symbol-regexp "^[0-9A-Za-zæøåÆØÅ/_.,:;*+=&%|$#@!^?-]+$")
(setq ahs-include ahs-default-symbol-regexp)
