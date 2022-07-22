;;______________________________________________________________________________
;π COMPANY
;;______________________________________________________________________________
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.5)
(setq company-idle-delay 1.0)
(setq company-show-numbers t)
(setq company-tooltip-align-annotations t)
(add-to-list 'company-frontends 'company-echo-frontend)
(company-quickhelp-mode t)
(setq company-quickhelp-delay 1)
(setq company-quickhelp-max-lines 60)

(set-face-background 'company-tooltip "DodgerBlue4")
(set-face-foreground 'company-tooltip "LightSteelBlue1")
(set-face-foreground 'company-tooltip "White")
(set-face-background 'company-tooltip-selection "DodgerBlue1")
(set-face-foreground 'company-tooltip-selection "While")

(set-face-background 'company-scrollbar-bg "DodgerBlue4")
(set-face-background 'company-scrollbar-fg "DodgerBlue3")

(set-face-foreground 'company-tooltip-annotation "DodgerBlue1")

(define-key company-active-map (kbd "H-e") 'company-select-next)
(define-key company-active-map (kbd "H-u") 'company-select-previous)
(define-key company-active-map (kbd "H-i") 'company-abort)
(define-key company-active-map (kbd "H-n") 'nil)
(define-key company-active-map (kbd "SPC") 'company-abort)
;; (dotimes (i 10)
;;   (define-key company-active-map (format "%d" i) 'company-complete-number))
(dotimes (i 10)
  (define-key company-active-map (format "%d" i) 'ora-company-number))

;;(add-to-list 'company-backends 'company-jedi)
;; (setq company-backends (delete 'company-jedi company-backends))
(add-to-list 'company-backends 'company-go)
;; (add-to-list 'company-backends 'company-dabbrev-code)
;; (add-to-list 'company-backends 'company-dabbrev)
;; (dolist (item company-backends)
;;   (print item))

;; (setq company-backends
;;       '(
;;         ;; company-dabbrev
;;         ;; company-dabbrev-code
;;         ;; company-go
;;         company-jedi
;;         company-bbdb
;;         company-eclim
;;         company-semantic
;;         company-clang
;;         company-xcode
;;         company-cmake
;;         company-capf
;;         company-files
;;         (company-dabbrev-code company-gtags company-etags company-keywords)
;;         company-oddmuse
;;         company-dabbrev
;;         ))

(setq company-transformers '(company-sort-by-occurrence))

;; https://oremacs.com/2017/12/27/company-numbers/
(defun ora-company-number ()
  "Forward to `company-complete-number'.
Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (or (cl-find-if (lambda (s) (string-match re s))
                        company-candidates)
            (> (string-to-number k)
               (length company-candidates)))
        (self-insert-command 1)
      (company-complete-number
       (if (equal k "0")
           10
         (string-to-number k))))))


(defun company-quickhelp--show ()
  "Only"
  ;; (company-quickhelp--ensure-compatibility)
  (company-quickhelp--cancel-timer)
  (let* ((selected (nth company-selection company-candidates))
         (doc (company-quickhelp--doc selected)))))
(defun company-quickhelp--show ()
  ;; (company-quickhelp--ensure-compatibility)
  (company-quickhelp--cancel-timer)
  (let* ((selected (nth company-selection company-candidates))
         (doc (company-quickhelp--doc selected))
         (ovl company-pseudo-tooltip-overlay)
         (overlay-width (* (frame-char-width)
                           (if ovl (overlay-get ovl 'company-width) 0)))
         (overlay-position (* (frame-char-width)
                              (- (if ovl (overlay-get ovl 'company-column) 1) 1)))
         (x-gtk-use-system-tooltips nil))
    (when (and ovl doc)
      (with-no-warnings
        (pos-tip-show doc (cons "LightSteelBlue1" "DodgerBlue4") (overlay-start ovl) nil 300 80 nil
                      (+ overlay-width overlay-position) 1)))))


;;______________________________________________________________________________
;π HIPPIE_EXPAND
;;______________________________________________________________________________
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-visible
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))
(defun my-hippie-expand-completions (&optional hippie-expand-function)
  "Return the full list of possible completions generated by `hippie-expand'.
    The optional argument can be generated with `make-hippie-expand-function'."
  (let ((this-command 'my-hippie-expand-completions)
        (last-command last-command)
        (buffer-modified (buffer-modified-p))
        (hippie-expand-function (or hippie-expand-function 'hippie-expand)))
    (flet ((ding)) ; avoid the (ding) when hippie-expand exhausts its options.
      (while (progn
               (funcall hippie-expand-function nil)
               (setq last-command 'my-hippie-expand-completions)
               (not (equal he-num -1)))))
    ;; Evaluating the completions modifies the buffer, however we will finish
    ;; up in the same state that we began, and (save-current-buffer) seems a
    ;; bit heavyweight in the circumstances.
    (set-buffer-modified-p buffer-modified)
    ;; Provide the options in the order in which they are normally generated.
    (delete he-search-string (reverse he-tried-table))))

(defmacro my-ido-hippie-expand-with (hippie-expand-function)
  "Generate an interactively-callable function that offers ido-based completion
    using the specified hippie-expand function."
  `(call-interactively
    (lambda (&optional selection)
      (interactive
       (let ((options (my-hippie-expand-completions ,hippie-expand-function)))
         (if options
             (list (ido-completing-read "Completions: " options nil nil (word-at-point))))))
      (if selection
          (he-substitute-string selection t)
        (message "No expansion found")))))

(defun my-ido-hippie-expand ()
  "Offer ido-based completion for the word at point."
  (interactive)
  (my-ido-hippie-expand-with 'hippie-expand))


;;______________________________________________________________________________
;π TAB COMPLETION
;;______________________________________________________________________________

(defvar my-pcomplete-show-completions-auto-single nil)
(setq my-pcomplete-show-completions-auto-single t)
(defun pcomplete-show-completions (completions)
  "This is my personal attempt to rip out the interface of pcomplete and replace it with ivy.
Instead of asynchronously creating a *Completions* buffer ivy is immediately called with all the completions.
This is a MAJOR hack, but it works."
  (when pcomplete-window-restore-timer
    (cancel-timer pcomplete-window-restore-timer)
    (setq pcomplete-window-restore-timer nil))
  (let* ((buffer (current-buffer))
         (base-size completion-base-size)
         (base-position completion-base-position)
         (choice (if (and my-pcomplete-show-completions-auto-single (consp completions) (null (cdr completions)))
                     (car completions)
                   (ivy-completing-read ">" completions)))
         ;; (choice (ido-completing-read ">" completions))
         (position (list (choose-completion-guess-base-position choice))))
    (choose-completion-string choice buffer position nil)
    ))
