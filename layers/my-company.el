(use-package company
  :config
  (global-company-mode)
  (bind-keys :map company-active-map
	     ("<return>" . nil)
	     ("S-<return>" . company-complete-selection)
	     ("C-j" . company-select-next)
	     ("C-k" . company-select-previous)))
