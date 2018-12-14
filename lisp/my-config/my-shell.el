(defun my-shell-command (cmd)
  (interactive
   (list
    (read-shell-command "Shell command: ")))
  (call-process-shell-command cmd nil 0))

(my-evil-leader "&" 'my-shell-command)
(general-define-key "M-&" 'my-shell-command)

(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  :config
  (exec-path-from-shell-initialize))
