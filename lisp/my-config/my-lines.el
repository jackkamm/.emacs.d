;; relative line numbers in programming modes
(use-package linum-relative
  :config
  (setq linum-relative-current-symbol "")
  (add-hook 'prog-mode-hook 'linum-relative-on)
  (add-hook 'conf-mode-hook 'linum-relative-on))

;; line wrap in text modes
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(column-number-mode)
