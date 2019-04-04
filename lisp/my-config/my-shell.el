;; execute shell commands

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

;; TODO is this still needed?
;; workaround for https://lists.gnu.org/archive/html/bug-gnu-emacs/2019-03/msg00326.html
(defun my-read-shell-command-advice (&rest args)
  (setq-default comint-input-autoexpand nil))
(advice-add 'read-shell-command :after 'my-read-shell-command-advice)

;; send lines from .sh files to *shell* buffer

(defun my-shell-send-region (beg end)
 (interactive "r")
 (process-send-region "*shell*" beg end))

(defun my-shell-send-buffer ()
 (interactive)
 (my-shell-send-region (point-min) (point-max)))

(my-major-leader
  :keymaps 'sh-mode-map
  "b" 'my-shell-send-buffer
  "r" 'my-shell-send-region)
