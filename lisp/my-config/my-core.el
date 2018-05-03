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
  (general-define-key
   :keymaps 'override
   :states '(normal motion visual)
   "SPC" (general-simulate-key "C-c"))
  (general-create-definer my-leader
    :prefix "C-c")
  (my-leader
    "xu" 'universal-argument
    "xz" 'evil-execute-in-emacs-state
    "x!" 'shell-command
    "x&" 'async-shell-command
    "h" '(:keymap help-map :which-key "help")
    "i <tab>" 'indent-region
    ;; buffers
    "b" '(:ignore t :which-key "buffer")
    "bd" 'kill-buffer
    "bx" 'kill-buffer-and-window
    ;; quitting
    "q" '(:ignore t :which-key "quit")
    "qq" 'save-buffers-kill-emacs
    "qf" 'delete-frame
    ;; files
    "f" '(:ignore t :which-key "file")
    "fs" 'save-some-buffers
    "fc" 'write-file
    ;; other prefixes
    "a" '(:ignore t :which-key "app")
    "e" '(:ignore t :which-key "eval")
    "g" '(:ignore t :which-key "git")
    "i" '(:ignore t :which-key "insert")
    "j" '(:ignore t :which-key "jump")
    "m" '(:ignore t :which-key "major")
    "s" '(:ignore t :which-key "search")
    "x" '(:ignore t :which-key "cmd"))
  (general-create-definer my-major-leader
    :states '(motion visual insert emacs)
    :prefix "S-SPC"
    :global-prefix "C-c m")
  (general-create-definer my-eval-leader
    :prefix "C-c e"))
