(setq dired-dwim-target t)
(use-package dired-x
  :ensure nil
  :general
  (my-leader "jD" 'dired-jump))
