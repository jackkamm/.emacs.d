(use-package lsp-mode)
(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

(defun cquery//enable ()
  (condition-case nil
      (lsp-cquery-enable)
    (user-error nil)))

(use-package cquery
  :commands lsp-cquery-enable
  :init
  (add-hook 'c-mode-common-hook #'cquery//enable)
  :config
  (setq cquery-executable "/usr/bin/cquery")
  (my-leader
    "jR" 'lsp-rename))
