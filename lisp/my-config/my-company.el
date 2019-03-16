(use-package company
  :commands (company-mode company-mode-on)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'company-mode-on))
  :config
  (bind-keys :map company-active-map
	     ("<return>" . nil))

  (with-eval-after-load "my-ivy"
    (my-leader "c" 'counsel-company)))

(with-eval-after-load "my-helm"
  (use-package helm-company
    :after company
    :config
    (my-leader "c" 'helm-company)))
