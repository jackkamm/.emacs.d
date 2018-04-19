(defun my-find-config-module (fname)
  (interactive
   (list (read-file-name
    "Find my config module: "
    (concat user-emacs-directory "lisp/my-config/")
    nil
    'confirm
    (thing-at-point 'symbol t))))
  (switch-to-buffer
   (find-file-noselect fname)))

(my-leader
  "fm" 'my-find-config-module)
