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
    (shell . t)
    (sql . t)
    (sqlite . t)
    ))
;; Load ~/.emacs.d/lisp
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-org-jekyll)
;; Load plantuml
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml/plantuml.jar"))
;;
(server-start)
(setq server-socket-dir "~/.emacs.d/server")
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (smex web-mode company-c-headers company-go company-shell company-php plantuml-mode htmlize org)))
 '(plantuml-jar-path "/home/zrg/.emacs.d/plantuml/plantuml.jar"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
