(use-package evil-multiedit
  :commands evil-multiedit-ex-match
  :bind (:map my-leader-map
	      ("s e" . evil-multiedit-match-all)
	      ("s E" . evil-multiedit-match-symbol-and-next))
  :init
  (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
  (setq evil-multiedit-follow-matches t)
  
  :config
  (define-key evil-multiedit-state-map (kbd "C-n")
    'evil-multiedit-match-symbol-and-next)
  (define-key evil-multiedit-state-map (kbd "C-p")
    'evil-multiedit-match-symbol-and-prev)
  (define-key evil-multiedit-state-map "n" 'evil-multiedit-next)
  (define-key evil-multiedit-state-map "N" 'evil-multiedit-prev)
  (define-key evil-multiedit-state-map (kbd "C-;")
    'evil-multiedit-toggle-or-restrict-region))

;;(global-unset-key (kbd "S-<down-mouse-1>"))
(use-package evil-mc
  :commands turn-on-evil-mc-mode
  :bind ("S-<down-mouse-1>" . 'evil-mc-toggle-cursor-on-click)
  :init
  (add-hook 'prog-mode-hook 'turn-on-evil-mc-mode)
  (add-hook 'text-mode-hook 'turn-on-evil-mc-mode))

