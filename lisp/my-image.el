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
  "To be run within image-mode. Works with tramp"
  (interactive "P")
  (let* ((contents (buffer-substring-no-properties (point-min) (point-max)))
         (image-file (make-temp-file "my-copy-image")))
    (with-temp-file image-file
      (insert contents))
    (cond
     ((eq system-type 'windows-nt)
      (message "Not supported yet."))
     ((eq system-type 'darwin)
      (do-applescript
       (format "set the clipboard to POSIX file \"%s\"" (expand-file-name image-file))))
     ((eq system-type 'gnu/linux)
      (call-process-shell-command
       (format "xclip -selection clipboard -t image/%s -i %s"
	       (file-name-extension image-file)
	       image-file))))
    (message "Copied %s" image-file)
    ;; NOTE removing the tmp file can cause race condition with
    ;; copying to clipboard. Add a sleep-for here?
    ;;(delete-file image-file)
    ))

(provide 'my-image)
;;; my-image.el ends here
