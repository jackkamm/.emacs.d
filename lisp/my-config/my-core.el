;; evil
(use-package evil
  :init
  (setq evil-want-keybinding nil) ;needed for evil-collection
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil) ;allow org-mode TAB in terminal
  (setq evil-symbol-word-search t)
  (setq evil-respect-visual-line-mode t)
  ;; make emacs- and insert-states identical
  (setq evil-disable-insert-state-bindings t)
  :config
  ;; make emacs- and insert-states identical
  (defalias 'evil-emacs-state 'evil-insert-state)
  (setq evil-insert-state-tag (propertize
                               "  INSERT  " 'face
                               '((:background "turquoise" :foreground "black"))))
  ;; Remove SPC/RET keybindings
  (evil-global-set-key 'motion (kbd "SPC") nil)
  (evil-global-set-key 'motion (kbd "RET") nil)
  ;; https://vim.fandom.com/wiki/Unused_keys
  (evil-global-set-key 'motion "+" 'repeat)
  ;; Start evil
  (evil-mode))

;; which-key
(use-package which-key
  :custom
  (which-key-sort-order 'which-key-key-order-alpha)
  (which-key-enable-extended-define-key t)
  :config
  (which-key-mode))

;; general
(use-package general
  :config
  (general-override-mode)

  (general-create-definer my-leader :prefix "C-c")

  (general-define-key
   :keymaps 'override
   :states '(normal motion visual)
   "SPC" (general-simulate-key "C-c"))

  (my-leader
    "a" '(:ignore t :which-key "Applications")
    "q" '(:ignore t :which-key "Quit")
    "m" '(:ignore t :which-key "Major")
    "k" 'which-key-show-top-level
    "qq" 'save-buffers-kill-emacs
    "h" '(:keymap help-map :which-key "Help")
    "u" 'universal-argument
    "z" 'evil-execute-in-emacs-state
    "x" (general-simulate-key "M-x" :which-key "M-x"))

  (general-create-definer my-major-leader
    :states '(normal motion visual emacs insert)
    :prefix "SPC m"
    :global-prefix "C-c m")
  )

;; hydra
(use-package hydra)

