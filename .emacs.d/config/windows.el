;;______________________________________________________________________________
;π WINDOWS
;;______________________________________________________________________________
;;(setq split-width-threshold 0)
(setq split-height-threshold nil)

(require 'buffer-move)
(require 'tiling)
(require 'window-numbering)
(defun window-numbering-install-mode-line (&optional position)
  )
(window-numbering-mode 1)
(require 'win-switch)
(setq win-switch-idle-time 0.60)
(setq win-switch-window-threshold 2)
(setq win-switch-other-window-first nil)
;(win-switch-set-wrap-around)
(win-switch-delete-key "i" 'up)
(win-switch-delete-key "k" 'down)
(win-switch-delete-key "j" 'left)
(win-switch-delete-key "l" 'right)
(win-switch-delete-key "o" 'next-window)
(win-switch-delete-key "p" 'previous-window)
(win-switch-delete-key " " 'other-frame)
(win-switch-delete-key "u" 'exit)
(win-switch-delete-key "I" 'enlarge-vertically)
(win-switch-delete-key "K" 'shrink-vertically)
(win-switch-delete-key "L" 'enlarge-horizontally)
(win-switch-delete-key "J" 'shrink-horizontally)
(win-switch-delete-key "h" 'split-vertically)
(win-switch-delete-key ";" 'split-horizontally)
(win-switch-delete-key "0" 'delete-window)


(win-switch-add-key "u" 'up)
(win-switch-add-key "e" 'down)
(win-switch-add-key "n" 'left)
(win-switch-add-key "i" 'right)
(win-switch-add-key "y" 'next-window)
(win-switch-add-key "l" 'previous-window)
;(win-switch-add-key "<spc>" 'other-frame)
(win-switch-add-key "<spc>" 'exit)
(win-switch-add-key "k" 'exit)
(win-switch-add-key "f" 'shrink-vertically)
(win-switch-add-key "s" 'enlarge-vertically)
(win-switch-add-key "r" 'enlarge-horizontally)
(win-switch-add-key "t" 'shrink-horizontally)
(win-switch-add-key ";" 'split-horizontally)
(win-switch-add-key ":" 'split-vertically)
(win-switch-add-key "\\" 'delete-window)

(win-switch-define-key "U" 'buf-move-up t)
(win-switch-define-key "E" 'buf-move-down t)
(win-switch-define-key "N" 'buf-move-left t)
(win-switch-define-key "I" 'buf-move-right t)

(win-switch-define-key "C-U" 'tiling-tile-up t)
(win-switch-define-key "C-E" 'tiling-tile-down t)
(win-switch-define-key "C-N" 'tiling-tile-left t)
(win-switch-define-key "C-I" 'tiling-tile-right t)

(win-switch-define-key "o" 'tiling-cycle t)
(win-switch-define-key "|" 'delete-other-windows t)

(win-switch-define-key "0" 'select-window-0)
(win-switch-define-key "1" 'select-window-1)
(win-switch-define-key "2" 'select-window-2)
(win-switch-define-key "3" 'select-window-3)
(win-switch-define-key "4" 'select-window-4)
(win-switch-define-key "5" 'select-window-5)
(win-switch-define-key "6" 'select-window-6)
(win-switch-define-key "7" 'select-window-7)
(win-switch-define-key "8" 'select-window-8)
(win-switch-define-key "9" 'select-window-9)


(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))


;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (if (let (window (get-buffer-window (current-buffer)))
       (set-window-dedicated-p window (not (window-dedicated-p window))))
      (progn
        (message "'%s' dedicated" (current-buffer))
        (bufferlocal-background "gray20"))
    (progn
      (message "'%s' normal" (current-buffer))
      (remove-bufferlocal-background))))

(require 'golden-ratio)
(setq golden-ratio 'nil)
;(golden-ratio-enable)
(defun golden-ratio-toggle ()
  (interactive)
  (if golden-ratio
      (progn
        (setq golden-ratio 'nil)
        (golden-ratio-disable))
    (progn
      (setq golden-ratio 't)
      (golden-ratio-enable))))
(defconst -golden-ratio-value 2)

;;______________________________________________________________________________
;π WINDOWS
;;______________________________________________________________________________
(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

;;______________________________________________________________________________
;π SWAP WINDOWS
;;______________________________________________________________________________

;; someday might want to rotate windows if more than 2 of them
(defun swap-windows ()
  "If you have 2 windows, it swaps them." (interactive) (cond ((not (= (count-windows) 2)) (message "You need exactly 2 windows to do this."))
                                                              (t
                                                               (let* ((w1 (first (window-list)))
                                                                      (w2 (second (window-list)))
                                                                      (b1 (window-buffer w1))
                                                                      (b2 (window-buffer w2))
                                                                      (s1 (window-start w1))
                                                                      (s2 (window-start w2)))
                                                                 (set-window-buffer w1 b2)
                                                                 (set-window-buffer w2 b1)
                                                                 (set-window-start w1 s2)
                                                                 (set-window-start w2 s1)))))

(defun swap-with (dir)
  (interactive)
  (let ((other-window (windmove-find-other-window dir)))
    (when other-window
      (let* ((this-window  (selected-window))
             (this-buffer  (window-buffer this-window))
             (other-buffer (window-buffer other-window))
             (this-start   (window-start this-window))
             (other-start  (window-start other-window)))
        (set-window-buffer this-window other-buffer)
        (set-window-buffer other-window this-buffer)
        (set-window-start  this-window other-start)
        (set-window-start  other-window this-start)))))
