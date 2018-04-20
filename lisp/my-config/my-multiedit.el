(use-package iedit
  :general
  (my-leader
    "se" 'iedit-mode)
  :config
  ;; evil-define on iedit keymaps has side effects(?),
  ;; so create a new minor-mode
  (define-minor-mode my-iedit-mode nil :keymap '())
  (evil-define-minor-mode-key 'normal 'my-iedit-mode
    (kbd "<escape>") 'iedit-quit
    "n" 'iedit-next-occurrence
    "N" 'iedit-prev-occurrence
    (kbd "/ f") 'iedit-restrict-function
    (kbd "/ v") 'iedit-show/hide-unmatched-lines
    (kbd "/ /") 'iedit-toggle-selection
    (kbd "RET") 'iedit-toggle-selection
    (kbd "/ n") 'iedit-expand-down-to-occurrence
    (kbd "C-j") 'iedit-expand-down-to-occurrence
    (kbd "/ N") 'iedit-expand-up-to-occurrence
    (kbd "C-k") 'iedit-expand-up-to-occurrence
    (kbd "/ l") 'iedit-restrict-current-line
    (kbd "M-l") 'iedit-restrict-current-line
    (kbd "/ j") 'iedit-expand-down-a-line
    (kbd "M-j") 'iedit-expand-down-a-line
    (kbd "/ k") 'iedit-expand-up-a-line
    (kbd "M-k") 'iedit-expand-up-a-line)
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


