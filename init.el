;;; init.el --- Where all the magic begins
;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Load up ELPA, the package manager

(add-to-list 'load-path dotfiles-dir)

(require 'package)
(package-initialize)
(require 'starter-kit-elpa)

(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)

;; Load up starter kit customizations

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'js2-mode)
;;;(require 'javascript-mode)
;;;(require 'js-mode)

(add-to-list 'load-path "~/.emacs.d/elpa-to-submit/rhtml/")
(require 'rhtml-mode)

(setq js2-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(regen-autoloads)
(load custom-file 'noerror)

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))


;;; color themes
(load-file "~/.emacs.d/themes/zenburn-theme.el")

;;;(require 'color-theme)
;;;(add-to-list 'load-path (concat dotfiles-dir "/themes"))

;;;(load-file "~/.emacs.d/themes/zenburn.el")
;;;(zenburn)

;;;(load-file "~/.emacs.d/themes/color-theme-merbivore.el")
;;;(color-theme-merbivore)

;;;(load-file "~/.emacs.d/themes/color-theme-raminius.el")
;;;(color-theme-raminius)

(set-face-background 'show-paren-match-face "#593A58")
(set-face-background 'region "#424951") ; Set region background color 

(global-hl-line-mode 1)

;; (require 'autopair)
;; (autopair-global-mode)

(setq-default cursor-type 'bar) 
(setq-default truncate-lines t)
(setq-default longlines-auto-wrap nil)

(require 'php-mode)
(setq c-default-style "bsd" c-basic-offset 4)

(setq default-tab-width 4) 
(global-linum-mode 1)
(custom-set-variables '(linum-format (quote "%d ")))

;;; (put 'autopair-insert-opening 'delete-selection t)
;;; (put 'autopair-skip-close-maybe 'delete-selection t)
;;; (put 'autopair-insert-or-skip-quote 'delete-selection t)
;;; (put 'autopair-extra-insert-opening 'delete-selection t)
;;; (put 'autopair-extra-skip-close-maybe 'delete-selection t)
;;; (put 'autopair-backspace 'delete-selection 'supersede)
;;; (put 'autopair-newline 'delete-selection t)

(setq autopair-autowrap t)

;;mode-compile
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

(add-to-list 'load-path "~/.emacs.d/elpa-to-submit/yasnippet-0.6.1c/")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/elpa-to-submit/yasnippet-0.6.1c")

(add-to-list 'load-path "~/.emacs.d/elpa-to-submit/rvm.el")
(require 'rvm)
(rvm-use-default)

(require 'two-mode-mode)

(add-hook 'html-mode-hook
    (lambda ()
      ;; Default indentation is usually 2 spaces, changing to 4.
      (set (make-local-variable 'sgml-basic-offset) 2)))

(setq c-hungry-delete-key t)
(add-hook 'php-mode-hook '(lambda ()
    (local-set-key (kbd "RET") 'newline-and-indent)))

;;;(setq-default fill-column 200)

(load-file "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

(add-to-list 'load-path "~/.emacs.d/vendor/")

;;;(require 'sr-speedbar)
;;;(global-set-key (kbd "M-v") 'sr-speedbar-toggle)
;;;(global-set-key (kbd "M-p") 'peepopen-goto-file-gui)

;;; org mode stuff
;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;;(tool-bar-mode -1)
(setq-default delete-selection-mode t)

(load-file "~/.emacs.d/haml-mode.el")
(require 'haml-mode)

(add-to-list 'load-path "~/.emacs.d/scala")
(require 'scala-mode-auto)

;; Load the ensime lisp code...
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
;; (require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(add-to-list 'load-path "~/.emacs.d/erlang")
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/bin" exec-path))
(require 'erlang-start)

;;;(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
;;;(require 'coffee-mode)

;;;(add-to-list 'load-path "~/.emacs.d/go-mode-load.el" t)
;;;(require 'go-mode-load)

;;;
(add-to-list 'auto-mode-alist '("\\.html.erb$" . rhtml-mode))

;;; use css mode for scss files, maybe sass mode later
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;;; css mode 2 space indent
(setq css-indent-offset 2)

(menu-bar-mode -1)

;;; prevent ctrl-z killing the buffer
(global-unset-key (kbd "C-z"))

;;; Init.el ends here

