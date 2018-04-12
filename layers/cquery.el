(use-package lsp-mode :defer t)
(use-package lsp-ui
  :commands lsp-ui-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :defer t
  :init
  (with-eval-after-load 'lsp-mode
    (push 'company-lsp company-backends)))

(use-package cquery
  :commands lsp-cquery-enable
  :init
  (add-hook 'c-mode-common-hook 'lsp-cquery-enable))

;; FIXME: flycheck not working, e.g. flycheck-list-errors empty
;; however lsp-ui-flycheck-list works
