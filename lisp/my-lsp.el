(use-package lsp-mode :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(with-eval-after-load "my-python" (add-hook 'python-mode-hook #'lsp))
