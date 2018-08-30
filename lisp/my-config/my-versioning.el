(my-leader "g" '(:ignore t :which-key "Git"))

(use-package magit
  :general
  (my-leader
    "gs" 'magit-status)
  :config
  (use-package evil-magit))

(use-package git-timemachine
  :general
  (my-leader
    "gt" 'git-timemachine))

(use-package ediff
  :commands ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (use-package evil-ediff :after evil))
