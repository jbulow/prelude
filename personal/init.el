; -*- mode: Lisp; tab-width: 2; -*-
;;; Emacs Load Path

(defvar home-dir (cond ((eq system-type 'darwin) "~/")
                       ((eq system-type 'cygwin) "~/")
                       ((eq system-type 'gnu/linux) "~/")
                       ((eq system-type 'windows-nt) "~/")
                       ;;                       ((eq system-type 'windows-nt) (concat "c:/Users/" user-login-name))
                       "My home directory"))

(when (eq system-type 'windows-nt)
  (setq default-directory home-dir))


(defvar dropbox-dir (cond ((eq system-type 'darwin) "~/Dropbox/")
                          ((eq system-type 'cygwin) "~/")
                          ((eq system-type 'gnu/linux) "~/Dropbox/")
                          ((eq system-type 'windows-nt) "~/../../Dropbox/")
                          "My Dropbox directory"))

;; http://milkbox.net/note/single-file-master-emacs-configuration/
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))



(require 'cl) ;; Common Lisp

(defvar emacs-root (concat home-dir "emacs/")
  "My emacs home directory - the root of my personal emacs load-path.")

;;
;; Additional load paths
;;
(labels ((add-path (p)
                   (add-to-list 'load-path
                                (concat emacs-root p))))
  (add-path "")
  (add-path "org-7.8.01/lisp")
  (add-path "org-7.8.01/contrib/lisp")
  (add-path "yasnippet-0.6.1c")
  ;; (add-path "auctex-11.86")
  ;; (add-path "ipa")
  ;; (add-path "anything-config")
)

;;
;; Prelude
;;

;; guru

(defun disable-guru-mode ()
  (guru-mode -1)
  )
(add-hook 'prelude-prog-mode-hook 'disable-guru-mode t)


;; smartparen
(add-hook 'prelude-prog-mode-hook 
          (lambda ()
            (turn-off-smartparens-mode)
            (turn-off-show-smartparens-mode))) 


;; whitespace-mode
;;(setq prelude-whitespace nil)
;; (setq prelude-clean-whitespace-on-save nil)

;; Turn of whitespace mode.
(setq prelude-whitespace nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;
(require 'org-install)
(require 'org-latex)
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
(setq mac-option-modifier 'none)
(setq ns-command-modifier 'meta)
(setq inhibit-startup-message t)
(setq require-final-newline t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default indent-tabs-mode nil)
(transient-mark-mode t)
(setq query-replace-highlight t)
(setq default-major-mode 'text-mode)
(setq cua-enable-cua-keys nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq emerge-diff-options "--ignore-all-space")
(setq preview-auto-cache-preamble t)

;; Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 5)

;; will make "Ctrl-k" kills an entire line if the cursor is at the beginning of line
(setq kill-whole-line t)

;; will delete "hungrily" in C mode
(setq c-hungry-delete-key t)

;; Fonts
;;(if (>= emacs-major-version 23)
;;    (set-default-font "Monospace-10"))

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)


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

;;; yasnippet
;; (require 'yasnippet)
;;;; (setq yas/trigger-key (kbd "C-c <kp-multiply>"))
;; (yas/initialize)
;; (yas/load-directory (concat emacs-root "yasnippet-0.6.1c/snippets"))

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

;; (setq hippie-expand-try-functions-list
;;       '(try-complete-abbrev
;;         try-complete-file-name
;;         try-expand-dabbrev))

(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;; tempo
;;



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

;;(load (concat nxml-path "rng-auto.el"))

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



;;
;; web
;;

;; (load "/home/jonasbu/emacs/nxhtml/autostart.el")

;; (when (and (equal emacs-major-version 24)
;;            (equal emacs-minor-version 3))
;;   (eval-after-load "mumamo"
;;     '(setq mumamo-per-buffer-local-vars
;;            (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

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

(setq python-shell-interpreter "python3.3")

(defun my-c-mode-hook ()
  (setq c-basic-offset 2))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(defun disable-smartparens ()
  (smartparens-mode 0)
  )

(add-hook 'c-mode-common-hook 'disable-smartparens)

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
  )

;; (autoload 'octave-mode "octave-mod" nil t)
;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; Use ocp-indent to indent instead of Tuareg's default
;; (eval-after-load "tuareg"
;;   (let ((opamdir (car (split-string (shell-command-to-string "opam config var prefix")))))
;;     (load-file (concat opamdir "/share/emacs/site-lisp/ocp-indent.el"))))
;; 
;; (autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
;; (add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
;; (add-hook 'typerex-mode-hook 'utop-setup-ocaml-buffer)

;; Impoved utop: loading packages in use
;; from http://mads379.github.io/ocaml/2014/01/05/using-utop-in-emacs.html

;; (require 'cl)
;; (require 'utop)
;; 
;; (defconst init-file-name "toplevel.init")
;; 
;; (defconst build-dir-name "_build")
;; 
;; (defun upward-find-file (filename &optional startdir)
;;   "Move up directories until we find a certain filename. If we
;;   manage to find it, return the containing directory. Else if we
;;   get to the toplevel directory and still can't find it, return
;;   nil. Start at startdir or . if startdir not given"
;; 
;;   (let ((dirname (expand-file-name
;;                   (if startdir startdir ".")))
;;         (found nil) ; found is set as a flag to leave loop if we find it
;;         (top nil))  ; top is set when we get
;;                     ; to / so that we only check it once
;; 
;;     ; While we've neither been at the top last time nor have we found
;;     ; the file.
;;     (while (not (or found top))
;;       ; If we're at / set top flag.
;;       (if (string= (expand-file-name dirname) "/")
;;           (setq top t))
;; 
;;       ; Check for the file
;;       (if (file-exists-p (expand-file-name filename dirname))
;;           (setq found t)
;;         ; If not, move up a directory
;;         (setq dirname (expand-file-name ".." dirname))))
;;     ; return statement
;;     (if found dirname nil)))
;; 
;; (defun should-include-p (file)
;;   "A predicate for wether a given file-path is relevant for
;;    setting up the `include` path of utop."
;;   (cond ((string= (file-name-base file) ".") nil)
;;         ((string= (file-name-base file) "..") nil)
;;         ((string-match ".*\.dSYM" file) nil)
;;         ((file-directory-p file) t)))
;; 
;; (defun ls (dir)
;;   "Returns directory contents. Only includes folders that
;;    are relevant for utop"
;;   (if (should-include-p dir)
;;       (remove-if-not 'should-include-p (directory-files dir t))
;;     nil))
;; 
;; (defun ls-r (dir)
;;   "Returns directory contents, decending into subfolders
;;    recursively. Only returns folders that are relevant for utop "
;;   (defun tail-rec (directories result)
;;     (if (> (length directories) 0)
;;         (let* ((folders (remove-if-not 'should-include-p directories))
;;                (next (mapcar 'ls folders))
;;                (flattened (apply #'append next)))
;;           (tail-rec flattened (append result folders)))
;;       result))
;;   (tail-rec (list dir) nil))
;; 
;; (defun utop-invocation (&optional startdir)
;;   "Generates an appropriately initialized utop buffer."
;;   (interactive)
;;   (let* ((dir (if startdir startdir default-directory))
;;          (project-root (upward-find-file init-file-name dir))
;;          (init-file (concat project-root "/" init-file-name))
;;          (build-dir (concat project-root "/" build-dir-name))
;;          (includes (ls-r build-dir))
;;          (includes-str (mapconcat (lambda (i) (concat "-I " i)) includes " "))
;;          (utop-command (concat "utop -emacs " "-init " init-file " " includes-str)))
;;     ;; The part below is mostly copied from utop.el; Look at the source for comments.
;;     (let ((buf (get-buffer utop-buffer-name)))
;;       (cond
;;        (buf
;;         (pop-to-buffer buf)
;;         (when (eq utop-state 'done) (utop-restart)))
;;        (t
;;         ;; This is the change. We set the command string explicitly.
;;         (setq utop-command utop-command)
;;         (setq buf (get-buffer-create utop-buffer-name))
;;         (pop-to-buffer buf)
;;         (with-current-buffer buf (utop-mode))))
;;       buf)))
;; 
;; ;; Improved ocaml support
;; ;; From: https://github.com/mads379/.emacs.d/blob/master/languages.el#L18
;; 
;; (after `tuareg
;;   (message "OCaml has been loaded")
;; 
;;   (defun make-cmd ()
;;     (concat "make -w -j4 -C " (or (upward-find-file "Makefile") ".")))
;; 
;;   ;; Add OPAM installed elisp files to the load-path.
;;   (push
;;    (concat (substring (shell-command-to-string "opam config var share") 0 -1)
;;            "/emacs/site-lisp") load-path)
;; 
;;   ;; Setup environment variables using OPAM
;;   (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
;;     (setenv (car var) (cadr var)))
;; 
;;   ;; One of the `opam config env` variables is PATH. Update `exec-path` to that.
;;   (setq exec-path (split-string (getenv "PATH") path-separator))
;; 
;;   ;; Tell merlin where to find the executable.
;;   (setq merlin-command
;;         (concat (substring (shell-command-to-string "opam config var bin") 0 -1)
;;                 "/ocamlmerlin"))
;; 
;;   ;; merlin-mode is provided in merlin.el on the load-path.
;;   (autoload 'merlin-mode "merlin" "Merlin mode" t)
;; 
;;   ;; Automatically load utop.el and make it the default toplevel.
;;   (autoload 'utop "utop" "Toplevel for OCaml" t)
;;   (autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
;; 
;;   (add-hook 'tuareg-mode-hook
;;             (lambda ()
;; 
;;               (merlin-mode)
;;               (utop-setup-ocaml-buffer)
;; 
;;               ;; Better default make command for OCaml projects.
;;               (set (make-local-variable 'compile-command) (make-cmd))
;; 
;;               (define-key merlin-mode-map (kbd "M-<tab>") 'merlin-try-completion)
;;               (define-key merlin-mode-map "\M-." 'merlin-locate)
;;               (define-key merlin-mode-map "\M->" 'merlin-pop-stack)
;;               (define-key merlin-mode-map (kbd "C-c C-p") 'prev-match)
;;               (define-key merlin-mode-map (kbd "C-c C-n") 'next-match)
;;               (define-key tuareg-mode-map (kbd "C-x C-r") 'tuareg-eval-region))))
;; 
;;
;; tureg config
;;

;; ;; Indent `=' like a standard keyword.
;; (setq tuareg-lazy-= t)
;; 
;; ;; Indent [({ like standard keywords.
;; (setq tuareg-lazy-paren t)
;; 
;; ;; No indentation after `in' keywords.
;; (setq tuareg-in-indent 0)
;; 
;; (add-hook 'tuareg-mode-hook
;;           ;; Turn on auto-fill minor mode.
;;           (lambda () (auto-fill-mode 1)))

(add-hook 'tuareg-mode-hook
          ;; Turn on auto-fill minor mode.
          (lambda () (auto-fill-mode 1)))

(remove-hook 'prog-mode 'flycheck-mode)

(require 'package)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)

(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)


(setq flycheck-disable-checkers '(make))
;; Hardcode shell to /bin/sh. Fixes problem with rgrep etc. when fish is used as shell.
(setq shell-file-name "/bin/sh")
