;; File Description: Using org to Blog with Jekyll
;; From: https://segmentfault.com/a/1190000008313904
;; @Author: Zhao Rengui
;; @Date: 201808
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
;; (setq org-export-with-sub-superscripts nil)
(setq org-publish-project-alist
      '(
	("org-jekyll-zhaorengui" 
	 ;; Path to org files.
	 :base-directory "~/zhaorengui.github.io/_orgs/"
	 :base-extension "org"
	 ;; Path to Jekyll Posts
	 :publishing-directory "~/zhaorengui.github.io/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :with-toc nil
	 :headline-levels 4
	 :auto-preamble nil
	 :auto-sitemap nil
	 :table-of-contents nil
	 :html-extension "html"
	 :section-numbers nil
	 ;;:html_head "<link rel=\"stylesheet\" type=\"text/css\" href=\"../assets/themes/havee/css/style.css\" />"
	 :body-only t)
	("markdown-jekyll-zhaorengui"
	 :base-directory "~/zhaorengui.github.io/_orgs/_posts/"
	 :base-extension "md"
	 :publishing-directory "~/zhaorengui.github.io/_posts/"
	 :recursive t
	 :publishing-function org-publish-attachment)
	("org-static-images-zhaorengui"
	 :base-directory "~/zhaorengui.github.io/_orgs/_assets/"
	 :base-extension "png\\|jpg\\|jpeg\\|gif"
	 :publishing-directory "~/zhaorengui.github.io/assets/images/"
	 :recursive t
	 :publishing-function org-publish-attachment)
	("org-static-js-zhaorengui"
	 :base-directory "~/zhaorengui.github.io/_orgs/_assets/"
	 :base-extension "js"
	 :publishing-directory "~/zhaorengui.github.io/assets/js/"
	 :recursive t
	 :publishing-function org-publish-attachment)
	("org-static-css-zhaorengui"
	 :base-directory "~/zhaorengui.github.io/_orgs/_assets/"
	 :base-extension "css"
	 :publishing-directory "~/zhaorengui.github.io/assets/css/"
	 :recursive t
	 :publishing-function org-publish-attachment)
	("org-static-other-zhaorengui"
	 :base-directory "~/zhaorengui.github.io/_orgs/_assets/"
	 :base-extension "pdf\\|mp3\\|ogg\\|swf\\|php"
	 :publishing-directory "~/zhaorengui.github.io/assets/other/"
	 :recursive t
	 :publishing-function org-publish-attachment)
	("jekyll-zhaorengui-github-io"
	 :components ("org-jekyll-zhaorengui"
		      "markdown-jekyll-zhaorengui"
		      "org-static-images-zhaorengui"
		      "org-static-js-zhaorengui"
		      "org-static-css-zhaorengui"
		      "org-static-other-zhaorengui"))
	)
      )
(defvar jekyll-directory (expand-file-name "~/zhaorengui.github.io/_orgs/")
  "Path to Jekyll blog.")
(defvar jekyll-drafts-dir "_drafts/"
  "Relative path to drafts directory.")
(defvar jekyll-posts-dir "_posts/"
  "Relative path to posts directory.")
(defvar jekyll-post-ext ".org"
  "File extension of Jekyll posts.")
(defvar jekyll-post-template
  "#+TITLE:  %s 
#+AUTHOR:    zrg
#+EMAIL:     zrg1390556487@gmail.com
#+LANGUAGE:  cn
#+OPTIONS:   H:3 num:t toc:nil \\n:nil @:t ::t |:t ^:nil -:t f:t *:t <:t
#+OPTIONS:   TeX:t LaTeX:t skip:nil d:nil todo:t pri:nil tags:not-in-toc
#+INFOJS_OPT: view:plain toc:t ltoc:t mouse:underline buttons:0 path:http://cs3.swfc.edu.cn/~20121156044/.org-info.js />
#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"http://cs3.swfu.edu.cn/~20121156044/.org-manual.css\" />
#+EXPORT_SELECT_TAGS: export
#+HTML_HEAD_EXTRA: <style>body {font-size:14pt} code {font-weight:bold;font-size:12px; color:darkblue}</style>
#+EXPORT_EXCLUDE_TAGS: noexport
#+LINK_UP:   
#+LINK_HOME: 
#+XSLT: 

#+STARTUP: showall indent
#+STARTUP: hidestars
#+BEGIN_EXPORT HTML
---
layout: post
title:  
author: zrg
description:   
excerpt: 
comments: false
categories: 
- algorithms
tags:
- ACM
---
#+END_EXPORT

# (setq org-export-html-use-infojs nil)
感谢您阅读此文，如果您发现任何错误或误导之处，你可以发邮件至 zrg1390556486@gmail.com，编者将非常感谢您的纠正！
# (setq org-export-html-style nil)"

"Default template for Jekyll posts. %s will be replace by the post title.")
(defun jekyll-make-slug (s)
  "Turn a string into a slug."
  (replace-regexp-in-string
    " " "-" (downcase
	      (replace-regexp-in-string
		"[^A-Za-z0-9\u4e00-\u9fa5]" "" s))))
(defun jekyll-yaml-escape (s)
  "Escape a string for YAML."
  (if (or (string-match ":" s)
	  (string-match "\"" s))
    (concat "\"" (replace-regexp-in-string "\"" "\\\\\"" s) "\"")
    s))

(defun jekyll-draft-post (title)
  "Create a new Jekyll blog post."
  (interactive "sPost Title: ")
  (let ((draft-file (concat jekyll-directory jekyll-drafts-dir
			    (jekyll-make-slug title)
			    jekyll-post-ext)))
    (if (file-exists-p draft-file)
      (find-file draft-file)
      (find-file draft-file)
      (insert (format jekyll-post-template (jekyll-yaml-escape title))))))

(defun jekyll-publish-post ()
  "Move a draft post to the posts directory, and rename it so that it
  contains the date."
  (interactive)
  (cond
    ((not (equal
	    (file-name-directory (buffer-file-name (current-buffer)))
	    (concat jekyll-directory jekyll-drafts-dir)))
     (message "This is not a draft post."))
    ((buffer-modified-p)
     (message "Can't publish post; buffer has modifications."))
    (t
      (let ((filename
	      (concat jekyll-directory jekyll-posts-dir
		      (format-time-string "%Y-%m-%d-")
		      (file-name-nondirectory
			(buffer-file-name (current-buffer)))))
	    (old-point (point)))
	(rename-file (buffer-file-name (current-buffer))
		     filename)
	(kill-buffer nil)
	(find-file filename)
	(set-window-point (selected-window) old-point)))))
;; provide
(provide 'init-org-jekyll)
