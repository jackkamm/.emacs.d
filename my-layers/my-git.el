(use-package magit
  :general
  (my-leader
    "gs" 'magit-status)
  :config
  (use-package evil-magit))

(use-package git-timemachine
  :general
  (my-leader
    "gt" 'git-timemachine)
  :config
  (add-hook 'git-timemachine-mode-hook 'evil-motion-state)
  (evil-define-key 'motion git-timemachine-mode-map
    (kbd "C-n") 'git-timemachine-show-next-revision
    (kbd "C-p") 'git-timemachine-show-previous-revision))
