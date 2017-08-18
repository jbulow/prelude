; -*- mode: Lisp; tab-width: 2; -*-
;;; Emacs Load Path

;; http://milkbox.net/note/single-file-master-emacs-configuration/
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;;(require 'cl) ;; Common Lisp

;;
;; Prelude
;;

;; guru

(defun disable-guru-mode ()
  (guru-mode -1))
(add-hook 'prelude-prog-mode-hook 'disable-guru-mode t)

;; smartparen
(add-hook 'prelude-prog-mode-hook 
          (lambda ()
            (turn-off-smartparens-mode)
            (turn-off-show-smartparens-mode))) 

;; Turn off whitespace mode.
(setq prelude-whitespace nil)

;;
;; org-mode
;;
(require 'org-install)
;;(require 'org-latex)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-font-lock-mode 1)                     ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")

;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;;
;; etags related
;;
(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

;; Ido stuff
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))

(global-set-key [f9] 'ido-find-file-in-tag-files)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;;
;; Other variables
;; 
;;(setq mac-option-modifier 'none)
;;(setq ns-command-modifier 'meta)
(fset 'yes-or-no-p 'y-or-n-p)
(setq cua-enable-cua-keys nil)
(setq default-major-mode 'text-mode)
(setq emerge-diff-options "--ignore-all-space")
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq preview-auto-cache-preamble t)
(setq query-replace-highlight t)
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)
(transient-mark-mode t)

;; Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 5)

;; will make "Ctrl-k" kills an entire line if the cursor is at the beginning of line
(setq kill-whole-line t)

;; will delete "hungrily" in C mode
(setq c-hungry-delete-key t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; Source:  http://www-db.stanford.edu/~manku/dotemacs.html

;;(setq require-final-newline t)
(fset 'yes-or-no-p 'y-or-n-p)

;; will introduce spaces instead of tabs by default.
;; (setq-default indent-tabs-mode nil)
;; (setq c-basic-offset 2)

;; will highlight during query.
(setq query-replace-highlight t)

;;highlight incremental search
(setq search-highlight t)

;; will make text-mode default.
(setq default-major-mode 'text-mode)

;; denotes our interest in maximum possible fontification.
(setq font-lock-maximum-decoration t)

;; allow recursive editing in minibuffer
(setq enable-recursive-minibuffers t)

;; Make unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(require 'dropdown-list)
(setq yas/prompt-functions
      '(yas/dropdown-prompt
        yas/ido-prompt
        yas/x-prompt
        yas/completing-prompt
        yas/no-prompt))

;;
;; Hippie-expand
;;
(require 'hippie-exp)

(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-lisp-symbol))


;; ----------------------------------------------------------- [ ibuffer ]
;; *Nice* buffer switching
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-saved-filter-groups
      '(("default"
         ("version control" (or (mode . svn-status-mode)
                    (mode . svn-log-edit-mode)
                    (name . "^\\*svn-")
                    (name . "^\\*vc\\*$")
                    (name . "^\\*Annotate")
                    (name . "^\\*git-")
                    (name . "^\\*vc-")))
         ("emacs" (or (name . "^\\*scratch\\*$")
                      (name . "^\\*Messages\\*$")
                      (name . "^TAGS\\(<[0-9]+>\\)?$")
                      (name . "^\\*Help\\*$")
                      (name . "^\\*info\\*$")
                      (name . "^\\*Occur\\*$")
                      (name . "^\\*grep\\*$")
                      (name . "^\\*Compile-Log\\*$")
                      (name . "^\\*Backtrace\\*$")
                      (name . "^\\*Process List\\*$")
                      (name . "^\\*gud\\*$")
                      (name . "^\\*Man")
                      (name . "^\\*WoMan")
                      (name . "^\\*Kill Ring\\*$")
                      (name . "^\\*Completions\\*$")
                      (name . "^\\*tramp")
                      (name . "^\\*shell\\*$")
                      (name . "^\\*compilation\\*$")))
         ("emacs source" (or (mode . emacs-lisp-mode)
                             (filename . "/Applications/Emacs.app")
                             (filename . "/bin/emacs")))
         ("agenda" (or (name . "^\\*Calendar\\*$")
                       (name . "^diary$")
                       (name . "^\\*Agenda")
                       (name . "^\\*org-")
                       (name . "^\\*Org")
                       (mode . org-mode)
                       (mode . muse-mode)))
         ("latex" (or (mode . latex-mode)
                      (mode . LaTeX-mode)
                      (mode . bibtex-mode)
                      (mode . reftex-mode)))
         ("dired" (or (mode . dired-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Order the groups so the order is : [Default], [agenda], [emacs]
(defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups ()
                                            activate)
  (setq ad-return-value (nreverse ad-return-value)))

;;;
;;; Pager
;;;

(require 'pager)
(global-set-key "\C-v"     'pager-page-down)
(global-set-key [next]     'pager-page-down)
(global-set-key "\ev"      'pager-page-up)
(global-set-key [prior]    'pager-page-up)
(global-set-key '[M-up]    'pager-row-up)
(global-set-key '[M-kp-8]  'pager-row-up)
(global-set-key '[M-down]  'pager-row-down)
(global-set-key '[M-kp-2]  'pager-row-down)


;;
;; cc-mode
;;
(require 'cc-mode)

;;(setq compilation-window-height 8)

;; (setq compilation-finish-function
;;       (lambda (buf str)
;;         (if (string-match "exited abnormally" str)
;;             ;;there were errors
;;             (message "compilation errors, press C-x ` to visit")
;;           ;;no errors, make the compilation window go away in 0.5 seconds
;;           (run-at-time 0.5 nil 'delete-windows-on buf)
;;           (message "NO COMPILATION ERRORS!"))))

;; Customizing indentation
;;
;; First of all, put (require 'cc-mode) atop the C customization section
;; of your ~/.emacs, so the methods below will be defined. Then, while
;; visiting a C source file, if you don't like how a particular line is
;; indenting, press C-c C-o near the expression you want to change, and
;; figure out the symbol to change (pressing C-c C-o gives you a chance
;; to set these variables interactively). Then, do a
;; (c-set-offset 'symbol-to-change X) in your ~/.emacs where X is
;; typically a numeric value or the symbol '+ or '-. The following is an
;; example of some of my customizations, which is simply my personal
;; preference:
(c-set-offset 'substatement-open 0)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'topmost-intro-cont '+)
(c-set-offset 'inline-open 0)
(c-set-offset 'innamespace 0)
(c-set-offset 'substatement-open 0)

;; ;; Here's a sample .emacs file fragment that might help you along the
;; ;; way.  Just copy this region and paste it into your .emacs file.
;; ;; You might want to change some of the actual values.

;; ;; Make some non-standard key bindings.  We can put these in
;; ;; c-mode-base-map because c-mode-map, c++-mode-map, and so on,
;; ;; inherit from it.
;; (defun my-c-initialization-hook ()
;;   (define-key c-mode-base-map "\C-m" 'c-context-line-break)
;;   (define-key c-mode-base-map [?\C-\M-a] 'c-beginning-of-defun)
;;   (define-key c-mode-base-map [?\C-\M-e] 'c-end-of-defun)
;; (add-hook 'c-initialization-hook 'my-c-initialization-hook)

;; ;; offset customizations not in my-c-style
;; ;; This will take precedence over any setting of the syntactic symbol
;; ;; made by a style.
;; (setq c-offsets-alist '((member-init-intro . ++)))

;; ;; Create my personal style.
;; (defconst my-c-style
;;   '((c-tab-always-indent        . t)
;;     (c-comment-only-line-offset . 4)
;;     (c-hanging-braces-alist     . ((substatement-open after)
;;                                    (brace-list-open)))
;;     (c-hanging-colons-alist     . ((member-init-intro before)
;;                                    (inher-intro)
;;                                    (case-label after)
;;                                    (label after)
;;                                    (access-label after)))
;;     (c-cleanup-list             . (scope-operator
;;                                    empty-defun-braces
;;                                    defun-close-semi))
;;     (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
;;                                    (substatement-open . 0)
;;                                    (case-label        . 4)
;;                                    (block-open        . 0)
;;                                    (knr-argdecl-intro . -)))
;;     (c-echo-syntactic-information-p . t))
;;   "My C Programming Style")
;; (c-add-style "PERSONAL" my-c-style)

;; ;; Customizations for all modes in CC Mode.
;; (defun my-c-mode-common-hook ()
;;   ;; set my personal style for the current buffer
;;   (c-set-style "PERSONAL")
;;   ;; other customizations
;;   (setq tab-width 8
;;         ;; this will make sure spaces are used instead of tabs
;;         indent-tabs-mode nil)
;;   ;; we like auto-newline, but not hungry-delete
;;   (c-toggle-auto-newline 1))
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;; (autoload 'ibuffer "ibuffer" "List buffers." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; google C Style
;; todo: replace generic cc-mode above
;;
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
;;
;; If you want the RETURN key to go to the next line and space over
;; to the right place, add this to your .emacs right after the load-file:
;;
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;
;; Fast Find other File
;;

(setq ff-other-file-alist
      '(("\\.cc\\'"  (".hh" ".h"))
        ("\\.hh\\'"  (".cpp" ".cc" ".C"))

        ("\\.c\\'"   (".h"))
        ("\\.h\\'"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.m\\'"    (".h"))
        ("\\.mm\\'"    (".h"))

        ("\\.C\\'"   (".H"  ".hh" ".h"))
        ("\\.H\\'"   (".C"  ".CC"))

        ("\\.CC\\'"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH\\'"  (".CC"))

        ("\\.c\\+\\+\\'" (".h++" ".hh" ".h"))
        ("\\.h\\+\\+\\'" (".c++"))

        ("\\.cpp\\'" (".hpp" ".hh" ".h"))
        ("\\.hpp\\'" (".cpp"))

        ("\\.cxx\\'" (".hxx" ".hh" ".h"))
        ("\\.hxx\\'" (".cxx"))))


(defun my-c-initialization-hook ()
  (define-key c-mode-base-map "\C-o" 'ff-find-other-file))

(add-hook 'c-mode-common-hook 'my-c-initialization-hook)

(add-to-list 'load-path (expand-file-name "~/emacs/find-things-fast"))
(require 'find-things-fast)
;; (global-set-key '[f1] 'ftf-find-file)
;; (global-set-key '[f2] 'ftf-grepsource)
;; (global-set-key '[f4] 'ftf-gdb)
;; (global-set-key '[f5] 'ftf-compile)

(setq ff-search-directories
      '("."
        "../../source/*"
        "../interface/*"
        "../include/*"
        "../../interface/*"
        "../../include/*"))

(global-set-key '[S-f7]  'compile)
(global-set-key '[C-f7] 'kill-compilation)
(global-set-key '[M-f7] 'recompile)

 ; Make Emacs use "newline-and-indent" when you hit the Enter key so
 ; that you don't need to keep using TAB to align yourself when coding.
(global-set-key "\C-m"        'newline-and-indent)

 ; capitalize current word (for example, C constants)
(global-set-key "\M-u"        '(lambda () (interactive) (backward-word 1) (upcase-word 1)))

;; (add-hook 'c-mode-common-hook
;;           '(lambda ()
;;              (turn-on-auto-fill)
;;              (setq fill-column 80)
;;              (setq comment-column 60)
;;              (modify-syntax-entry ?_ "w")       ; now '_' is not considered a word-delimiter
;;              (c-set-style "ellemtel")           ; set indentation style
;;              (local-set-key [(control tab)]     ; move to next tempo mark
;;                             'tempo-forward-mark)
;;              ))

(setq auto-mode-alist
      (append '(("\\.h$" . c++-mode)) auto-mode-alist))

;;
;; Emacs-lisp-mode Improvements
;;

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (modify-syntax-entry ?- "w")       ; now '-' is not considered a word-delimiter
             ))

(put 'upcase-region 'disabled nil)

(add-to-list 'auto-mode-alist
             (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss" "xaml") t) "\\'")
                   'nxml-mode))

(unify-8859-on-decoding-mode)

(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
            magic-mode-alist))
(fset 'xml-mode 'nxml-mode)
(fset 'html-mode 'nxml-mode)

(put 'scroll-left 'disabled nil)

;;
;; SQLite
;;
(setq sql-sqlite-program "/usr/bin/sqlite3")
(setq sql-user nil)
(setq sql-password nil)

;;
;; ediff
;;
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;
;; Lua
;;
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-hook 'lua-mode-hook 'turn-on-font-lock)
(add-hook 'lua-mode-hook 'hs-minor-mode)

;;
;; company-mode
;;

;; (autoload 'company-mode "company" nil t)
;; (put 'downcase-region 'disabled nil)
;; 


;;  When activated, it allows to “undo” (and “redo”) changes in the
;;  window configuration with the key commands ‘C-c left’ and ‘C-c
;;  right’
(winner-mode 1)

;;
;; recent file mode
;;

(require 'recentf)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; enable recent files mode.
(recentf-mode t)

; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;;
;; Whitespace
;;
(require 'whitespace)
(setq whitespace-style '(face indentation trailing empty lines-tail))
(setq whitespace-line-column nil)
(set-face-attribute 'whitespace-line nil
                    :background "purple"
                    :foreground "white"
                    :weight 'bold)
;; (global-whitespace-mode 1)
(global-flycheck-mode nil)

;; Improve zap-to-char (M-z) by not deleting the boundary character
;; I.e zap-to-char '>' on <Xabcdef> (cursor on X) gives <>.
(defadvice zap-to-char (after my-zap-to-char-advice (arg char) activate)
  "Kill up to the ARG'th occurence of CHAR, and leave CHAR.
  The CHAR is replaced and the point is put before CHAR."
  (insert char)
  (forward-char -1))

;;  The function below is funky but useful. Having swapped the pairs
;;  ('[', '{'), ('-', '_') and (']', '}'), in order to type "->", we
;;  need to type four characters ('Shift' followed by '-' followed by
;;  'Shift' followed by '>'). With the above code, all you need to
;;  type is two underscores: '__'). Automagically, they are converted
;;  into '->'). Similarly, two successive dots '..' are translated
;;  into '[]' (for array indexing). I find that these combinations
;;  improve my code-typing speed significantly.


(defun my-editing-function (first last len)
  (interactive)
  (if (and (boundp 'major-mode)
           (member major-mode (list 'c-mode 'c++-mode 'gud-mode 'fundamental-mode 'ruby-mode))
           (= len 0)
           (> (point) 4)
           (= first (- (point) 1)))
      (cond
       ((and (string-equal (buffer-substring (point) (- (point) 2)) "__")
             (not (string-equal (buffer-substring (point) (- (point) 3)) "___")))
        (progn (delete-backward-char 2) (insert-char ?- 1) (insert-char ?> 1)))

       ((string-equal (buffer-substring (point) (- (point) 3)) "->_")
        (progn (delete-backward-char 3) (insert-char ?_ 3)))

       ((and (string-equal (buffer-substring (point) (- (point) 2)) "..")
             (not (string-equal (buffer-substring (point) (- (point) 3)) "...")))
        (progn (delete-backward-char 2) (insert-char ?[ 1) (insert-char ?] 1) (backward-char 1)))

       ((and (string-equal (buffer-substring (point) (- (point) 2)) ",,")
             (not (string-equal (buffer-substring (point) (- (point) 3)) ",,,")))
        (progn (delete-backward-char 2) (insert-char ?{ 1) (insert-char ?} 1) (backward-char 1)))

       ((and (> (point-max) (point))
             (string-equal (buffer-substring (+ (point) 1) (- (point) 2)) "[.]"))
        (progn (forward-char 1) (delete-backward-char 3) (insert-char ?. 1) (insert-char ?. 1) ))
       )
    nil))

(add-hook 'after-change-functions 'my-editing-function)

;;
;; gud-mode (debugging with gdb)
;;
(setq gdb-many-windows nil)

(add-hook 'gud-mode-hook
          '(lambda ()
             (local-set-key [home]        ; move to beginning of line, after prompt
                            'comint-bol)
             (local-set-key [up]          ; cycle backward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-previous-input 1)
                                 (previous-line 1))))
             (local-set-key [down]        ; cycle forward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-next-input 1)
                                 (forward-line 1))))
             ))

;; recenter source window when stepping code
(defadvice gud-display-line (after gud-display-line-centered activate)
  "Center the line in the window"
  (when (and gud-overlay-arrow-position gdb-source-window)
    (with-selected-window gdb-source-window
      ; (marker-buffer gud-overlay-arrow-position)
      (save-restriction
        (goto-line (ad-get-arg 1))
        (recenter)))))

;;
;; Jump to matching paren if on a paren
;;
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)

;;
;; auctex
;;
;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)

(setq TeX-save-query nil) ;;autosave before compiling

(add-hook 'LaTeX-mode-hook '(lambda ()
                              (TeX-fold-mode 1)
                              (outline-minor-mode 1)
                              ))

(add-hook 'LaTeX-mode-hook '(lambda () (setq fill-column 72)))
;;(add-hook 'LaTeX-mode-hook '(lambda () (setq TeX-DVI-via-PDFTeX t)))


;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)


;; (require 'tex-site)
;; (server-start)
;; (add-hook 'server-switch-hook
;;           (lambda nil
;;             (let ((sevrver-buf (current-buffer)))
;;               (bury-buffer)
;;               (switch-to-buffer-other-frame server-buf))))

;; (add-hook 'server-done-hook (lambda nil (kill-buffer nil)))

;; (setq TeX-output-view-style
;;       (quote
;;         (
;;          ("^dvi$" "." "/Applications/MacPorts/Emacs.app/Contents/MacOS/bin/emacsclient %o")
;;          ("^pdf$" "." "/Applications/MacPorts/Emacs.app/Contents/MacOS/bin/emacsclient %o")
;;          ("^html?$" "." "open -A Safari.app %o")
;;          )
;;         )
;;        )

(load "server")
(unless (server-running-p) (server-start))

;; gdb mode does not work well with large c++ executables withour this
(setq gdb-create-source-file-list nil)

;; Consider
;; (setq mac-command-modifier 'meta)
;; (setq mac-option-modifier 'super)
;;
;; Load own packages:
;; (prelude-require-packages '(some-package some-other-package))
;;
;; whitespace-mode: configure long-line-style
;;
;; ido: add this in case of slow performance
;; (setq flx-ido-threshhold 1000)
;;
;; 

(setq flycheck-disable-checkers '(make))

(setq python-shell-interpreter "python3.4")

(defun my-c-mode-hook ()
  (setq c-basic-offset 2))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(defun disable-smartparens ()
  (smartparens-mode 0))

(add-hook 'c-mode-common-hook 'disable-smartparens)

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
  )

;; (autoload 'octave-mode "octave-mod" nil t)
;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))
(remove-hook 'prog-mode 'flycheck-mode)

(remove-hook 'prog-mode 'flycheck-mode)

(setq flycheck-disable-checkers '(make))

;; Hardcode shell to /bin/sh. Fixes problem with rgrep etc. when fish is used as shell.
(setq shell-file-name "/bin/sh")

(sml/setup)

(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; toggle between most recent buffers                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://www.emacswiki.org/emacs/SwitchingBuffers#toc5
(defun switch-to-previous-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; set key binding
(global-set-key (kbd "C-'") 'switch-to-previous-buffer)

;; (require 'prelude-helm-everywhere)

;; https://www.reddit.com/r/emacs/comments/3ricev/tip_for_when_you_are_running_out_of_easytopress/
;; https://www.reddit.com/r/emacs/comments/3rd0x8/tips_for_going_full_emacs_after_spacemacs/
;;
;; https://www.reddit.com/r/emacs/comments/3s4k03/how_many_packages_do_you_use/
;; https://www.reddit.com/r/emacs/comments/3r8fql/is_there_spacemacs_key_binding_sheetchart/
;;
;; https://www.reddit.com/r/emacs/comments/3rxfr5/xclip_copypaste_killyank_and_emacs_in_a_terminal/
;; https://www.reddit.com/r/emacs/comments/3s0hjo/how_to_get_an_arglist_like_editing_using_emacs/
;; https://www.reddit.com/r/emacs/comments/3rom3t/tutorial_for_how_to_make_ido_or_helm_menu/
;; https://www.reddit.com/r/emacs/comments/3rqvwn/autocompletion_for_c_with_external_library/
;; https://www.reddit.com/r/emacs/comments/3rqvwn/autocompletion_for_c_with_external_library/
;; https://www.reddit.com/r/emacs/comments/3rjt3p/webmodeel_v13_is_released/
;; https://www.reddit.com/r/emacs/comments/3r9fic/best_practicestip_for_companymode_andor_yasnippet/
;; http://www.mostlymaths.net/2015/11/synctex-and-pdf-view-mode-for-emacs.html
;; http://oremacs.com/2015/04/16/ivy-mode/
;; https://www.reddit.com/r/emacs/comments/331gqp/introducing_ivymode_or_emacs/
;; 

(setq auto-mode-alist
      (append
       '(("\\.tikz\\'" . latex-mode))
       auto-mode-alist))

;; (global-unset-key "\C-z")
;; (global-unset-key "\C-x\C-z")
;; (put 'suspend-frame 'disabled t)
(global-unset-key (kbd "C-z"))

;;(set 'pop-up-frames 'graphic-only)
(set 'gdb-use-separate-io-buffer nil)
(set 'gdb-many-windows nil)
(set 'org-agenda-window-setup 'other-frame)
(set 'org-src-window-setup 'other-frame)
;; Focus follows mouse off to prevent crazy things happening when I click on
;; e.g. compilation error links.
(set 'mouse-autoselect-window nil)
(set 'focus-follows-mouse nil)
;; kill frames when a buffer is buried, makes most things play nice with
;; frames
;;(set 'frame-auto-hide-function 'delete-frame)

 ; You need install the ClI brower 'w3m' and Emacs plugin 'w3m'
(setq mm-text-html-renderer 'w3m)

(setq gnuplot-program "/home/jonasbu/local/bin/gnuplot")
