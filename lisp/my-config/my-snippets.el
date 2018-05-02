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
      "is" 'helm-yas-complete)))

(use-package yasnippet-snippets :defer t)
