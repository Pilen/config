;(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
(require 'jde)
(add-to-list 'auto-mode-alist '("\\.java\\'" . jde-mode))

(defun jde-compile-get-javac ()
  "Function overwritten to simply use older version
of java automaticly instead of asking."
  (let* ((jdk-version (jde-java-version))
         (jdk-split-version (split-string jdk-version "[.]"))
         (jdk-major-version (nth 0 jdk-split-version))
         (jdk-minor-version (nth 1 jdk-split-version))
         (compiler
          (find-if
           (lambda (compiler-x)
             (let* ((compiler-split-version (split-string (oref compiler-x :version) "[.]"))
                    (compiler-major-version (nth 0 compiler-split-version))
                    (compiler-minor-version (nth 1 compiler-split-version)))
               (and
                (string= jdk-major-version compiler-major-version)
                (string= jdk-minor-version compiler-minor-version))))
           jde-compile-javac-compilers)))
    (unless compiler
      (let ((latest-javac (car (last jde-compile-javac-compilers))))
        (setq compiler latest-javac)))
    (if compiler
        (if (string= (car jde-compiler) "javac server")
            (oset compiler :use-server-p t)
          (progn
            (oset compiler :use-server-p nil)
            (oset compiler
                  :path
                  (let ((compiler-path
                         (if (listp (car jde-compiler))
                             (substitute-in-file-name (nth 1 (car jde-compiler)))
                           "")))
                    (if (string= compiler-path "")
                        (setq compiler-path (jde-get-jdk-prog 'javac))
                      (if (file-exists-p compiler-path)
                          compiler-path
                        (error (format "Invalid compiler path %s"
                                       compiler-path)))))))))
    compiler))


(defun jde-tool-bar-hook ()
  "Create a custom toolbar for jde-mode
tool-bar-mode must be enabled for it to be visible"
  (set (make-local-variable 'tool-bar-map) (make-sparse-keymap))
  (tool-bar-add-item (concat jde-hacks-dir "/help") 'jde-java-apidocs 'jde-java-apidocs :label "API" :help "Browse the Java documentation")
  (tool-bar-add-item (concat jde-hacks-dir "/compile") 'jde-compile 'jde-compile :label "Compile" :help "Compile current file")
  (tool-bar-add-item (concat jde-hacks-dir "/run") 'jde-run 'jde-run :label "Run" :help "Run app, by calling main method in current file")
  (tool-bar-add-item (concat jde-hacks-dir "/add") 'jde-add-to-makefile 'jde-add-to-makefile :label "add" :help "Add current file to makefile, create it if necessary")
  (tool-bar-add-item (concat jde-hacks-dir "/build") 'jde-build 'jde-build :label "Build" :help "Build current project")
  )

(add-hook 'jde-mode-hook 'jde-tool-bar-hook)

(require 'jde-make)
(defun jde-make ()
  "Updated to use `compilation-start' instead of the older
deprecated `compile-internal' that has been removed in Emacs 24.

Run the make program specified by `jde-make-program' with the
command-line arguments specified by `jde-make-args'. If
`jde-read-make-args' is nonnil, this command also prompts you to enter
make arguments in the minibuffer and passes any arguments that you
enter to the make program along with the arguments specified by
`jde-make-args'."
  (interactive)
  (if jde-read-make-args
      (setq jde-interactive-make-args
              (read-from-minibuffer
               "Make args: "
               jde-interactive-make-args
               nil nil
               '(jde-interactive-make-arg-history . 1)))
    (setq jde-interactive-make-args ""))

  (let ((make-command
         (jde-make-make-command
          jde-interactive-make-args))
        (save-default-directory default-directory)
        (default-directory
          (if (string= jde-make-working-directory "")
              (if jde-make-enable-find
                  (let ((jde-make-buildfile
                         (jde-make-find-build-file default-directory)))
                    (if jde-make-buildfile
                        (file-name-directory jde-make-buildfile)
                      default-directory))
                default-directory)
            (jde-normalize-path 'jde-make-working-directory))))


    ;; Force save-some-buffers to use the minibuffer
    ;; to query user about whether to save modified buffers.
    ;; Otherwise, when user invokes jde-make from
    ;; menu, save-some-buffers tries to popup a menu
    ;; which seems not to be supported--at least on
    ;; the PC.
    (if (and (eq system-type 'windows-nt)
             (not jde-xemacsp))
        (let ((temp last-nonmenu-event))
          ;; The next line makes emacs think that jde-make
          ;; was invoked from the minibuffer, even when it
          ;; is actually invoked from the menu-bar.
          (setq last-nonmenu-event t)
          (save-some-buffers (not compilation-ask-about-save) nil)
          (setq last-nonmenu-event temp))
      (save-some-buffers (not compilation-ask-about-save) nil))

    (setq compilation-finish-functions
      (lambda (buf msg)
        (run-hook-with-args 'jde-make-finish-hook buf msg)
        (setq compilation-finish-functions nil)))

    (cd default-directory)
    ;; (compile-internal make-command "No more errors")
    (compilation-start make-command)
    (cd save-default-directory)))

(defun jde-add-to-makefile ()
  "Add the java file currently being worked on to the makefile.
If no makefile exists, create one."
  (interactive)
  (let ((javafile (file-name-nondirectory (buffer-file-name))))
    (if (not (file-exists-p "makefile"))
        (with-temp-buffer
          (insert (format "
# Java files to be compiled:
FILES = %s

# Java build parameters:

JAVAC = javac

# Don't touch any of the below:

.SUFFIXES: .java .class

.java.class:
\t$(JAVAC) $*.java

default: classes

classes: $(FILES:.java=.class)

clean:
\t$(RM) $(FILES:.java=.class)

all: clean default

" javafile))
          (write-file "makefile"))
      (with-temp-buffer
        (insert-file-contents "makefile")
        (beginning-of-buffer)
        (search-forward-regexp "FILES[ ]*=[ ]*")
        (if (search-forward-regexp javafile (line-end-position) t)
            (message "%s already in makefile" javafile)
          (end-of-line)
          (when (not (string= (string (char-before)) " "))
            (insert " "))
          (insert javafile)
          (write-file "makefile"))))))

;;I hate the fact that jde undoes my carefully crafted custom modeline
(setq jde-mode-line-format mode-line-format)

(defun jde-compile-or-run ()
  "call `jde-compile' or `jde-run' depending on the last
modification time of the .java and the .class files"
  (interactive)
  (save-buffer)
  (let ((javafile (file-name-nondirectory (buffer-file-name))))
    (if (and (file-exists-p "makefile")
             (with-temp-buffer
               (insert-file-contents "makefile")
               (beginning-of-buffer)
               (search-forward-regexp "FILES[ ]*=[ ]*")
               (progn (message "kat") t)
               (search-forward-regexp javafile
                                      (line-end-position) t)))
        (jde-build)
      (when (not (file-exists-p (concat (file-name-sans-extension (buffer-file-name)) ".class")))
        (jde-compile))
      (let* ((java-mtime (nth 5 (file-attributes (buffer-file-name))))
             (classfile (concat (file-name-sans-extension (buffer-file-name)) ".class"))
             (class-mtime (nth 5 (file-attributes classfile))))
        (if (time-less-p java-mtime class-mtime)
            (call-interactively 'jde-run)
          (jde-compile))))))

(defun jde-java-apidocs ()
  (interactive)
  (browse-url "http://docs.oracle.com/javase/7/docs/api/index.html"))

(provide 'jde-hacks)
