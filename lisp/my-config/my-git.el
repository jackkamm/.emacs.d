(my-leader "g" '(:ignore t :which-key "Git"))

(use-package magit
  :general
  (my-leader
    "gs" 'magit-status))

(use-package evil-magit
  :after (evil magit)
  :init
  (setq evil-magit-want-horizontal-movement t))

(use-package git-timemachine
  :general
  (my-leader
    "gt" 'git-timemachine))
