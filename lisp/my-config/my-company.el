(use-package company
  :defer 2
  :custom
  (global-company-mode t)
  :config
  (my-leader "c" 'company-complete)

  (with-eval-after-load "my-ivy"
    (my-leader "c" 'counsel-company))

  (with-eval-after-load "my-helm"
    (use-package helm-company
      :config
      (my-leader "c" 'helm-company))))
