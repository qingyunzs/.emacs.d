;;init.el --- init
;;; Commentary:
;; Calls my Emacs configuration files after installing use-package, which is
;; necessary for operation.  See also:
;;      http://www.cachestocaches.com/2015/8/getting-started-use-package/
;;
;; Code inspired by:
;;      http://stackoverflow.com/a/10093312/3672986
;;      http://www.lunaryorn.com/2015/01/06/my-emacs-configuration-with-use-package.html
;;      https://github.com/jwiegley/use-package

;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      (append package-archives
	      '(("melpa" . "http://melpa.org/packages/")
		("gnu" . "http://elpa.gnu.org/packages/")
		("org" . "http://orgmode.org/elpa/"))))
(package-initialize)
;; Load language
(org-babel-do-load-languages
  'org-babel-load-languages
  '( (C . t)
    (css . t)
    (ditaa . t)
    (calc . t)
    (emacs-lisp . t)
    (dot . t)
    (java . t)
    (js . t)
    (latex . t)
    (lisp . t)
    (matlab . t)
    (org . t)
    (perl . t)
    (plantuml . t)
    (python . t)
    (ruby . t)
    (sass . t)
    (scheme . t)
    (sh . t)
    (sql . t)
    (sqlite . t)
    ))
;; Load ~/.emacs.d/lisp
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-org-jekyll)
(require 'emmet-mode)
;; Load plantuml
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml/plantuml.jar"))
;; Emmet optional settings
;; You probably want to add it to auto-load on your sgml modes:
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
;; By default, inserted markup will be indented with indent-region, according to the buffer's mode. To disable this, do:
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indent-after-insert nil)))
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;; If you disable indent-region, you can set the default indent level thusly:
;;(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.
;; If you want the cursor to be positioned between first empty quotes after expanding:
(setq emmet-move-cursor-between-quotes t) ;; default nil
;; Or if you don't want to move cursor after expanding:
;; (setq emmet-move-cursor-after-expanding nil) ;; default t
;; If you want to use emmet with react-js's JSX, you probably want emmet to expand 'className="..."' instead of 'class="..."':
(setq emmet-expand-jsx-className? t) ;; default nil
;; If you want to customize Self-closing tags style:
(setq emmet-self-closing-tag-style " /") ;; default "/"
;; only " /", "/" and "" are valid.
;; eg. <meta />, <meta/>, <meta>
;;(server-start)
;;(setq server-socket-dir "~/.emacs.d/server")
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai-pro)))
 '(custom-safe-themes
   (quote
    ("1d2f406a342499f0098f9388b87d05ec9b28ccb12ca548f4f5fa80ae368235b6" default)))
 '(package-selected-packages
   (quote
    (plantuml-mode monokai-pro-theme org-plus-contrib emmet-mode smex web-mode company-c-headers company-go company-shell company-php htmlize org)))
 '(plantuml-jar-path "~/.emacs.d/plantuml/plantuml.jar"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
