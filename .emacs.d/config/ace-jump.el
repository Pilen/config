;;______________________________________________________________________________
;π ACE-JUMP
;;______________________________________________________________________________
(require 'ace-jump-mode)
;; (setq ace-jump-mode-move-keys
;;       '(?a ?r ?s ?t ?n ?e ?i ?o ?l ?u ?y))
(setq ace-jump-mode-move-keys
      (loop for i from ?a to ?z collect i))
(setq ace-jump-mode-case-fold nil)
(setq ace-jump-mode-gray-background t)
(set-face-foreground 'ace-jump-face-background "gray80")
;(setq ace-jump-mode-scope 'window)
(setq ace-jump-mode-scope 'global)

(defun ace-jump-char-local (query-char)
  (interactive (list (read-char "Query Char:")))
  (let ((ace-jump-mode-scope 'window))
    (ace-jump-char-mode query-char)))

(defun ace-jump-char-global (query-char)
  (interactive (list (read-char "Query Char:")))
  (let ((ace-jump-mode-scope 'global))
    (ace-jump-char-mode query-char)))

(defun ace-jump-line-local (query-char)
  (interactive (list (read-char "Query Char:")))
  (let ((ace-jump-mode-scope 'window))
    (ace-jump-line-mode query-char)))

(defun ace-jump-line-global (query-char)
  (interactive (list (read-char "Query Char:")))
  (let ((ace-jump-mode-scope 'global))
    (ace-jump-line-mode query-char)))
