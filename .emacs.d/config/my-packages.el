
(defconst required-packages
  '()
  "List of required packages.
All packages here will automatically be installed if not present.")
(setq required-packages
      '(
        auto-highlight-symbol
        ace-jump-mode
        buffer-move
        c-eldoc
        column-marker
        dash
        dtrt-indent
        expand-region
        fastnav               ;; todo use me more
        fill-column-indicator ;; not really used (could come in handy)
        flymake-cursor        ;; todo use flymake more
        full-ack              ;; not really used yet
        fuzzy                 ;; not used, what is it exactly?
        geiser
        ghc
        golden-ratio          ;; Not used often
        google-translate
        goto-last-change
        graphviz-dot-mode
        haskell-mode
        highlight-tail        ;; Cool but not used
        hlinum
        idomenu               ;; I rolled my own instead
        iedit
        inf-ruby
        keyfreq
        lorem-ipsum
        magit
        markdown-mode
        matlab-mode
        mic-paren             ;; Not used
        minesweeper
        multiple-cursors
        nav                   ;; Not really used yet
        pager
        powerline             ;; Not used
        quack
        rainbow-delimiters
        rfringe               ;; Not used
        smart-forward         ;; Not really used yet
        smex                  ;; Not used, i use my own instead
        sml-mode
        sr-speedbar
        tabbar                ;; Not used
        typing
        visible-mark
        volatile-highlights
        win-switch
        window-numbering
        wrap-region
        zeal-at-point
        ))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defun install-required-packages ()
  "Install all missing packages listed in required-packages.
If packages are missing the package the database is refreshed."
  (let ((install t))
    (unless
        ;; Are any packages not installed?
        (dolist (package required-packages install)
          (setq install (and (package-installed-p package)
                             install)))
      ;; Then install the packages not already installed
      (message "Refreshing package database...")
      (package-refresh-contents)
      (dolist (package required-packages)
        (unless (package-installed-p package)
          (message "Installing %s..." package)
          (package-install package)))
      (message "Packages installed")))

  ;; ;; Add packages to load-path
  ;; (dolist path (directory-files "~/.emacs.d/elpa" t
  ;;                          (concat "^\\("
  ;;                                  (mapconcat 'symbol-name required-packages "\\|")
  ;;                                  "\\).*"))
  ;;       (when (and (file-directory-p path)
  ;;                  (not (member path load-path)))
  ;;         (add-to-list 'load-path path))))
  )

(install-required-packages)
