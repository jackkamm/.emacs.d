(use-package evil-multiedit
  :commands evil-multiedit-ex-match
  :general (my-leader
	      "se" 'evil-multiedit-match-all
	      "sE" 'evil-multiedit-match-symbol-and-next)
  :init
  (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
  (setq evil-multiedit-follow-matches t)

  :config
  (define-key evil-multiedit-state-map (kbd "C-n")
    'evil-multiedit-match-symbol-and-next)
  (define-key evil-multiedit-state-map (kbd "C-p")
    'evil-multiedit-match-symbol-and-prev)
  (define-key evil-multiedit-state-map "V" nil)
  (define-key evil-multiedit-state-map "n" 'evil-multiedit-next)
  (define-key evil-multiedit-state-map "N" 'evil-multiedit-prev)
  (define-key evil-multiedit-state-map "F" 'iedit-restrict-function)
  (define-key evil-multiedit-state-map (kbd "C-;")
    'evil-multiedit-toggle-or-restrict-region))

;;(global-unset-key (kbd "S-<down-mouse-1>"))
(use-package evil-mc
  :commands turn-on-evil-mc-mode
  :bind ("S-<down-mouse-1>" . 'evil-mc-toggle-cursor-on-click)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'turn-on-evil-mc-mode)))

