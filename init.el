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
(require 'starter-kit-js)
(require 'javascript-mode)


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


(require 'color-theme)
(add-to-list 'load-path (concat dotfiles-dir "/themes"))

;;;(load-file "~/.emacs.d/themes/zenburn.el")
;;;(zenburn)

;;;(load-file "~/.emacs.d/themes/color-theme-merbivore.el")
;;;(color-theme-merbivore)

(load-file "~/.emacs.d/themes/color-theme-raminius.el")
(color-theme-raminius)

(set-face-background 'show-paren-match-face "#593A58")
(set-face-background 'region "#424951") ; Set region background color 

(global-hl-line-mode 1)

(require 'autopair)
(autopair-global-mode)

(add-to-list 'default-frame-alist '(height . 80))	
(add-to-list 'default-frame-alist '(width . 130))	
(add-to-list 'default-frame-alist '(font . "-apple-Monaco-medium-normal-normal-*-10-*-*-*-m-0-iso10646-1"))	

(setq-default cursor-type 'bar) 
(setq-default truncate-lines t)
(setq-default longlines-auto-wrap nil)

(require 'php-mode)
(setq c-default-style "bsd" c-basic-offset 4)

(setq default-tab-width 4) 
(global-linum-mode 1)

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
      (set (make-local-variable 'sgml-basic-offset) 4)))

(setq c-hungry-delete-key t)
(add-hook 'php-mode-hook '(lambda ()
    (local-set-key (kbd "RET") 'newline-and-indent)))

(setq-default fill-column 200)

(load-file "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'peepopen)

(require 'sr-speedbar)
(global-set-key (kbd "M-v") 'sr-speedbar-toggle)


(global-set-key (kbd "M-p") 'peepopen-goto-file-gui)


;;; init.el ends here