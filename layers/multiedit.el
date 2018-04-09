(use-package iedit
  :bind (:map leader-map
	      ("s e" . iedit-mode)))

(use-package evil-iedit-state
  :config
  (with-eval-after-load 'iedit
    (add-hook 'iedit-mode-hook 'evil-iedit-state)))
  

(global-unset-key (kbd "S-<down-mouse-1>"))
(use-package multiple-cursors
  :bind ("S-<down-mouse-1>" . 'mc/add-cursor-on-click)
  :config
  (define-key mc/keymap (kbd "<return>") nil)
  (setq mc/always-run-for-all t))
