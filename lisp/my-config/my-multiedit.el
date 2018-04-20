(use-package iedit
  :general
  (my-leader
    "se" 'iedit-mode)
  :config
  ;; evil-define on iedit modes/maps has strange effects(?)
  ;; create a new minor-mode instead
  (define-minor-mode my-iedit-mode nil :keymap '())
  (add-hook 'iedit-mode-hook (lambda () (my-iedit-mode 1)))
  (add-hook 'iedit-mode-end-hook (lambda () (my-iedit-mode 0)))
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
    (kbd "M-k") 'iedit-expand-up-a-line))

;;(global-unset-key (kbd "S-<down-mouse-1>"))
(use-package evil-mc
  :commands turn-on-evil-mc-mode
  :bind ("S-<down-mouse-1>" . 'evil-mc-toggle-cursor-on-click)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'turn-on-evil-mc-mode)))


