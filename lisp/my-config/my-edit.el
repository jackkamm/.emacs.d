(my-leader "e" '(:ignore t :which-key "editing"))
(general-create-definer my-edit-leader :prefix "C-c e")

(my-edit-leader
 "<tab>" 'indent-region)

;;; undo-tree

(use-package undo-tree
  :general
  (my-edit-leader
    "u" 'undo-tree-visualize))

;;; yasnippet

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

(use-package yasnippet-snippets :defer t)

;;; expand-region

(use-package expand-region
  :general
  (my-edit-leader
    "v" 'er/expand-region)
  :config
  (setq expand-region-contract-fast-key "V"
	expand-region-reset-fast-key "r"))
