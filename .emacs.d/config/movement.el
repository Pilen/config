;;______________________________________________________________________________
;π MOVEMENT
;;______________________________________________________________________________

;; I used to use geosoft-backward-word and forward-word to automatically cling to
;; the word traversed, but i found it annoying when i met an end of line.

(defun geosoft-forward-word ()
  ;; Move one word forward. Leave the pointer at start of word
  ;; instead of emacs default end of word. Treat _ as part of word
  (interactive)
  (forward-char 1)
  (backward-word 1)
  (forward-word 2)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
        (t (forward-char 1))))

(defun geosoft-backward-word ()
  ;; Move one word backward. Leave the pointer at start of word
  ;; Treat _ as part of word
  (interactive)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (geosoft-backward-word))
        (t (forward-char 1))))


(defun forward-word-to-newline ()
  (interactive)
  (unless (= (point) (point-max))
    (if (char-equal (char-after) ?\n)
        (search-forward-regexp "[a-zA-Z0-9æøåÆØÅ]+" nil t)
      (search-forward-regexp "[[a-zA-Z0-9æøåÆØÅ]+\\|$" nil t))))

;; Alternatively look at https://github.com/nivaca/nv-delete-back
;;theres an error, as it needs a non a-0-9 char before the word
(defun backward-word-to-newline ()
  (interactive)
  (unless (= (point) (point-min))
    (if (char-equal (char-before) ?\n)
        (progn ;; At beginning of line
          (backward-char)
          (if (search-backward-regexp "[^a-zA-Z0-9æøåÆØÅ]+[a-zA-Z0-9æøåÆØÅ]+" nil t)
              (forward-char)
            (beginning-of-line)))
      (progn
        (when (or (eobp) (char-equal (char-after) ?\n))
          (backward-char))
        (if (search-backward-regexp "[^a-zA-Z0-9æøåÆØÅ]+[a-zA-Z0-9æøåÆØÅ]+\\|$" nil t)
            (forward-char)
          (beginning-of-line))))))

(defun forward-kill-word-to-newline ()
  (interactive)
  (let ((beg (point)))
    (forward-word-to-newline)
    (kill-region beg (point))))

(defun backward-kill-word-to-newline ()
  (interactive)
  (let ((beg (point)))
    (backward-word-to-newline)
    (kill-region beg (point))))

;;______________________________________________________________________________
;π START OF LINE/INDENTATION
;;______________________________________________________________________________
(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))
