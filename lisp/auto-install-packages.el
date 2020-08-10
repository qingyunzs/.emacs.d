;;
;; Auto install packages
(defun require-package(package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.If NO-REFRESH is non-nil, the available package lists will not bere-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
    t
    (if (or (assoc package package-archive-contents) no-refresh)
      (if (boundp 'package-selected-packages)
	;; Record this as a package the user installed explicitly
	(package-install package nil)
	(package-install package))
      (progn
	(package-refresh-contents)
	(require-package package min-version t)))))
(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.In the event of failure, return nil and print a warning message. Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the available package lists will not be re-downloaded in order to locate PACKAGE."
  (condition-case err
		  (require-package package min-version no-refresh)
		  (error
		    (message "Couldn't install optional package `%s': %S" package err)
		    nil)))
;;
(require-package 'org)
(require-package 'emmet-mode)
(require-package 'htmlize)
(require-package 'company)
(require-package 'company-nginx)
(require-package 'company-php)
(require-package 'company-shell)
(require-package 'monokai-theme)
(require-package 'markdown-mode)
(require-package 'org-sql)
(require-package 'org2jekyll)
(require-package 'multiple-cursors)
;;
;; provide
(provide 'auto-install-packages)
