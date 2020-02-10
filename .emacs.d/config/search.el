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
