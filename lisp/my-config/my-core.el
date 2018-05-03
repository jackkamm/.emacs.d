;; evil
(use-package evil
  :init
  (setq evil-want-integration nil) ;needed for evil-collection
  (setq evil-want-C-u-scroll t)
  :config
  (evil-global-set-key 'motion (kbd "SPC") nil) ;for leader prefix
  (evil-mode))

;; which-key
(use-package which-key :config (which-key-mode))

;; general
(use-package general
  :config
  (general-override-mode)
  (general-create-definer my-leader :prefix "C-c")
  (general-create-definer my-major-leader :prefix "C-c m")
  (general-create-definer my-eval-leader :prefix "C-c m e")

  (general-define-key
   :keymaps 'override
   :states '(normal motion visual)
   "SPC" (general-simulate-key "C-c")
   "S-SPC" (general-simulate-key "C-c m"))

  (my-major-leader
    "e" '(:ignore t :which-key "eval"))

  (my-leader
    "m" '(:ignore t :which-key "major")
    "a" '(:ignore t :which-key "app")
    "h" '(:keymap help-map :which-key "help")
    ;; quitting
    "q" '(:ignore t :which-key "quit")
    "qq" 'save-buffers-kill-emacs
    "qf" 'delete-frame))

;; hydra
(use-package hydra)
