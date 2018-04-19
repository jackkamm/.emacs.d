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

(defun my-tmux-open
    (dir) (interactive (list (read-directory-name
			      "Root directory: ")))
    (let ((default-directory dir))
      (call-process "urxvt" nil 0 nil "-e" "tmux")))

(my-leader
  "fm" 'my-find-config-module
  "at" 'my-tmux-open)
