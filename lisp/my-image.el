;;; my-image.el --- Image config                     -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; TODO autoloads/deferral
(use-package org-clip)

(defun my-copy-image ()
  "To be run in image-mode"
  (interactive)
  (shell-command-on-region
   (point-min)
   (point-max)
   (ox-clip-get-command ox-clip-osx-cmd)))

;; Originally based on ox-clip-image-to-clipboard
(defun my-copy-image (&optional scale)
  "To be run within image-mode. Works with tramp, and even for
images without a backing file (if that can happen?)"
  (interactive "P")
  (let* ((contents (buffer-substring-no-properties (point-min) (point-max)))
         (tmp-file (make-temp-file "my-copy-image"))
         (coding-system-for-write 'raw-text))
    (with-temp-file tmp-file
      (insert contents))
    (cond
     ((eq system-type 'windows-nt)
      (message "Not supported yet."))
     ((eq system-type 'darwin)
      (do-applescript
       (format "set the clipboard to POSIX file \"%s\"" (expand-file-name tmp-file))))
     ((eq system-type 'gnu/linux)
      (call-process-shell-command
       (format "xclip -selection clipboard -t image/%s -i %s"
               ;; FIXME tmp-file has no extension
	       (file-name-extension tmp-file)
	       tmp-file))))
    (message "Copied %s" tmp-file)
    (sleep-for 100)
    (delete-file tmp-file)))

(provide 'my-image)
;;; my-image.el ends here
