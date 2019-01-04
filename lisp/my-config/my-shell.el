(defun my-shell-command (cmd)
  (interactive
   (list
    (read-shell-command "Shell command: ")))
  (call-process-shell-command cmd nil 0))

(my-evil-leader "&" 'my-shell-command)
(general-define-key "M-&" 'my-shell-command)
