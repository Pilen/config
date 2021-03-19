;;______________________________________________________________________________
;π ISEARCH
;;______________________________________________________________________________
(defun sdacha/isearch-yank-current-word ()
  "Pull current word from buffer into search string."
  (interactive)
  (save-excursion
    (skip-syntax-backward "w_")
    (isearch-yank-internal
     (lambda ()
       (skip-syntax-forward "w_")
       (point)))))

(define-key isearch-mode-map (kbd "C-x") 'sacha/isearch-yank-current-word)
(define-key isearch-mode-map (kbd "H-u") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "H-e") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "H-m") 'isearch-edit-string)
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(define-key isearch-mode-map (kbd "H-v") (lambda () (interactive) (isearch-yank-string (buffer-substring (region-beginning) (region-end)))))
(define-key isearch-mode-map (kbd "H-n") (lambda () (interactive) (isearch-done) ;; (push-mark)
                                           (goto-char isearch-other-end)))

(defun isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string
             (regexp-quote isearch-string))))
  (let ((current-pos (format "%d:" (count-lines 1 (point)))))
    (other-window 1)
    (search-forward current-pos)))

(define-key isearch-mode-map (kbd "H-m") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "H-M") 'isearch-repeat-backward)
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

;;______________________________________________________________________________
;π Replace
;;______________________________________________________________________________
(define-key query-replace-map (kbd "p") 'backup)
(define-key query-replace-map (kbd "u") 'backup)
;; (define-key query-replace-map (kbd "e") 'skip)
(define-key query-replace-map (kbd "H-u") 'backup)
(define-key query-replace-map (kbd "H-e") 'skip)
(define-key query-replace-map (kbd "e") 'edit-replacement) ;; default

;;______________________________________________________________________________
;π IEDIT
;;______________________________________________________________________________
(require 'iedit)


;;______________________________________________________________________________
;π OCCUR
;;______________________________________________________________________________

(defvar occur-history nil)

(defun occur-read-primary-args ()
  (list (if (region-active-p)
            (buffer-substring-no-properties (region-beginning) (region-end))
          (read-regexp "Occur" (symbol-name (symbol-at-point)) 'occur-history))))

(defun occur-show-function ()
  (interactive)
  (save-selected-window
    (occur-mode-goto-occurrence)
    (let* ((to-show (point))
           ;; (show-line (string-to-number (format-mode-line "%l"))
           (defun (progn (beginning-of-defun) (point)))
           ;; (defun-line (string-to-number (format-mode-line "%l")))
           ;; (block-size (- show-line defun-line))
           )
      (recenter-top-bottom 'top)
      (goto-char to-show))))
(define-key occur-mode-map (kbd "f") 'occur-show-function)

(add-hook 'occur-hook
          '(lambda () (switch-to-buffer-other-window "*Occur*")))
;;______________________________________________________________________________
;π LOCCUR
;;______________________________________________________________________________

(require 'loccur)

(face-spec-reset-face 'iedit-occurrence)
(face-spec-reset-face 'loccur-face)
(set-face-background 'loccur-face "Gray10")
(set-face-foreground 'loccur-face "Gray80")

(defadvice loccur (after loccur-iedit activate)
  (if loccur-mode
      (progn
        (when iedit-mode ;; Already running iedit, turn it off
          (iedit-done))
        (iedit-mode))
    (iedit-done)))

(define-key loccur-mode-map (kbd "TAB") (lambda () (interactive) (loccur nil) (occur loccur-last-match)))

;;______________________________________________________________________________
;π SWIPER
;;______________________________________________________________________________

(require 'swiper)
(define-key ivy-minibuffer-map (kbd "H-e") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "H-u") 'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "C-SPC") 'ivy-restrict-to-matches)
(define-key ivy-minibuffer-map (kbd "H-g") 'ivy-done)

(setq ivy-wrap t)
(setq ivy-count-format "%d/%d ")
(define-key ivy-minibuffer-map (kbd "H-i") 'my-ivy-hook)
(defun my-ivy-hook (&optional a b)
  (interactive)
  (ivy-next-line)
  ;; (ivy-previous-line)
  )
(define-key swiper-map (kbd "H-i") 'ivy-done)
(define-key swiper-map (kbd "H-n") 'ivy-done)
(define-key swiper-map (kbd "H-q") 'swiper-mc)

(setq swiper-stay-on-quit t)

(setq ivy-height 13)

;; This is pretty much a hack, I use the fact that swiper actually moves point
;; It does mean that there are certain features that are "ignored" such as
;;   saving to swiper-history, though I dont really use that.
;;   swiper--current-window-start is not set to nil
;;   reveal mode is ignored. I dont use that
;; I could add an advice to reset swiper--current-window-start
;; (define-key swiper-map (kbd "<return>") 'minibuffer-keyboard-quit)
;; No wait, iw want to redefine swiper--ivy that way i can make sure a mark is pushed
(defun swiper--ivy (candidates &optional initial-input)
  "Select one of CANDIDATES and move there.
When non-nil, INITIAL-INPUT is the initial search pattern."
  (swiper--init)
  (setq swiper-invocation-face
        (plist-get (text-properties-at (point)) 'face))
  (let ((preselect
         (if (or swiper-use-visual-line (null search-invisible))
             (count-screen-lines
              (point-min)
              (save-excursion (beginning-of-visual-line) (point)))
           (1- (line-number-at-pos))))
        (minibuffer-allow-text-properties t)
        res)
    (unwind-protect
         (and
          (setq res
                (ivy-read
                 "Swiper: "
                 candidates
                 :initial-input initial-input
                 :keymap swiper-map
                 :preselect
                 (if initial-input
                     (cl-position-if
                      (lambda (x)
                        (= (1+ preselect) (get-text-property 0 'swiper-line-number x)))
                      (progn
                        (setq ivy--old-re nil)
                        (ivy--filter initial-input candidates)))
                   preselect)
                 :require-match nil ;; Pilen changed this
                 :update-fn #'swiper--update-input-ivy
                 :unwind #'swiper--cleanup
                 :action #'my-swiper--action ;; Pilen changed this
                 :re-builder #'swiper--re-builder
                 :history 'swiper-history
                 :caller 'swiper))
          (point))
      (unless (or res swiper-stay-on-quit)
        (goto-char swiper--opoint))
      (unless (or res (string= ivy-text ""))
        (cl-pushnew ivy-text swiper-history))
      (setq swiper--current-window-start nil)
      (when swiper--reveal-mode
        (reveal-mode 1)))))


(defun my-swiper--action (x)
  (if (get-text-property 0 'swiper-line-number x)
      (swiper--action x)
    (when (/= (point) swiper--opoint)
      (unless (and transient-mark-mode mark-active)
        (push-mark swiper--opoint t)))))
