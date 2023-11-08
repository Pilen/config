
;; Alternativly theese packages could be specified in the config files
;; like https://github.com/expez/.emacs.d/blob/master/lisp/init-package.el

(defconst required-packages
  '()
  "List of required packages.
All packages here will automatically be installed if not present.")
(setq required-packages
      '(
        ag
        all-the-icons
        auto-highlight-symbol
        ace-jump-mode
        ace-window
        auctex
        arduino-mode
        bnf-mode
        buffer-move
        calfw
        c-eldoc
        counsel
        column-marker
        company
        company-go
        company-jedi
        company-quickhelp
        crontab-mode
        csv-mode
        dash
        dash-docs
        docker
        dockerfile-mode
        docker-compose-mode
        dimmer
        diredfl
        dtrt-indent
        edit-server ;; For use with emacs_chrome (Edit with Emacs)
        elpy
        ensime                ;; Scala stuff - auto enables it self
        ;;erc-hl-nicks ;; Breaks my setup after updating to emacs 26.1
        expand-region
        fastnav               ;; todo use me more
        fill-column-indicator ;; not really used (could come in handy)
        flymake-cursor        ;; todo use flymake more
        flyspell-correct-ivy
        ;;forge
        full-ack              ;; not really used yet
        fuzzy                 ;; not used, what is it exactly?
        geiser
        ghc
        gnu-elpa-keyring-update
        go-mode
        golden-ratio          ;; Not used often
        google-translate
        goto-chg
        ;; goto-last-change
        graphviz-dot-mode
        haskell-mode
        highlight-tail        ;; Cool but not used
        hlinum
        hydra
        idomenu               ;; I rolled my own instead
        iedit
        imenu-list
        impatient-mode
        inf-ruby
        ivy-xref
        js2-mode
        jss
        keyfreq
        kite
        less-css-mode
        livid-mode
        loccur
        lorem-ipsum
        magit
        magit-todos
        markdown-mode
        matlab-mode
        memory-usage
        mic-paren             ;; Not used
        minesweeper
        ;; mu4e
        multiple-cursors
        nav                   ;; Not really used yet
        neotree
        notmuch
        origami
        pager
        paredit
        powerline             ;; Not used
        projectile
        processing-mode
        ;; python-mode        ;; Very heavy (26000 lines+)
        quack
        rainbow-delimiters
        request
        rfringe               ;; Not used
        scala-mode
        skewer-mode
        smart-forward         ;; Not really used yet
        smex                  ;; Not used, i use my own instead
        sml-mode
        sr-speedbar
        swiper
        tabbar                ;; Not used
        tagedit
        typescript-mode
        typing
        undo-tree
        visible-mark
        volatile-highlights
        web-mode
        web                   ;; For my sharelatex.el package
        wgrep
        wgrep-ag
        win-switch
        window-numbering
        wrap-region
        zeal-at-point
        ))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
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
