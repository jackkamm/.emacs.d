(use-package company
  :defer 2
  :custom
  (global-company-mode t)
  :config
  (my-leader "C" 'company-complete)

  (with-eval-after-load "my-ivy"
    (my-leader "C" 'counsel-company))

  (with-eval-after-load "my-helm"
    (use-package helm-company
      :config
      (my-leader "C" 'helm-company))))

(use-package company-prescient
  :config
  ;; TODO autoload?
  (company-prescient-mode))
