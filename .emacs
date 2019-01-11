;; 显示行列号
(setq column-number-mode t)
(setq line-number-mode t)
;; Load org-mode
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; Load jekyll
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'init-org-jekyll)
(require 'init-org-mode)
(require 'htmlize)
