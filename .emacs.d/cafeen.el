;;; cafeen.el --- Emacs interface for Cafeens?! webcam"

;; Copyright (C) 2012 Søren Pilgård

;; Author: Søren Pilgård
;; Version: 1

;; This file is NOT part of GNU Emacs.

;;; License:
;; This file is licenced under the beerware licence:
;; /*
;;  * ----------------------------------------------------------------------------
;;  * "THE BEER-WARE LICENSE" (Revision 42):
;;  * Søren Pilgård wrote this file. As long as you retain this notice you
;;  * can do whatever you want with this stuff. If we meet some day, and you think
;;  * this stuff is worth it, you can buy me a beer in return. Søren Pilgård.
;;  * ----------------------------------------------------------------------------
;;  */

;;; Commentary:
;; This mode allows you to keep track of whats happening at Cafeen?!
;; while staying in your editor.
;; You can see the live stream from cafeen.org and see what music is currently
;; playing.
;;
;; To install make sure cafeen.el is in your loadpath and then insert the
;; following into your .emacs or equivilant configuration file:
;;
;; (require 'cafeen)
;;
;; To start the streaming call
;; M-x cafeen
;; Which will open a buffer called *cafeen?!* with the stream from the webcam.

;;; Code:


(defgroup cafeen nil
  "Emacs interface for Cafeens?! webcam"
  :group 'multimedia)


(defcustom cafeen/webcam-file "~/.cafeen.jpg"
  "The image file where the frames of the stream are saved.
The file is automatically deleted when the *cafeen?!* buffer is closed")

(defcustom cafeen/updateinterval 5
  "How often should the *cafeen?!* buffer get updated.
A new frame is uploaded on cafeens server every 5 seconds.
5 is therefore used as the default value.")

(defun cafeen/current-song ()
  "Returns the current song played at Cafeen?!"
  (substring (shell-command-to-string "curl -s http://www.cafeen.org/webcam_view.php/ | grep NP:") 0 -1))

(defun cafeen/get-webcam ()
  "Returns the latest frame from cafeens webcam."
  (shell-command-to-string (concat "curl -s http://www.cafeen.org/test.php -o " cafeen/webcam-file)))

(defun cafeen/update ()
  "The function for updating the contents of the *cafeen?!* buffer."
  (when (not (get-buffer "*cafeen?!*"))
    (cafeen/stop))
  (set-buffer "*cafeen?!*")
  (erase-buffer)
  (image-flush (create-image cafeen/webcam-file))
  (cafeen/get-webcam)
  (insert-image (create-image cafeen/webcam-file))
  (insert "\n")
  (insert (cafffeen/current-song))
  (insert "\n"))

(defun cafeen/stop-updates ()
  "Stop the Cafeen?! timer, this wont close the buffer."
  (cancel-function-timers 'cafeen/update))

(defun cafeen/stop ()
  "Stop the webcam, close the *cafeen?!* buffer and delete the webcam file."
  (interactive)
  (cafeen/stop-updates)
  (when (get-buffer "*cafeen?!*")
    (kill-buffer "*cafeen?!*"))
  (delete-file cafeen/webcam-file))

(defun cafeen ()
  "Create a new buffer *cafeen?!* displaying the latest image from Cafeens?!
webcam and the current song being played.
The webcam is updated every 5 seconds on the server, so a timer is used."
  (interactive)
  (switch-to-buffer "*cafeen?!*")
  (message "Caféen?!")
  (run-at-time 0 cafeen/updateinterval 'cafeen/update))

(provide 'cafeen)

;;; cafeen.el ends here
