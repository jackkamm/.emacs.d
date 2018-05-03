(my-leader "b" '(:ignore t :which-key "Buffer"))
(general-create-definer my-buffers-leader :prefix "C-c b")

(my-buffers-leader
 "d" 'kill-buffer
 "x" 'kill-buffer-and-window)

(with-eval-after-load "my-helm"
  (my-buffers-leader
   "b" 'helm-mini))
