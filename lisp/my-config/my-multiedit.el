(use-package iedit
  :general
  (my-leader
    "se" 'iedit-mode)
  :config
  ;; modifying iedit keymaps with evil has weird side effects,
  ;; so create a new minor-mode
  (define-minor-mode my-iedit-mode nil :keymap '())
  (evil-define-minor-mode-key 'normal 'my-iedit-mode
    ;; TODO add more bindings
    "n" 'iedit-next-occurrence
    "N" 'iedit-prev-occurrence)
  (defun my-iedit-mode-on () (interactive) (my-iedit-mode 1))
  (defun my-iedit-mode-off () (interactive) (my-iedit-mode 0))
  (add-hook 'iedit-mode-hook 'my-iedit-mode-on)
  (add-hook 'iedit-mode-end-hook 'my-iedit-mode-off))

;;(global-unset-key (kbd "S-<down-mouse-1>"))
(use-package evil-mc
  :commands turn-on-evil-mc-mode
  :bind ("S-<down-mouse-1>" . 'evil-mc-toggle-cursor-on-click)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'turn-on-evil-mc-mode)))

