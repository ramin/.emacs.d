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

(add-to-list 'default-frame-alist '(height . 160))	
(add-to-list 'default-frame-alist '(width . 140))	
(add-to-list 'default-frame-alist '(font . "-apple-Monaco-medium-normal-normal-*-10-*-*-*-m-0-iso10646-1"))	

(setq-default cursor-type 'bar) 
(setq-default truncate-lines t)
(setq-default longlines-auto-wrap nil)

(require 'php-mode)
(setq c-default-style "bsd" c-basic-offset 4)

(load-file "~/.emacs.d/clojure-mode/clojure-mode.el")
(require 'clojure-mode)

(setq default-tab-width 4) 
(global-linum-mode 1)

(put 'autopair-insert-opening 'delete-selection t)
(put 'autopair-skip-close-maybe 'delete-selection t)
(put 'autopair-insert-or-skip-quote 'delete-selection t)
(put 'autopair-extra-insert-opening 'delete-selection t)
(put 'autopair-extra-skip-close-maybe 'delete-selection t)
(put 'autopair-backspace 'delete-selection 'supersede)
(put 'autopair-newline 'delete-selection t)

(delete-selection-mode 1)

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

(require 'two-mode-mode)
(require 'html-php)

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