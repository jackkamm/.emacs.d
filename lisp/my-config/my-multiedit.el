(use-package iedit
  :bind ("C-;" . 'iedit-mode))

;;(global-unset-key (kbd "S-<down-mouse-1>"))
(use-package evil-mc
  :commands turn-on-evil-mc-mode
  :bind ("S-<down-mouse-1>" . 'evil-mc-toggle-cursor-on-click)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'turn-on-evil-mc-mode)))

