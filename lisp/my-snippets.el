(use-package yasnippet
  :hook
  ((prog-mode . yas-minor-mode-on)
   (text-mode . yas-minor-mode-on))
  :general (my-leader "&" '(:ignore t :which-key "yasnippet"))
  :config
  (yas-reload-all)
  (define-key global-map (kbd "C-c &") '("yasnippet"))
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil))

(use-package yasnippet-snippets)
