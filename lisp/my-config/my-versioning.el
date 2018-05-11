(my-leader "v" '(:ignore t :which-key "Versioning"))

(use-package magit
  :general
  (my-leader
    "vg" 'magit-status)
  :config
  (use-package evil-magit))

(use-package git-timemachine
  :general
  (my-leader
    "vt" 'git-timemachine))

(use-package ediff
  :commands ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (use-package evil-ediff :after evil))
