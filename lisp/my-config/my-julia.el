(use-package ess-julia-mode
  :ensure ess
  :mode (("\\.jl\\'" . ess-julia-mode)))

;; TODO put this somewhere else...
(use-package company-math
  :config
  (add-hook 'ess-julia-mode-hook
            (lambda ()
              (setq-local company-backends
                          (append '((company-math-symbols-unicode))
                                  company-backends))))
  ;; TODO need to add to inferrior-ess-julia-mode-hook?
  (setq company-minimum-prefix-length 2))
