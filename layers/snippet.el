(use-package yasnippet
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode-on)
  :commands yas-minor-mode-on)

(use-package helm-c-yasnippet
  :commands (helm-yas-complete
	     helm-yas-visit-snippet-file)
  :general
  (my-leader
    :keymaps 'prog-mode-map
    "is" 'helm-yas-complete))

(use-package yasnippet-snippets
  :defer t)
