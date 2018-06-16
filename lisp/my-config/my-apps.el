;;; open external terminal

(defun my-tmux-open
    (dir) (interactive (list (read-directory-name
			      "Root directory: ")))
    (let ((default-directory dir))
      (call-process "urxvt" nil 0 nil "-e" "tmux")))

(my-leader
  "at" 'my-tmux-open)
