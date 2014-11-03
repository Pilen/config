;;______________________________________________________________________________
;π ERC
;;______________________________________________________________________________
(require 'erc)
;; (require 'erc-highlight-nicknames)
(setq erc-modules (quote (autojoin
                          button
                          completion
                          highlight-nicknames
                          irccontrols
                          list
                          match
                          menu
                          move-to-prompt
                          netsplit
                          networks
                          noncommands
                          readonly
                          ring
                          stamp
                          track)))

(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                 "324" "329" "332" "333" "353" "477"))
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(setq erc-pals '("caroline"))
(add-hook 'erc-mode-hook (lambda () (set-face-foreground 'erc-pal-face "red")))

(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#emacs" "#diku" "#eggsml")))

(setq erc-interpret-mirc-color t)

(defun my-erc-start ()
  (interactive)
  ;; (erc :server "localhost" :port "6667" :nick "pilen" :password (read-passwd "Password: ")))
  (erc :server "irc.freenode.net" :port "6667" :nick private-irc-username :password private-irc-password))

(defun erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (or (get-buffer "localhost:6667") ;; ERC already active?
          (get-buffer "irc.freenode.net:6667"))
    (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (my-erc-start))))

(add-hook 'erc-mode-hook (lambda () (erc-fill-mode -1) (visual-line-mode)))

(eval-after-load 'erc-track
  '(progn
     (defun erc-bar-move-back (n)
       "Moves back n message lines. Ignores wrapping, and server messages."
       (interactive "nHow many lines ? ")
       (re-search-backward "^.*<.*>" nil t n))

     (defun erc-bar-update-overlay ()
       "Update the overlay for current buffer, based on the content of
erc-modified-channels-alist. Should be executed on window change."
       (interactive)
       (let* ((info (assq (current-buffer) erc-modified-channels-alist))
              (count (cadr info)))
         (if (and info (> count erc-bar-threshold))
             (save-excursion
               (end-of-buffer)
               (when (erc-bar-move-back count)
                 (let ((inhibit-field-text-motion t))
                   (move-overlay erc-bar-overlay
                                 (line-beginning-position)
                                 (line-end-position)
                                 (current-buffer)))))
           (delete-overlay erc-bar-overlay))))

     (defvar erc-bar-threshold 1
       "Display bar when there are more than erc-bar-threshold unread messages.")
     (defvar erc-bar-overlay nil
       "Overlay used to set bar")
     (setq erc-bar-overlay (make-overlay 0 0))
     (overlay-put erc-bar-overlay 'face '(:underline "black"))
     ;;put the hook before erc-modified-channels-update
     (defadvice erc-track-mode (after erc-bar-setup-hook
                                      (&rest args) activate)
       ;;remove and add, so we know it's in the first place
       (remove-hook 'window-configuration-change-hook 'erc-bar-update-overlay)
       (add-hook 'window-configuration-change-hook 'erc-bar-update-overlay))
     (add-hook 'erc-send-completed-hook (lambda (str)
                                          (erc-bar-update-overlay)))))
