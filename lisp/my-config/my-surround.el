(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package expand-region
  :general
  (my-leader
    "v" 'er/expand-region)
  :config
  (setq expand-region-contract-fast-key "V"
	expand-region-reset-fast-key "r"))
