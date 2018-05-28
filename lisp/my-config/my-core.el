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
  (general-create-definer my-leader :prefix "C-c")
  (general-define-key
   :keymaps 'override
   :states '(normal motion visual)
   "SPC" (general-simulate-key "C-c"))

  (general-create-definer my-major-leader :prefix "C-c c")
  (my-major-leader
    "c" (general-simulate-key "C-c C-c"
	  :which-key "C-c C-c"))

  (my-leader
    "c" '(:ignore t :which-key "Major-mode")
    "a" '(:ignore t :which-key "Applications")
    "h" '(:keymap help-map :which-key "Help")
    ;; quitting
    "q" '(:ignore t :which-key "Quit")
    "qq" 'save-buffers-kill-emacs
    "qf" 'delete-frame))

;; hydra
(use-package hydra)
