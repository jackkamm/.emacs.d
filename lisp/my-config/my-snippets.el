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
    (my-leader
      "y" 'helm-yas-complete)))

(with-eval-after-load "my-ivy"
  (use-package ivy-yasnippet
    :commands ivy-yasnippet
    :general
    (my-leader
      "y" 'ivy-yasnippet)))

(use-package yasnippet-snippets :defer t)
