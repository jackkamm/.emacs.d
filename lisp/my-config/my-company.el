(use-package company
  :defer 2
  :custom
  (global-company-mode t)
  :config
  (my-leader "c" 'company-complete))
