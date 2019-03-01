;; evil
(use-package evil
  :init
  (setq evil-want-keybinding nil) ;needed for evil-collection
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil) ;allow org-mode TAB in terminal
  (setq evil-symbol-word-search t)
  (setq evil-respect-visual-line-mode t)
  (setq evil-disable-insert-state-bindings t)
  (setq evil-insert-state-tag (propertize
                               "  INSERT  " 'face
                               '((:background "green" :foreground "black")))
        evil-emacs-state-tag (propertize
                              "  EMACS  " 'face
                              '((:background "turquoise" :foreground "black"))))
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
   :global-prefix "C-c")

  (general-create-definer my-evil-leader
    :keymaps 'override
    :states '(normal motion visual)
    :prefix "SPC")

  (my-leader
    "a" '(:ignore t :which-key "Applications")
    "q" '(:ignore t :which-key "Quit")
    "m" '(:ignore t :which-key "Major")
    "qq" 'save-buffers-kill-emacs
    "qf" 'delete-frame
    "h" '(:keymap help-map :which-key "Help")
    "u" 'universal-argument
    "z" 'evil-execute-in-emacs-state)

  (my-evil-leader
    "!" 'shell-command
    "SPC" (general-simulate-key "M-x" :which-key "M-x")
    "TAB" 'indent-region)

  (general-create-definer my-major-leader
    :states '(normal motion visual emacs insert)
    :prefix "SPC m"
    :global-prefix "C-c m")
  )

;; hydra
(use-package hydra)

