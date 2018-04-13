(use-package magit
  :bind
  (:map my-leader-map
	("g s" . magit-status))
  :config
  (use-package evil-magit))
