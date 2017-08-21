
(defvar arduinel--arduino-buffer "*arduino*"
  "The buffer of the arduino process")

(defvar arduinel--arduino-process nil
  "The current arduino process")

(defun arduinel-build ()
  "Compile and upload sketch to board"
  (interactive)
  (save-some-buffers)
  (if (process-live-p arduinel--arduino-process)
      (message "Arduino build is already running")

    (message "building...")

    (with-current-buffer (get-buffer-create arduinel--arduino-buffer)
      (let ((inhibit-read-only t))
        (erase-buffer))
      (setq buffer-read-only t))

    (let ((sketch (buffer-file-name)))
      (setq arduinel--arduino-process
            (start-process "arduino" arduinel--arduino-buffer
                           "arduino" "--upload" sketch))
      (set-process-sentinel arduinel--arduino-process
                            (lambda (process status)
                              ;; (let ((msg (format "%s %s" process status)))
                              (let ((msg (format "%s %s" process (substring status 0 -1)))
                                    (inhibit-read-only t))
                                (with-current-buffer arduinel--arduino-buffer
                                  (insert-before-markers msg "\n"))
                                (message msg)))))
    (switch-to-buffer-other-window arduinel--arduino-buffer)))

(defun arduinel-serial-monitor ()
  "View output from serial port"
  (interactive)
  (call-interactively 'serial-term)
  ;; (let ((port (with-temp-buffer
  ;;               (call-process "arduino" nil(current-buffer) nil "--get-pref" "serial.port")
  ;;               (delete-backward-char 1)
  ;;               (thing-at-point 'line t)))
  ;;       (rate (string-to-int
  ;;              (with-temp-buffer
  ;;                (call-process "arduino" nil(current-buffer) nil "--get-pref" "serial.debug_rate")
  ;;                (delete-backward-char 1)
  ;;                (thing-at-point 'line t)))))
  ;;   (serial-term port rate))
  )


;; (message "%s" "hej\n")
;; (serial-term)
;; hej
;; (serial-term "/dev/ttyACM0" 9600)
;; (process-filter (get-process "/dev/ttyACM0"))
;; (ansi-term "/home/pilen/knoerden/projekter/test/out.sh")
;; (process-filter (get-process "*ansi-term*"))

;; (arduinel-serial-monitor)
