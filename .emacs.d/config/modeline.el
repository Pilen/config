;;______________________________________________________________________________
;π BATTERY
;;______________________________________________________________________________
;; https://raw.githubusercontent.com/lunaryorn/fancy-battery.el/master/fancy-battery.el

(display-battery-mode t) ;; my battery seems to be dead, and battery-mode cant handle that correctly

(defun my-battery-format-advice (orig-fun &rest args)
  "Remove decimals and grouping"
  (replace-regexp-in-string "\\..\\|\\[\\|\\]" "" (apply orig-fun args)))
(advice-add 'battery-format :around 'my-battery-format-advice)

(defface battery-level-low
  '((((type x w32 mac))
     (:foreground "black" :background "red" :bold 't)))
  "Face used to display low battery level.")

(defun battery-update ()
  "Update battery status information in the mode line."
  (let* ((data (and battery-status-function (funcall battery-status-function)))
         (percentage (car (read-from-string (cdr (assq ?p data))))))
    (setq battery-mode-line-string
	  (propertize (if (and battery-mode-line-format
			       (numberp percentage)
                               (<= percentage battery-mode-line-limit))
			  (battery-format battery-mode-line-format data)
			"")
		      'face
                      (and (numberp percentage)
                           (<= percentage battery-load-critical)
                           'battery-level-low)
		      'help-echo "Battery status information")))
  (force-mode-line-update))

;;______________________________________________________________________________
;π CLOCK
;;______________________________________________________________________________

(setq display-time-day-and-date t
     display-time-24hr-format t)
(setq display-time-format 1)
(setq display-time-24hr-format t)

(defface display-time-face
  '((((type x w32 mac))
     (:foreground "honeydew1")); :inherit bold))
    (((type tty))
     (:foreground "blue")))
  "Face used to display the time in the mode line.")

(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
                    'face 'display-time-face)))
