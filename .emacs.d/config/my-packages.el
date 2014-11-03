
(defvar required-packages
  '()
  "List of required packages.
All packages here will automatically be installed if not present.")
(setq required-packages
      '())

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
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
      (message "Packages installed"))))

(install-required-packages)
