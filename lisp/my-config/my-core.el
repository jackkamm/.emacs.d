;; evil
(use-package evil
  :init
  (setq evil-want-integration nil) ;needed for evil-collection
  (setq evil-want-C-u-scroll t)
  (setq evil-respect-visual-line-mode t)
  :config
  (evil-global-set-key 'motion (kbd "SPC") nil) ;for leader prefix
  (evil-mode))

;; which-key
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-sort-order 'which-key-key-order-alpha))

;; general
(use-package general
  :config
  (general-override-mode)

  (general-create-definer my-leader
   :keymaps 'override
   :states '(normal motion visual emacs insert)
   :prefix "SPC"
   :global-prefix "C-c c")

  (my-leader
    "q" '(:ignore t :which-key "Quit")
    "qq" 'save-buffers-kill-emacs
    "qf" 'delete-frame
    "h" '(:keymap help-map :which-key "Help")
    "u" 'universal-argument
    "z" 'evil-execute-in-emacs-state
    "!" 'shell-command
    "&" 'async-shell-command
    "SPC" (general-simulate-key "M-x" :which-key "M-x"))

  (general-create-definer my-major-leader
    :states '(normal motion visual)
    :prefix "SPC m")
  )

;; hydra
(use-package hydra)