;; (setq display-time-string-forms '((propertize (concat " 13:37 ") 'face 'display-time-face)))

(display-time)

;;______________________________________________________________________________
;π MODELINE
;;______________________________________________________________________________
;; (require 'powerline)
(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)

;; https://stackoverflow.com/questions/8190277/how-do-i-display-the-total-number-of-lines-in-the-emacs-modeline
(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)


(setq which-func-modes t)
(which-func-mode 1)

;; (setq mode-line-format
;;               '("  " mode-line-modified
;;                 (list 'line-number-mode "  ")
;;                 (:eval (when line-number-mode
;;                          (let ((str "L%l"))
;;                            (when (and (not (buffer-modified-p)) my-mode-line-buffer-line-count)
;;                              (setq str (concat str "/" my-mode-line-buffer-line-count)))
;;                            str)))
;;                 "  %p"
;;                 (list 'column-number-mode "  C%c")
;;                 "  " mode-line-buffer-identification
;;                 "  " mode-line-modes))

;; (setq mode-line-format
;;       (list
;;        "("
;;        (propertize "%02l" 'face 'font-lock-type-face)
;;        ")"))

(defface window-numbering-face
  '((((type x w32 mac))
     (:foreground "chartreuse")))
  "Face used to display the time in the mode line.")

(make-face 'mode-line)
(set-face-attribute 'mode-line nil
                    :foreground "black"
                    :background "slate gray"
                    :box nil)
(make-face 'mode-line-buffer-id)
(set-face-attribute 'mode-line-buffer-id nil
                    :weight 'bold)
(make-face 'mode-line-long-line)
(set-face-attribute 'mode-line-long-line nil
                    :foreground "black"
                    :background "red")
(setq-default mode-line-buffer-identification (propertized-buffer-identification "%b "))

(setq-default mode-line-format
              '(
                "%e"
                (:eval (propertize (window-numbering-get-number-string)
                                   'face 'window-numbering-face))
                ":"
                mode-line-modified
                " "
                mode-line-buffer-identification

                mode-line-position
                (:eval (let ((length (save-excursion
                                       (end-of-line)
                                       (current-column))))
                         (when (> length fill-column)
                           (propertize (concat "" (int-to-string length)) 'face 'mode-line-long-line))))
                display-time-string
                ;;(:eval (propertize "13:37" 'face 'display-time-face)) ;; RKG-time
                battery-mode-line-string
                ;; (:eval (powerline-percent-xpm 'text nil powerline-color1)) ;; TODO make me work
                erc-modified-channels-object
                ("" which-func-format
                 #(" " 0 1
                   (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display")))
                ;; "[%m:"
                ;; minor-mode-alist
                ;; "]"
                "%m"
                ))

;;______________________________________________________________________________
;π SML-MODELINE
;;______________________________________________________________________________
(require 'sml-modeline)
(setq sml-modeline-len 16)
(scroll-bar-mode -1)

(set-face-attribute
 'sml-modeline-vis-face nil
 :foreground "red"
 :background "dark green")

(set-face-attribute
 'sml-modeline-end-face nil
 :foreground "white")

;; (defun sml-modeline-create ()
;;  (let* ((wstart (window-start))
;;         (wend (window-end))
;;         number-max number-beg number-end
;;         (sml-begin (or (car sml-modeline-borders) ""))
;;         (sml-end   (or (cdr sml-modeline-borders) ""))
;;         (inner-len (- sml-modeline-len (length sml-begin) (length sml-end)))
;;         bpad-len epad-len
;;         pos-%
;;         start end
;;         string)
;;    (if (not (or (< wend (save-restriction (widen) (point-max)))
;;                 (> wstart 1)))
;;        ""
;;      (cond
;;       ((eq sml-modeline-numbers 'percentage)
;;        (setq number-max (save-restriction (widen) (point-max)))
;;        (setq number-beg (/ (float wstart) (float number-max)))
;;        (setq number-end (/ (float wend) (float number-max)))
;;        (setq start (floor (* number-beg inner-len)))
;;        (setq end (floor (* number-end inner-len)))
;;        (setq string
;;              ;; (concat (format "%02d" (round (* number-beg 100)))
;;              ;;         "-"
;;              ;;         (format "%02d" (round (* number-end 100)))
;;              ;;         "%%"
;;              ;;         " (%l,%c) "
;;              ;;         (my-mode-line-count-lines))))
;;              (concat "%l/"
;;                      (my-mode-line-count-lines)
;;                      ":%c")))
;;       ((eq sml-modeline-numbers 'line-numbers)
;;        (save-restriction
;;          (widen)
;;          (setq number-max (line-number-at-pos (point-max)))
;;          (setq number-beg (line-number-at-pos wstart))
;;          (setq number-end (line-number-at-pos wend)))
;;        (setq start (floor (* (/ number-beg (float number-max)) inner-len)))
;;        (setq end   (floor (* (/ number-end (float number-max)) inner-len)))
;;        (setq string
;;              (concat "L"
;;                      (format "%02d" number-beg)
;;                      "-"
;;                      (format "%02d" number-end))))
;;       (t (error "Unknown sml-modeline-numbers=%S" sml-modeline-numbers)))
;;      (setq inner-len (max inner-len (length string)))
;;      (setq bpad-len (floor (/ (- inner-len (length string)) 2.0)))
;;      (setq epad-len (- inner-len (length string) bpad-len))
;;      (setq pos-% (+ bpad-len (length string) -1))
;;      (setq string (concat sml-begin
;;                           (make-string bpad-len 32)
;;                           string
;;                           (make-string epad-len 32)
;;                           sml-end))
;;      ;;(assert (= (length string) sml-modeline-len) t)
;;      (when (= start sml-modeline-len) (setq start (1- start)))
;;      (setq start (+ start (length sml-begin)))
;;      (setq end   (+ end   (length sml-begin)))
;;      (when (= start end) (setq end (1+ end)))
;;      (when (= end pos-%) (setq end (1+ end))) ;; If on % add 1
;;      (put-text-property start end 'face 'sml-modeline-vis-face string)
;;      (when (and (= 0 (length sml-begin))
;;                 (= 0 (length sml-end)))
;;        (put-text-property 0 start 'face 'sml-modeline-end-face string)
;;        (put-text-property end sml-modeline-len 'face 'sml-modeline-end-face string))
;;      string)))

(defun sml-modeline-create ()
  (let* ((wstart (window-start))
         (wend (window-end))
         number-max number-beg number-end
         (sml-begin (or (car sml-modeline-borders) ""))
         (sml-end   (or (cdr sml-modeline-borders) ""))
         (inner-len (- sml-modeline-len (length sml-begin) (length sml-end)))
         bpad-len epad-len
         pos-%
         start end
         string)

    (save-restriction
      (widen)
      (setq number-max (line-number-at-pos (point-max)))
      (setq number-beg (line-number-at-pos wstart))
      (setq number-end (line-number-at-pos wend)))
    (setq start (floor (* (/ number-beg (float number-max)) inner-len)))
    (setq end   (floor (* (/ number-end (float number-max)) inner-len)))
    (setq string
          (concat "%l/"
                  ;; my-mode-line-buffer-line-count
                  (my-mode-line-count-lines)
                  ":%c"))

    (setq inner-len (max inner-len (length string)))
    (setq bpad-len (floor (/ (- inner-len (length string)) 2.0)))
    (setq epad-len (- inner-len (length string) bpad-len))
    (setq pos-% (+ bpad-len (length string) -1))
    (setq string (concat sml-begin
                         (make-string bpad-len 32)
                         string
                         (make-string epad-len 32)
                         sml-end))
    ;;(assert (= (length string) sml-modeline-len) t)
    (when (= start sml-modeline-len) (setq start (1- start)))
    (setq start (+ start (length sml-begin)))
    (setq end   (+ end   (length sml-begin)))
    (when (= start end) (setq end (1+ end)))
    (when (= end pos-%) (setq end (1+ end))) ;; If on % add 1
    (put-text-property start end 'face 'sml-modeline-vis-face string)
    (when (and (= 0 (length sml-begin))
               (= 0 (length sml-end)))
      (put-text-property 0 start 'face 'sml-modeline-end-face string)
      (put-text-property end sml-modeline-len 'face 'sml-modeline-end-face string))
    string))

(setq-default mode-line-position '(eval (list (sml-modeline-create))))
(sml-modeline-mode 1)
