(use-package magit
  :bind
  (:map leader-map
	("g s" . magit-status))
  :config
  (with-eval-after-load 'evil
    (evil-set-initial-state 'magit-status-mode 'motion))
    )
