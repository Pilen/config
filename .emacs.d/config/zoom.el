;;______________________________________________________________________________
;π ZOOM
;;______________________________________________________________________________
;; We might want to simply use text-scale-adjust instead
;; Though we would still need a way to change font

(defun defaultface ()
  (interactive)
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "Schumacher" :family "Clean")))))
  )


(defun zoomableface ()
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "grey30" :foreground "honeydew1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 80 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
  )

(defun zoom (n)
  "With positive N, increase the font size, otherwire decrease it"
  (set-face-attribute 'default (selected-frame) :height
                      (+ (face-attribute 'default :height) (* (if (> n 0) 1 -1) 10))
                                        ;(+ (face-attribute 'default :height) 10)))
                      ))
