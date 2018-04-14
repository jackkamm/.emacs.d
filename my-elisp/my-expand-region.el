(use-package expand-region
  :bind (:map my-leader-map
	      ("v" . er/expand-region))
  :config
  (setq expand-region-contract-fast-key "V"
	expand-region-reset-fast-key "r"))
