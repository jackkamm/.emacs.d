(use-package company
  :config
  (global-company-mode)
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "S-<return>")
    'company-complete-selection))
