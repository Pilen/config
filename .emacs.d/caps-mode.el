;;; caps-mode.el -- (minor mode) letters are inserted capitalized

;; Copyright (C) 2004 Joe Corneli <address@hidden>

;; Time-stamp: <jac -- Sat Aug  7 13:05:16 CDT 2004>

;; This file is not part of GNU Emacs, but it is distributed under
;; the same terms as GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 2, or (at your
;; option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This is a simple minor mode in which all letters are inserted in
;; captialized form.  I haven't bothered with letters outside of
;; ASCII.

;; Note that this mode has absolutely nothing to do with the toggle
;; state of your capslock.

;;; Code:

(define-minor-mode caps-mode
  "Toggle caps mode.
With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

When caps mode is enabled, all letters are inserted in their
capitalized form."
  :init-value nil
  :lighter " Caps"
  :keymap '(
            ("a" . (lambda () (interactive) (insert (string-to-char "A"))))
            ("b" . (lambda () (interactive) (insert (string-to-char "B"))))
            ("c" . (lambda () (interactive) (insert (string-to-char "C"))))
            ("d" . (lambda () (interactive) (insert (string-to-char "D"))))
            ("e" . (lambda () (interactive) (insert (string-to-char "E"))))
            ("f" . (lambda () (interactive) (insert (string-to-char "F"))))
            ("g" . (lambda () (interactive) (insert (string-to-char "G"))))
            ("h" . (lambda () (interactive) (insert (string-to-char "H"))))
            ("i" . (lambda () (interactive) (insert (string-to-char "I"))))
            ("j" . (lambda () (interactive) (insert (string-to-char "J"))))
            ("k" . (lambda () (interactive) (insert (string-to-char "K"))))
            ("l" . (lambda () (interactive) (insert (string-to-char "L"))))
            ("m" . (lambda () (interactive) (insert (string-to-char "M"))))
            ("n" . (lambda () (interactive) (insert (string-to-char "N"))))
            ("o" . (lambda () (interactive) (insert (string-to-char "O"))))
            ("p" . (lambda () (interactive) (insert (string-to-char "P"))))
            ("q" . (lambda () (interactive) (insert (string-to-char "Q"))))
            ("r" . (lambda () (interactive) (insert (string-to-char "R"))))
            ("s" . (lambda () (interactive) (insert (string-to-char "S"))))
            ("t" . (lambda () (interactive) (insert (string-to-char "T"))))
            ("u" . (lambda () (interactive) (insert (string-to-char "U"))))
            ("v" . (lambda () (interactive) (insert (string-to-char "V"))))
            ("w" . (lambda () (interactive) (insert (string-to-char "W"))))
            ("x" . (lambda () (interactive) (insert (string-to-char "X"))))
            ("y" . (lambda () (interactive) (insert (string-to-char "Y"))))
            ("z" . (lambda () (interactive) (insert (string-to-char "Z"))))))

(provide 'caps-mode)
;;; caps-mode.el ends here
