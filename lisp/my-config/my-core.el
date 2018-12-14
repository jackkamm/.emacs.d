;; evil
(use-package evil
  :init
  (setq evil-want-keybinding nil) ;needed for evil-collection
  ;;(setq evil-want-integration nil) ;needed for evil-collection
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil) ;allow org-mode TAB in terminal
  (setq evil-symbol-word-search t)
  (setq evil-respect-visual-line-mode t)
  (setq evil-disable-insert-state-bindings t)
  (setq evil-motion-state-cursor 'box
        evil-visual-state-cursor 'box
        evil-normal-state-cursor 'box
        evil-insert-state-cursor 'bar
        evil-emacs-state-cursor  'hbar)
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
   :non-normal-prefix "C-c c")

  (my-leader
    "a" '(:ignore t :which-key "Applications")
    "q" '(:ignore t :which-key "Quit")
    "m" '(:ignore t :which-key "Major")
    "qq" 'save-buffers-kill-emacs
    "qf" 'delete-frame
    "h" '(:keymap help-map :which-key "Help")
    "u" 'universal-argument
    "z" 'evil-execute-in-emacs-state
    "!" 'shell-command
    "SPC" (general-simulate-key "M-x" :which-key "M-x")
    "TAB" 'indent-region
    ;"c" (general-simulate-key "C-c" :which-key "C-c")
    )

  (general-create-definer my-major-leader
    :states '(normal motion visual)
    :prefix "SPC m")
  )

;; hydra
(use-package hydra)

