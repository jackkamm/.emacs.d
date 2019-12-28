(use-package ess-julia-mode
  :ensure ess
  :mode (("\\.jl\\'" . ess-julia-mode)))

;; TODO put this somewhere else...
(use-package company-math
  :after company
  :config
  (add-hook 'ess-julia-mode-hook
            (lambda ()
              (setq-local company-backends
                          (append '((company-math-symbols-unicode))
                                  company-backends))))
  ;; TODO need to add to inferrior-ess-julia-mode-hook?
  (setq company-minimum-prefix-length 2))

;;;; alternative config using julia-repl instead of ess
;;;; It uses term instead of shell for the repl, which disables
;;;; lots of keybindings.
;;;; I think I prefer to use emamux rather than relying on term.el
;;
;;(use-package julia-mode
;;  :mode (("\\.jl\\'" . julia-mode)))
;;
;;(use-package julia-repl
;;  :commands julia-repl-mode)
;;(add-hook 'julia-mode-hook 'julia-repl-mode)
