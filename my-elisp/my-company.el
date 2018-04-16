(use-package company
  :config
  (global-company-mode)
  (bind-keys :map company-active-map
	     ("<return>" . nil)
	     ("S-<return>" . company-complete-selection)))
