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
(setq debug-on-error t)
(setq package-enable-at-startup nil)
(setq package-archives
     (append package-archives
	      '(
		("melpa" . "http://melpa.org/packages/")
		("gnu" . "http://elpa.gnu.org/packages/")
		("org" . "http://orgmode.org/elpa/")
		)
	)
)
;; 16.2 Structure Templates
;; With just a few keystrokes, it is possible to insert empty structural blocks, such as ‘#+BEGIN_SRC’ … ‘#+END_SRC’, or to wrap existing text in such a block.
;; 
;; C-c C-, (org-insert-structure-template)
;; Prompt for a type of block structure, and insert the block at point. If the region is active, it is wrapped in the block. First prompts the user for keys, which are used to look up a structure type from the variable below. If the key is TAB, RET, or SPC, the user is prompted to enter a block type.
;; 
;; Available structure types are defined in org-structure-template-alist, see the docstring for adding or changing values.
;; 
;; Org Tempo expands snippets to structures defined in org-structure-template-alist and org-tempo-keywords-alist. For example, < s TAB creates a code block. Enable it by customizing org-modules or add ‘(require 'org-tempo)’ to your Emacs init file146.
;; https://orgmode.org/manual/Structure-Templates.html 
(require 'org-tempo)
;;
;; Initialize & Install Package
(package-initialize) 
;;
;; Load languages
;; https://orgmode.org/manual/Languages.html#Languages
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
    (shell . t)
    (sql . t)
    (sqlite . t)
    ))
;;
;; Load ~/.emacs.d/lisp
(add-to-list 'load-path "~/.emacs.d/lisp/")
;;
;; Load init-org-jekyll.el
(require 'init-org-jekyll)
;;
;; Load auto-install-packages.el
(require 'auto-install-packages)
;;
;; Load org-preview-html.el
(require 'org-preview-html)
;;
;; Load pasteex-mode.el
(require 'pasteex-mode)
;;
;; Load plantuml
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml/plantuml.jar"))
;;
;; Set pasteex path
(setq pasteex-executable-path "/tmp/pasteex")
(setq pasteex-image-dir "../_assets/")
;;
(setq byte-compile-warnings '(cl-functions))
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			;;
;; Customize settings 	;;
;;			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set welcome title
;;(setq frame-title-format "Welcome to Emacs world! ")
;; Show line number
;;(glolinum-mode t);
;; or
(line-number-mode t)
;;
;; Show column number
;;(column-number-mode t)
;;
;; Set line format
;;(setq linum-format "%d ")
;; 
;; Highlight line
(global-hl-line-mode 1)
;;
;; Auto complete
(global-company-mode t)
;;
;; Disable/enable menu bar
;;(menu-bar-mode nil)
;;
;; Close tool bar
(tool-bar-mode -1)
;;
;; Set font
;;(set-default-font "Monaco 15")
;;
;; Close scroll bar
(scroll-all-mode t)
;;
;; Close start page
(setq inhibit-splash-screen t)
;;
;; Open and Show image
;;(setq auto-image-file-mode t)
;;
;; Show time
(display-time-mode t)
;;
;; 24h
(setq display-time-24hr-format t)
;;
;; Bind key to function pasteex-image
;;
(global-set-key (kbd "C-x p i") 'pasteex-image)
;;
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
 '(ansi-color-names-vector
   ["#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#ff6188" "#fcfcfa"])
 '(ansi-term-color-vector
   [unspecified "#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#ff6188" "#fcfcfa"] t)
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "3a2803566972e3f3882af48ce5680b824e81bf9dc5f32639b5f1e6d9f6aeda3c" "1d2f406a342499f0098f9388b87d05ec9b28ccb12ca548f4f5fa80ae368235b6" default))
 '(package-selected-packages
   '(xmind-org company-tabnine grip-mode multiple-cursors cl-libify org org2jekyll monokai-theme org-download company markdownfmt markdown-mode+ orgalist markdown-mode highlight-indentation plantuml-mode monokai-pro-theme org-plus-contrib emmet-mode smex web-mode company-c-headers company-go company-shell company-php htmlize))
 '(plantuml-jar-path "~/.emacs.d/plantuml/plantuml.jar"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)
