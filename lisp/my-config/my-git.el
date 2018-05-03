(my-leader "g" '(:ignore t :which-key "git"))

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
