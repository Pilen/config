;;______________________________________________________________________________
;π IBUFFER
;;______________________________________________________________________________
(require 'ibuffer)

(setq ibuffer-default-sorting-mode 'filename/process)

;; From emacs-fu
(setq ibuffer-saved-filter-groups
      (quote (("default"

               ("Revy"
                (or (mode . revy-ubersicht-mode)
                    (mode . revy-ubertex-mode)))

               ("OSM"
                (or
                 (filename . "~/Dropbox/diku/osm/")
                 (filename . "~/Dropbox/diku/osm2/")))
               ("C"
                (mode . c-mode))
               ("C++"
                (mode . c++-mode))
               ("Go"
                (mode . go-mode))
               ("Python"
                (mode . python-mode))
               ("Java"
                (mode . java-mode))
               ("Haskell"
                (mode . haskell-mode))
               ("SML"
                (mode . sml-mode))
               ("Erlang"
                (mode . erlang-mode))
               ("Java"
                (mode . jde-mode))
               ("Web"
                (or
                 (mode . html-mode)
                 (mode . css-mode)))
               ("Javascript"
                (or
                 (mode . js-mode)
                 (mode . javascript-mode) ;; alias for js-mode
                 (mode . js2-mode)))
               ("Typescript"
                (or
                 (mode . typescript-mode)))
               ("Matlab"
                (or
                 (mode . matlab-mode)
                 (name . "*MATLAB*")))
               ;; ("emacs-config"
               ;;  (or
               ;;   (filename . ".emacs")))
               ("Emacslisp"
                (mode . emacs-lisp-mode))
               ("Shell"
                (or
                 (filename . "\\.sh")
                 (mode . shell-script-mode)
                 (mode . sh-mode)))
               ("Perl"
                (mode . perl-mode))
               ("Tex"
                (or
                 (mode . auctex)
                 (mode . latex-mode)))
               ("Markdown"
                (or
                 (mode . markdown-mode)))
               ("Org" ;; all org-related buffers
                (mode . org-mode))
               ("Text"
                (mode . text-mode))
               ("Mail"
                (or ;; mail-related buffers
                 (mode . message-mode)
                 (mode . mail-mode)
                 ;; etc. ; all your mail related modes
                 ))
               ("ERC"
                (mode . erc-mode))
               ("Scratch"
                (mode . scratch-mode))
               ("Dired"
                (mode . dired-mode))
               ("man"
                (mode . Man-mode))
               ("Eshell"
                (mode . eshell-mode))
               ("Magit"
                (or
                 (name . "magit")))
               ))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode t)
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil)

(define-ibuffer-column lines (:name "Lines") (int-to-string (count-lines (point-min) (point-max))))

(setq ibuffer-formats '((mark modified read-only " "
                              (name 18 18 :left :elide)
                              " "
                              (lines 9 -1 :right)
                              " "
                              (mode 16 16 :left :elide)
                              " " filename-and-process)
                        (mark " "
                              (name 16 -1)
                              " " filename)))

(defun idobuffer ()
  "Open ibuffer and start ido"
  (interactive)
  (ibuffer)
  (ido-switch-buffer)
  (kill-buffer "*Ibuffer*"))

(defun ibuffer-ido-find-file ()
  "Like `ido-find-file', but default to the directory of the buffer at point."
  (interactive
   (let ((default-directory (let ((buf (ibuffer-current-buffer)))
                              (if (buffer-live-p buf)
                                  (with-current-buffer buf
                                    default-directory)
                                default-directory))))
     (ido-find-file-in-dir default-directory))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (define-key ibuffer-mode-map "\C-x\C-f"
              'ibuffer-ido-find-file)))
(defadvice ibuffer (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name"
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

(defun ibuffer-ediff-marked-buffers ()
  (interactive)
  (let* ((marked-buffers (ibuffer-get-marked-buffers))
         (len (length marked-buffers)))
    (unless (= 2 len)
      (error (format "%s buffer%s been marked (needs to be 2)"
                     len (if (= len 1) " has" "s have"))))
    (ediff-buffers (car marked-buffers) (cadr marked-buffers))))

(define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)
