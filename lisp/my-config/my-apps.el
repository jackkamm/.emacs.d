;;; default browser

;; https://lists.gnu.org/archive/html/emacs-devel/2014-11/msg00328.html
(setq browse-url-browser-function 'browse-url-xdg-open)

;;; open external terminal

(defun my-tmux-open
    (dir) (interactive (list (read-directory-name
			      "Root directory: ")))
    (let ((default-directory dir))
      (call-process "urxvt" nil 0 nil "-e" "tmux")))

(my-leader
  "at" 'my-tmux-open)
