(use-package yasnippet
  :defer 2
  :general (my-leader "&" '(:ignore t :which-key "yasnippet"))
  :config
  (yas-global-mode 1)
  (define-key global-map (kbd "C-c &") '("yasnippet"))
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil))

(use-package yasnippet-snippets)
