;;______________________________________________________________________________
                                        ;π AUTO-HIGHLIGHT-SYMBOL
;;______________________________________________________________________________
(require 'auto-highlight-symbol)
(ahs-set-idle-interval 0.2)
(setq ahs-default-range 'ahs-range-whole-buffer)

(setq auto-highlight-symbol-mode-map nil)
(set-face-background ahs-plugin-defalt-face "olive drab")
(set-face-foreground ahs-plugin-defalt-face nil)

(set-face-background ahs-face "grey40")
(set-face-foreground ahs-face nil)

;; (set-face-background ahs-plugin-whole-buffer-face "olive drab")
;; (set-face-foreground ahs-plugin-whole-buffer-face nil)
(set-face-background ahs-plugin-whole-buffer-face (face-background 'default))
(set-face-foreground ahs-plugin-whole-buffer-face nil)

(defun ahs-mode-maybe ()
  "Fire up `auto-highlight-symbol-mode' if major-mode in ahs-modes."
  (when (not (minibufferp (current-buffer)))
    (auto-highlight-symbol-mode t)))

(global-auto-highlight-symbol-mode 1)


;; Hack to make ahs work with emacs 25.1, simply ignore all errors
(defun ahs-fontify ()
  "Fontify symbols for strict check."
  ;;;;
  ;;
  ;; (@* "Note" )
  ;;
  ;;  If symbol has no text properties, will be called `jit-lock-fontify-now'
  ;; to strict check.
  ;;
  ;; Some old PCs performance may be degraded when:
  ;;  * Editing large file.
  ;;  * So many matched symbols exists outside the display area.
  ;;
  ;; Tested on my old pentium4 pc (bought in 2002 xD)
  ;;  So dirty `font-lock-keywords' and use `whole buffer' plugin.
  ;; Result:
  ;;  +---------------+-----------+----------------+----------+
  ;;  | filename      | filesize  | matched symbol | result   |
  ;;  +---------------+-----------+----------------+----------+
  ;;  | `loaddefs.el' | 1,207,715 | `autoload'     | so slow  |
  ;;  | `org.el'      |   753,991 | `if'           | slow     |
  ;;  +---------------+-----------+----------------+----------+
  ;;
  ;; If you feel slow, please use `display area' plugin instead of `whole buffer' plugin.
  ;; And use `ahs-onekey-edit' to use `whole buffer' plugin.
  ;;
  (ignore-errors
    (loop with beg = nil
          with end = nil

          for symbol in ahs-search-work
          for fontified = (or (nth 2 symbol)
                              (nth 3 symbol))

          unless (or beg fontified) do (setq beg (nth 0 symbol))
          unless fontified          do (setq end (nth 1 symbol))

          when (and beg end fontified)
          do (progn
               (jit-lock-fontify-now beg end)
               (setq beg nil
                     end nil))

          finally
          do (when (and beg end)
               (jit-lock-fontify-now beg end)))))
