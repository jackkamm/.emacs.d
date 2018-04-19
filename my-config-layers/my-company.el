(use-package company
  :commands (company-mode company-mode-on)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'company-mode-on))
  :config
  (bind-keys :map company-active-map
	     ("<return>" . nil)))
