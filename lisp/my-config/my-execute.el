(my-leader "x" '(:ignore t :which-key "Execute"))
(general-create-definer my-execute-leader :prefix "C-c x")

(my-execute-leader
 "u" 'universal-argument
 "z" 'evil-execute-in-emacs-state
 "!" 'shell-command
 "&" 'async-shell-command)

(with-eval-after-load "my-helm"
  (my-execute-leader
   "x" 'helm-M-x))
