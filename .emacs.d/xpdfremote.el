

;; Customization
(defgroup xpdfremote nil
  "Remote control xpdf"
  :prefix "xpdfremote/"
  :group 'external)

;; obsolete - unless you use (split-string xpdfremote/xpdf-command " ")
(defcustom xpdfremote/xpdf-command
  "xpdf -fullscreen -remote emacs-xpdfremote"
  "xpdf command, not currently used"
  :group 'xpdfremote
  :type 'string)

(defcustom xpdfremote/server-name
  "emacs-xpdfremote"
  "server name"
  :group 'xpdfremote
  :type 'string)


(defcustom xpdfremote/mode-hook
  nil
  "Hook"
  :group 'xpdfremote
  :type 'hook)

(defcustom xpdfremote/fullscreen
  t
  ""
  :group 'xpdfremote)


(defvar xpdfremote/current-file)

(defvar xpdfremote/buffer-name "*xpdfremote*")

(defvar xpdfremote/server nil)

;; remotecontrol functions
(defun xpdfremote/open-file (filename)
  (interactive "f")
  (xpdfremote)
  (when (not (xpdfremote/find-string-in-current-buffer filename))
    (xpdfremote/insert-file filename))
  (setq xpdfremote/current-file filename)
  (xpdfremote/xpdf-open-file filename)
  (cd (file-name-directory filename)))

(defun xpdfremote/send-command (command)
  (interactive "s")
  (when xpdfremote/server
    (start-process "xpdfremote/processs" nil "xpdf" "-remote" xpdfremote/server-name "-exec" command)))

(defun xpdfremote/select-file ()
  (interactive)
  (let ((line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
    (xpdfremote/open-file line)))

(defun xpdfremote/close ()
  (interactive)
  (setq xpdfremote/server nil))

;; internal functions

(defun xpdfremote/find-string-in-current-buffer (string)
  (save-match-data
    (goto-char (point-min))
    (search-forward string nil t)))

(defun xpdfremote/insert-file (filename)
  (end-of-buffer)
  (let ((buffer-read-only nil))
    (insert filename)
    (newline)))

(defun xpdfremote/xpdf-open-file (filename)
   (setq xpdfremote/server (start-process "xpdfremote/processs" nil "xpdf" "-remote" xpdfremote/server-name filename
                                          (when xpdfremote/fullscreen "-fullscreen")))
   (raise-frame)
   (x-focus-frame nil))
;; mode

(defun xpdfremote ()
  (interactive)
  (select-window (or (get-buffer-window xpdfremote/buffer-name)
                     (selected-window)))
  (switch-to-buffer xpdfremote/buffer-name)

  (when (not (eq major-mode 'xpfremote/mode))
    (kill-all-local-variables)
    (use-local-map xpdfremote/mode-map)
    (setq major-mode 'xpdfremote/mode)
    (setq mode-name "XpdfRemote")
    (toggle-read-only t)
    (run-hooks 'xpdfremote/mode-hook)))

(defun xpdfremote/mode () "xpdfremote" nil)

(defun xpdfremote/open-pdf-with-xpdfremote ()
  (let ((file-name (buffer-file-name)))
    (message file-name)
    (kill-buffer)
    (xpdfremote/open-file file-name)))
    ;;(kill-buffer))
    ;;(xpdfremote/open-file (buffer-file-name))))

(add-to-list 'auto-mode-alist '("\\.pdf?$" . xpdfremote/open-pdf-with-xpdfremote))
;(add-to-list 'auto-mode-alist '("\\.pdf?$" . text-mode))




























































;; keymaps
(defvar xpdfremote/mode-map (make-sparse-keymap)
)
  ;; (let ((map (make-sparse-keymap)))

  ;;   ;;navigation
  ;;   (define-key map (kbd "u") 'xpdfremote/xpdf-pageUp)
  ;;   (define-key map (kbd "e") 'xpdfremote/xpdf-pageDown)

  ;;   (define-key map (kbd "s") 'xpdfremote/xpdf-find

  ;;   ;;rendering
  ;;   (define-key map (kbd "f") 'xpdfremote/xpdf-toggleFullScreenMode)
  ;;   (define-key map (kbd "c") 'xpdfremote/xpdf-toggleContinuousMode)

  ;;   (define-key map (kbd "q") 'xpdfremote/xpdf-quit)

  ;;   (define-key map (kbd "M-u") 'previous-line)
  ;;   (define-key map (kbd "M-e") 'next-line)
  ;;   (define-key map (kbd "o") 'xpdfremote/open-file)
  ;;   (define-key map (kbd "<return>") 'xpdfremote/select-file)
  ;;   (define-key map (kbd "<tab>") 'next-line)
  ;;   (define-key map (kbd "<S-iso-lefttab>") 'previous-line)
  ;;   map)))

(progn
    ;;navigation
    (define-key xpdfremote/mode-map (kbd "u") 'xpdfremote/xpdf-pageUp)
    (define-key xpdfremote/mode-map (kbd "e") 'xpdfremote/xpdf-pageDown)
    (define-key xpdfremote/mode-map (kbd "l") 'xpdfremote/xpdf-scrollToTopLeft)
    (define-key xpdfremote/mode-map (kbd "y") 'xpdfremote/xpdf-scrollToBottomRight)


    (define-key xpdfremote/mode-map (kbd "<left>")      'xpdfremote/xpdf-scrollLeft_16)
    (define-key xpdfremote/mode-map (kbd "<right>")     'xpdfremote/xpdf-scrollRight_16)
    (define-key xpdfremote/mode-map (kbd "<up>")        'xpdfremote/xpdf-scrollUp_16)
    (define-key xpdfremote/mode-map (kbd "<down>")      'xpdfremote/xpdf-scrollDown_16)

    (define-key xpdfremote/mode-map (kbd "<home>")      'xpdfremote/xpdf-gotoPage_1)
    (define-key xpdfremote/mode-map (kbd "<end>")      'xpdfremote/xpdf-gotoLastPage)

    (define-key xpdfremote/mode-map (kbd "<prior>") 'xpdfremote/xpdf-pageUp)
    (define-key xpdfremote/mode-map (kbd "<next>") 'xpdfremote/xpdf-pageDown)
    (define-key xpdfremote/mode-map (kbd "<backspace>") 'xpdfremote/xpdf-pageUp)
    (define-key xpdfremote/mode-map (kbd "<space>") 'xpdfremote/xpdf-pageDown)
    (define-key xpdfremote/mode-map (kbd "<delete>") 'xpdfremote/xpdf-pageUp)

    (define-key xpdfremote/mode-map (kbd "n") 'xpdfremote/xpdf-nextPage)
    (define-key xpdfremote/mode-map (kbd "N") 'xpdfremote/xpdf-nextPageNoScroll)
    (define-key xpdfremote/mode-map (kbd "p") 'xpdfremote/xpdf-prevPage)
    (define-key xpdfremote/mode-map (kbd "P") 'xpdfremote/xpdf-prevPageNoScroll)


    (define-key xpdfremote/mode-map (kbd "v") 'xpdfremote/xpdf-goForward)
    (define-key xpdfremote/mode-map (kbd "b") 'xpdfremote/xpdf-goBackward)


    ;;zoom
    (define-key xpdfremote/mode-map (kbd "0") 'xpdfremote/xpdf-zoomPercent_125)
    (define-key xpdfremote/mode-map (kbd "+") 'xpdfremote/xpdf-zoomIn)
    (define-key xpdfremote/mode-map (kbd "-") 'xpdfremote/xpdf-zoomOut)
    (define-key xpdfremote/mode-map (kbd "z") 'xpdfremote/xpdf-zoomFitPage)
    (define-key xpdfremote/mode-map (kbd "w") 'xpdfremote/xpdf-zoomFitWidth)

    ;;rendering
    (define-key xpdfremote/mode-map (kbd "H-f") 'xpdfremote/xpdf-toggleFullScreenMode)
    (define-key xpdfremote/mode-map (kbd "c") 'xpdfremote/xpdf-toggleContinuousMode)

    ;;other
    (define-key xpdfremote/mode-map (kbd "f") 'xpdfremote/xpdf-find)`
    (define-key xpdfremote/mode-map (kbd "g") 'xpdfremote/xpdf-findNext)`

    (define-key xpdfremote/mode-map (kbd "H-p") 'xpdfremote/xpdf-print)
    (define-key xpdfremote/mode-map (kbd "q") 'xpdfremote/xpdf-quit)

    (define-key xpdfremote/mode-map (kbd "r") 'xpdfremote/xpdf-reload)
    (define-key xpdfremote/mode-map (kbd "R") 'xpdfremote/xpdf-redraw)

    (define-key xpdfremote/mode-map (kbd "g") 'xpdfremote/xpdf-gotoPage)

    ;;xpdfremote
    (define-key xpdfremote/mode-map (kbd "M-u") 'previous-line)
    (define-key xpdfremote/mode-map (kbd "M-e") 'next-line)
    (define-key xpdfremote/mode-map (kbd "o") 'xpdfremote/open-file)
    (define-key xpdfremote/mode-map (kbd "<return>") 'xpdfremote/select-file)
    (define-key xpdfremote/mode-map (kbd "<tab>") 'next-line)
    (define-key xpdfremote/mode-map (kbd "<S-iso-lefttab>") 'previous-line)
    (define-key xpdfremote/mode-map (kbd "s") 'isearch)
    )


(defvar xpdfremote/xpdf-default-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-<home>")    'xpdfremote/xpdf-gotoPage_1)
    (define-key map (kbd "<home>")      'xpdfremote/xpdf-scrollToTopLeft)
    (define-key map (kbd "C-<end>")     'xpdfremote/xpdf-gotoLastPage)
    (define-key map (kbd "<end>")       'xpdfremote/xpdf-scrollToBottomRight)
    (define-key map (kbd "<prev>")      'xpdfremote/xpdf-pageUp)
    (define-key map (kbd "<backspace>") 'xpdfremote/xpdf-pageUp)
    (define-key map (kbd "<delete>")    'xpdfremote/xpdf-pageUp)
    (define-key map (kbd "<next>")      'xpdfremote/xpdf-pageDown)
    (define-key map (kbd "<space>")     'xpdfremote/xpdf-pageDown)
    (define-key map (kbd "<left>")      'xpdfremote/xpdf-scrollLeft_16)
    (define-key map (kbd "<right>")     'xpdfremote/xpdf-scrollRight_16)
    (define-key map (kbd "<up>")        'xpdfremote/xpdf-scrollUp_16)
    (define-key map (kbd "<down>")      'xpdfremote/xpdf-scrollDown_16)
    (define-key map (kbd "o")           'xpdfremote/xpdf-open)
    (define-key map (kbd "O")           'xpdfremote/xpdf-open)
    (define-key map (kbd "r")           'xpdfremote/xpdf-reload)
    (define-key map (kbd "R")           'xpdfremote/xpdf-reload)
    (define-key map (kbd "f")           'xpdfremote/xpdf-find)
    (define-key map (kbd "F")           'xpdfremote/xpdf-find)
    (define-key map (kbd "C-f")         'xpdfremote/xpdf-find)
    (define-key map (kbd "C-g")         'xpdfremote/xpdf-findNext)
    (define-key map (kbd "C-p")         'xpdfremote/xpdf-print)
    (define-key map (kbd "n")           'xpdfremote/xpdf-nextPage)
    (define-key map (kbd "N")           'xpdfremote/xpdf-nextPage)
    (define-key map (kbd "n")           'xpdfremote/xpdf-nextPageNoScroll)
    (define-key map (kbd "N")           'xpdfremote/xpdf-nextPageNoScroll)
    (define-key map (kbd "p")           'xpdfremote/xpdf-prevPage)
    (define-key map (kbd "P")           'xpdfremote/xpdf-prevPage)
    (define-key map (kbd "p")           'xpdfremote/xpdf-prevPageNoScroll)
    (define-key map (kbd "P")           'xpdfremote/xpdf-prevPageNoScroll)
    (define-key map (kbd "v")           'xpdfremote/xpdf-goForward)
    (define-key map (kbd "b")           'xpdfremote/xpdf-goBackward)
    (define-key map (kbd "g")           'xpdfremote/xpdf-focusToPageNum)
    (define-key map (kbd "0")           'xpdfremote/xpdf-zoomPercent_125)
    (define-key map (kbd "+")           'xpdfremote/xpdf-zoomIn)
    (define-key map (kbd "-")           'xpdfremote/xpdf-zoomOut)
    (define-key map (kbd "z")           'xpdfremote/xpdf-zoomFitPage)
    (define-key map (kbd "w")           'xpdfremote/xpdf-zoomFitWidth)
    (define-key map (kbd "M-f")         'xpdfremote/xpdf-toggleFullScreenMode)
    (define-key map (kbd "C-l")         'xpdfremote/xpdf-redraw)
    (define-key map (kbd "C-w")         'xpdfremote/xpdf-closeWindow)
    (define-key map (kbd "?")           'xpdfremote/xpdf-about)
    (define-key map (kbd "q")           'xpdfremote/xpdf-quit)
    (define-key map (kbd "Q")           'xpdfremote/xpdf-quit)
    ))

;; "C-<home>"    gotoPage_1
;; "<home>"      scrollToTopLeft
;; "C-<end>"     gotoLastPage
;; "<end>"       scrollToBottomRight
;; "<prev>"      pageUp
;; "<backspace>" pageUp
;; "<delete>"    pageUp
;; "<next>"      pageDown
;; "<space>"     pageDown
;; "<left>"      scrollLeft_16
;; "<right>"     scrollRight_16
;; "<up>"        scrollUp_16
;; "<down>"      scrollDown_16
;; "o"           open
;; "O"           open
;; "r"           reload
;; "R"           reload
;; "f"           find
;; "F"           find
;; "C-f"         find
;; "C-g"         findNext
;; "C-p"         print
;; "n"           nextPage
;; "N"           nextPage
;; "n"           nextPageNoScroll
;; "N"           nextPageNoScroll
;; "p"           prevPage
;; "P"           prevPage
;; "p"           prevPageNoScroll
;; "P"           prevPageNoScroll
;; "v"           goForward
;; "b"           goBackward
;; "g"           focusToPageNum
;; "0"           zoomPercent_125
;; "+"           zoomIn
;; "-"           zoomOut
;; "z"           zoomFitPage
;; "w"           zoomFitWidth
;; "M-f"         toggleFullScreenMode
;; "C-l"         redraw
;; "C-w"         closeWindow
;; "?"           about
;; "q"           quit
;; "Q"           quit
























;; xpdf functions:
(defun xpdfremote/xpdf-gotoPage (page)
  (interactive)
  "Go to the specified page."
  (xpdfremote/send-command (concat "gotoPage(" page ")")))

(defun xpdfremote/xpdf-gotoPage_1 ()
  (interactive)
  "Go to page 1."
  (xpdfremote/send-command "gotoPage(1)"))

(defun xpdfremote/xpdf-gotoPageNoScroll (page)
  (interactive)
  "Go to the specified page, with the current relative scroll position."
  (xpdfremote/send-command (concat "gotoPageNoScroll(" page ")")))

(defun xpdfremote/xpdf-gotoDest (dest)
  (interactive)
  "Go to a named destination."
  (xpdfremote/send-command (concat "gotoDest(" dest ")")))

(defun xpdfremote/xpdf-gotoLastPage ()
  (interactive)
  "Go to the last page in the PDF file."
  (xpdfremote/send-command "gotoLastPage"))

(defun xpdfremote/xpdf-gotoLastPageNoScroll ()
  (interactive)
  "Go to the last page in the PDF file, with the current relative scroll position."
  (xpdfremote/send-command "gotoLastPageNoScroll"))

(defun xpdfremote/xpdf-nextPage ()
  (interactive)
  "Go to the next page."
  (xpdfremote/send-command "nextPage"))

(defun xpdfremote/xpdf-nextPageNoScroll ()
  (interactive)
  "Go to the next page, with the current relative scroll position."
  (xpdfremote/send-command "nextPageNoScroll"))

(defun xpdfremote/xpdf-prevPage ()
  (interactive)
  "Go to the previous page."
  (xpdfremote/send-command "prevPage"))

(defun xpdfremote/xpdf-prevPageNoScroll ()
  (interactive)
  "Go to the previous page, with the current relative scroll position."
  (xpdfremote/send-command "prevPageNoScroll"))

(defun xpdfremote/xpdf-pageUp ()
  (interactive)
  "Scroll up by one screenful."
  (xpdfremote/send-command "pageUp"))

(defun xpdfremote/xpdf-pageDown ()
  (interactive)
  "Scroll down by one screenful."
  (xpdfremote/send-command "pageDown"))

(defun xpdfremote/xpdf-scrollLeft (n)
  (interactive)
  "Scroll left by n pixels."
  (xpdfremote/send-command (concat "scrollLeft(" n ")")))

(defun xpdfremote/xpdf-scrollLeft_16 ()
  (interactive)
  "Scroll left by 16 pixels."
  (xpdfremote/send-command "scrollLeft(16)"))

(defun xpdfremote/xpdf-scrollRight (n)
  (interactive)
  "Scroll right by n pixels."
  (xpdfremote/send-command (concat "scrollRight(" n ")")))

(defun xpdfremote/xpdf-scrollRight_16 ()
  (interactive)
  "Scroll right by 16 pixels."
  (xpdfremote/send-command "scrollRight(16)"))

(defun xpdfremote/xpdf-scrollUp (n)
  (interactive)
  "Scroll up by n pixels."
  (xpdfremote/send-command (concat "scrollUp(" n ")")))

(defun xpdfremote/xpdf-scrollUp_16 ()
  (interactive)
  "Scroll up by 16 pixels."
  (xpdfremote/send-command "scrollUp(16)"))

(defun xpdfremote/xpdf-scrollDown (n)
  (interactive)
  "Scroll down by n pixels."
  (xpdfremote/send-command (concat "scrollDown(" n ")")))

(defun xpdfremote/xpdf-scrollDown_16 ()
  (interactive)
  "Scroll down by 16 pixels."
  (xpdfremote/send-command "scrollDown(16)"))

(defun xpdfremote/xpdf-scrollUpPrevPage (n)
  (interactive)
  "Scroll up by n pixels, moving to the previous page if appropriate."
  (xpdfremote/send-command (concat "scrollUpPrevPage(" n ")")))

(defun xpdfremote/xpdf-scrollDownPrevPage (n)
  (interactive)
  "Scroll down by n pixels, moving to the next page if appropriate."
  (xpdfremote/send-command (concat "scrollDownPrevPage(" n ")")))

(defun xpdfremote/xpdf-scrollToTopEdge ()
  (interactive)
  "Scroll to the top edge of the current page, with no horizontal movement."
  (xpdfremote/send-command "scrollToTopEdge"))

(defun xpdfremote/xpdf-scrollToBottomEdge ()
  (interactive)
  "Scroll to the bottom edge of the current page, with no horizontal movement."
  (xpdfremote/send-command "scrollToBottomEdge"))

(defun xpdfremote/xpdf-scrollToLeftEdge ()
  (interactive)
  "Scroll to the left edge of the current page, with no vertical movement."
  (xpdfremote/send-command "scrollToLeftEdge"))

(defun xpdfremote/xpdf-scrollToRightEdge ()
  (interactive)
  "Scroll to the right edge of the current page, with no vertical movement."
  (xpdfremote/send-command "scrollToRightEdge"))

(defun xpdfremote/xpdf-scrollToTopLeft ()
  (interactive)
  "Scroll to the top-left corner of the current page."
  (xpdfremote/send-command "scrollToTopLeft"))

(defun xpdfremote/xpdf-scrollToBottomRight ()
  (interactive)
  "Scroll to the bottom-right corner of the current page."
  (xpdfremote/send-command "scrollToBottomRight"))

(defun xpdfremote/xpdf-goForward ()
  (interactive)
  "Move forward along the history path."
  (xpdfremote/send-command "goForward"))

(defun xpdfremote/xpdf-goBackward ()
  (interactive)
  "Move backward along the history path."
  (xpdfremote/send-command "goBackward"))

(defun xpdfremote/xpdf-zoomPercent (z)
  (interactive)
  "Set the zoom factor to z%."
  (xpdfremote/send-command (concat "zoomPercent(" z ")")))

(defun xpdfremote/xpdf-zoomPercent_125 ()
  (interactive)
  "Set the zoom factor to 125%."
  (xpdfremote/send-command "zoomPercent(125)"))

(defun xpdfremote/xpdf-zoomFitPage ()
  (interactive)
  "Set the zoom factor to fit-page."
  (xpdfremote/send-command "zoomFitPage"))

(defun xpdfremote/xpdf-zoomFitWidth ()
  (interactive)
  "Set the zoom factor to fit-width."
  (xpdfremote/send-command "zoomFitWidth"))

(defun xpdfremote/xpdf-zoomIn ()
  (interactive)
  "Zoom in - go to the next higher zoom factor."
  (xpdfremote/send-command "zoomIn"))

(defun xpdfremote/xpdf-zoomOut ()
  (interactive)
  "Zoom out - go the next lower zoom factor."
  (xpdfremote/send-command "zoomOut"))

(defun xpdfremote/xpdf-rotateCW ()
  (interactive)
  "Rotate the page 90 degrees clockwise."
  (xpdfremote/send-command "rotateCW"))

(defun xpdfremote/xpdf-rotateCCW ()
  (interactive)
  "Rotate the page 90 degrees counterclockwise."
  (xpdfremote/send-command "rotateCCW"))

(defun xpdfremote/xpdf-setSelection (pg ulx uly lrx lry)
  (interactive)
  "Set the selection to the specified coordinates on the specified page."
  (xpdfremote/send-command (concat "setSelection(" pg ulx uly lrx lry ")")))

(defun xpdfremote/xpdf-continuousMode ()
  (interactive)
  "Go to continuous view mode."
  (xpdfremote/send-command "continuousMode"))

(defun xpdfremote/xpdf-singlePageMode ()
  (interactive)
  "Go to single-page view mode."
  (xpdfremote/send-command "singlePageMode"))

(defun xpdfremote/xpdf-toggleContinuousMode ()
  (interactive)
  "Toggle between continuous and single page view modes."
  (xpdfremote/send-command "toggleContinuousMode"))

(defun xpdfremote/xpdf-fullScreenMode ()
  (interactive)
  "Go to full-screen mode."
  (xpdfremote/send-command "fullScreenMode"))

(defun xpdfremote/xpdf-windowMode ()
  (interactive)
  "Go to window (non-full-screen) mode."
  (xpdfremote/send-command "windowMode"))

(defun xpdfremote/xpdf-toggleFullScreenMode ()
  (interactive)
  "Toggle between full-screen and window modes."
  (xpdfremote/send-command "toggleFullScreenMode"))

(defun xpdfremote/xpdf-open ()
  (interactive)
  "Open a PDF file in this window, using the open dialog."
  (xpdfremote/send-command "open"))

(defun xpdfremote/xpdf-openInNewWin ()
  (interactive)
  "Open a PDF file in a new window, using the open dialog."
  (xpdfremote/send-command "openInNewWin"))

(defun xpdfremote/xpdf-openFile (file)
  (interactive)
  "Open a specified PDF file in this window."
  (xpdfremote/send-command (concat "openFile(" file ")")))

(defun xpdfremote/xpdf-openFileInNewWin (file)
  (interactive)
  "Open a specified PDF file in a new window."
  (xpdfremote/send-command (concat "openFileInNewWin(" file ")")))

(defun xpdfremote/xpdf-openFileAtDest (file dest)
  (interactive)
  "Open a specified PDF file in this window and go to a named destination."
  (xpdfremote/send-command (concat "openFileAtDest(" file dest ")")))

(defun xpdfremote/xpdf-openFileAtDestInNewWin (file dest)
  (interactive)
  "Open a specified PDF file in a new window and go to a named destination."
  (xpdfremote/send-command (concat "openFileAtDestInNewWin(" file dest ")")))

(defun xpdfremote/xpdf-reload ()
  (interactive)
  "Reload the current PDF file."
  (xpdfremote/send-command "reload"))

(defun xpdfremote/xpdf-redraw ()
  (interactive)
  "Redraw the window."
  (xpdfremote/send-command "redraw"))

(defun xpdfremote/xpdf-raise ()
  (interactive)
  "Raise the window to the front."
  (xpdfremote/send-command "raise"))

(defun xpdfremote/xpdf-closeWindow ()
  (interactive)
  "Close the window."
  (xpdfremote/send-command "closeWindow"))

;; (defun run(external-command-string) ()
;;   (interactive)
;; Run an external command.  The following escapes are allowed in the command string:

;;     %f => PDF file name (or an empty string if no
;;           file is open)
;;     %b => PDF file base name, i.e., file name minus
;;           the extension (or an empty string if no
;;           file is open)
;;     %u => link URL (or an empty string if not over
;;           a URL link)
;;     %p => current page number (or an empty string if
;;           no file is open)
;;     %x => selection upper-left x coordinate
;;           (or 0 if there is no selection)
;;     %y => selection upper-left y coordinate
;;           (or 0 if there is no selection)
;;     %X => selection lower-right x coordinate
;;           (or 0 if there is no selection)
;;     %Y => selection lower-right y coordinate
;;           (or 0 if there is no selection)
;;     %i => page containing the mouse pointer
;;     %j => x coordinate of the mouse pointer
;;     %k => y coordinate of the mouse pointer
;;     %% => %

(defun xpdfremote/xpdf-openOutline ()
  (interactive)
  "Open the outline pane."
  (xpdfremote/send-command "openOutline"))

(defun xpdfremote/xpdf-closeOutline ()
  (interactive)
  "Close the outline pane."
  (xpdfremote/send-command "closeOutline"))

(defun xpdfremote/xpdf-toggleOutline ()
  (interactive)
  "Toggle the outline pane between open and closed."
  (xpdfremote/send-command "toggleOutline"))

(defun xpdfremote/xpdf-scrollOutlineDown (n)
  (interactive)
  "Scroll the outline down by n increments."
  (xpdfremote/send-command (concat "scrollOutlineDown(" n ")")))

(defun xpdfremote/xpdf-scrollOutlineUp (n)
  (interactive)
  "Scroll the outline up by n increments."
  (xpdfremote/send-command (concat "scrollOutlineUp(" n ")")))

(defun xpdfremote/xpdf-focusToDocWin ()
  (interactive)
  "Set the keyboard focus to the main document window."
  (xpdfremote/send-command "focusToDocWin"))

(defun xpdfremote/xpdf-focusToPageNum ()
  (interactive)
  "Set the keyboard focus to the page number text box."
  (xpdfremote/send-command "focusToPageNum"))

(defun xpdfremote/xpdf-find ()
  (interactive)
  "Open the 'find' dialog."
  (xpdfremote/send-command "find"))

(defun xpdfremote/xpdf-findNext ()
  (interactive)
  "Finds the next occurrence of the search string (no dialog)."
  (xpdfremote/send-command "findNext"))

(defun xpdfremote/xpdf-print ()
  (interactive)
  "Open the 'print' dialog."
  (xpdfremote/send-command "print"))

(defun xpdfremote/xpdf-about ()
  (interactive)
  "Open the 'about' dialog."
  (xpdfremote/send-command "about"))

(defun xpdfremote/xpdf-quit   ()
  (interactive)
  "Quit from xpdf."
  (xpdfremote/send-command "quit  "))




;; The following commands depend on the current mouse position:

;; startSelection
;;        Start a selection, which will be extended as the mouse moves.

;; endSelection
;;        End a selection.

;; startPan
;;        Start a pan, which will scroll the document as the mouse moves

;; endPan End a pan.

;; postPopupMenu
;;        Display the popup menu.

;; followLink
;;        Follow a hyperlink (does nothing if the mouse is not over a link).

;; followLinkInNewWin
;;        Follow  a hyperlink, opening PDF files in a new window (does nothing if the mouse is not over a
;;        link).  For links to non-PDF files, this command is identical to followLink.

;; followLinkNoSel
;;        Same as followLink, but does nothing if there is a non-empty selection.  (This is useful  as  a
;;        mouse button binding.)

;; followLinkInNewWinNoSel
;;        Same  as followLinkInNewWin, but does nothing if there is a non-empty selection.  (This is use‐
;;        ful as a mouse button binding.)

(provide 'xpdfremote)
