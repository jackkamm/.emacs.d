(setq my-buffers-map (make-sparse-keymap))
(general-create-definer my-buffers-leader :prefix-map 'my-buffers-map)
(my-leader "b" '(:keymap my-buffers-map :which-key "Buffer"))

(my-buffers-leader
 "d" 'kill-buffer
 "x" 'kill-buffer-and-window
 "r" 'revert-buffer)

(with-eval-after-load "my-helm"
  (my-buffers-leader
   "b" 'helm-mini))

(with-eval-after-load "my-ivy"
  (my-buffers-leader
    "b" 'ivy-switch-buffer))
