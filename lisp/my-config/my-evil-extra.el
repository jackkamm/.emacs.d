(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-key-blacklist '("SPC"))
  :config
  (evil-collection-init))

(use-package evil-terminal-cursor-changer
  :config
  (evil-terminal-cursor-changer-activate))
