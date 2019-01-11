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
  '( (scheme . t)
    (latex . t)
    (css . t)
    (ruby . t)
    (sh . t)
    (python . t)
    (emacs-lisp . t)
    (matlab . t)
    (plantuml . t)
    (C . t)))
;; Load ~/.emacs.d/lisp
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-org-jekyll)
;; Load plantuml
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml/plantuml.jar"))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(package-selected-packages (quote (htmlize org))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )
