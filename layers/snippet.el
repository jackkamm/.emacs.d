(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package helm-c-yasnippet
  :bind (:map my-leader-map
	      ("i s" . helm-yas-complete)))

(use-package yasnippet-snippets
  :defer t)
