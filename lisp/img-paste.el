;; orgmode import image from clipboard
(defun org-docs-insert-image-from-clipboard ()
    "Take a screenshot into a time stamped unique-named file in the
    same directory as the org-buffer and insert a link to this file."
    (interactive)
    (let* ((the-dir (concat (projectile-project-root) "~/zhaorengui.github.io/_orgs/"))
           (attachments-dir (concat the-dir "assets/"))
           (jpg-file-name (format-time-string "%Y%m%d_%H%M%S.jpg"))
           (jpg-path (concat attachments-dir jpg-file-name))
           (jpg-relative-path (f-relative jpg-path  (f-dirname buffer-file-name))))
          (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" jpg-path "',[System.Drawing.Imaging.ImageFormat]::Jpeg); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
          (insert (concat "[[file:" jpg-relative-path "]]"))
          ))
;; set keybinding
(global-set-key (kbd "M-o M-v") 'org-docs-insert-image-from-clipboard)
;; provide
(provide 'img-paste)
