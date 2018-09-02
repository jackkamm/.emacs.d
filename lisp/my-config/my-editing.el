(my-leader "e" '(:ignore t :which-key "Edit"))
(general-create-definer my-edit-leader :prefix "C-c e")

(my-edit-leader
 "<tab>" 'indent-region)

(use-package undo-tree
  :general
  (my-edit-leader
    "u" 'undo-tree-visualize)
  :init
  (setq undo-tree-enable-undo-in-region nil))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package expand-region
  :general
  (my-edit-leader
    "v" 'er/expand-region)
  :config
  (setq expand-region-contract-fast-key "V"
	expand-region-reset-fast-key "r"))

(use-package company
  :commands (company-mode company-mode-on)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'company-mode-on))
  :config
  (bind-keys :map company-active-map
	     ("<return>" . nil)))

(with-eval-after-load "my-helm"
  (use-package helm-company
    :after company
    :config
    (define-key company-mode-map (kbd "C-;") 'helm-company)
    (define-key company-active-map (kbd "C-;") 'helm-company)))

(use-package yasnippet
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode-on)
  (add-hook 'text-mode-hook 'yas-minor-mode-on)
  :commands yas-minor-mode-on
  :config
  (yas-reload-all))

(with-eval-after-load "my-helm"
  (use-package helm-c-yasnippet
    :commands (helm-yas-complete
	       helm-yas-visit-snippet-file)
    :general
    (my-edit-leader
      "y" 'helm-yas-complete)))

(with-eval-after-load "my-ivy"
  (use-package ivy-yasnippet
    :commands ivy-yasnippet
    :general
    (my-edit-leader
      "y" 'ivy-yasnippet)))

(use-package yasnippet-snippets :defer t)
