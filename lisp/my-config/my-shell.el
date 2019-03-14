(defun my-external-command (cmd)
  (interactive
   (list
    (read-shell-command "Shell command: ")))
  (call-process-shell-command cmd nil 0))

(my-leader
  "d" '(:ignore t :which-key "Command")
  "dd" 'my-external-command
  "d!" 'shell-command
  "d&" 'async-shell-command)

;; workaround for https://lists.gnu.org/archive/html/bug-gnu-emacs/2019-03/msg00326.html
(defun my-read-shell-command-advice (&rest args)
  (setq-default comint-input-autoexpand nil))
(advice-add 'read-shell-command :after 'my-read-shell-command-advice)
