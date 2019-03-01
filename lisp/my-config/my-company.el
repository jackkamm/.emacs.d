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
    (define-key company-mode-map (kbd "C-;") 'counsel-company)
    (define-key company-active-map (kbd "C-;") 'counsel-company)))

(with-eval-after-load "my-helm"
  (use-package helm-company
    :after company
    :config
    (define-key company-mode-map (kbd "C-;") 'helm-company)
    (define-key company-active-map (kbd "C-;") 'helm-company)))

