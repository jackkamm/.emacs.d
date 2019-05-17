(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; line wrap in text modes
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'text-mode-hook (lambda () (setq-local display-line-numbers-type 'visual)))

(column-number-mode)
