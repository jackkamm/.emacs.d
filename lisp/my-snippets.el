(use-package yasnippet
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode-on)
  (add-hook 'text-mode-hook 'yas-minor-mode-on)
  :commands yas-minor-mode-on
  :general (my-leader "&" '(:ignore t :which-key "yasnippet"))
  :config
  (yas-reload-all)
  (define-key global-map (kbd "C-c &") '("yasnippet"))
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil))

(use-package yasnippet-snippets :defer t)
