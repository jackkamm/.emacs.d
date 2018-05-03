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
    ;; buffers
    "b" '(:ignore t :which-key "buffer")
    "bd" 'kill-buffer
    "bx" 'kill-buffer-and-window
    ;; files
    "f" '(:ignore t :which-key "file")
    "fs" 'save-some-buffers
    "fc" 'write-file
    ;; help
    "h" '(:keymap help-map :which-key "help")
    ;; insertion
    "i" '(:ignore t :which-key "insert")
    "i <tab>" 'indent-region
    ;; quitting
    "q" '(:ignore t :which-key "quit")
    "qq" 'save-buffers-kill-emacs
    "qf" 'delete-frame
    ;; commands
    "x" '(:ignore t :which-key "cmd")
    "xu" 'universal-argument
    "xz" 'evil-execute-in-emacs-state
    "x!" 'shell-command
    "x&" 'async-shell-command
    ;; other prefixes
    "a" '(:ignore t :which-key "app")
    "e" '(:ignore t :which-key "eval")
    "j" '(:ignore t :which-key "jump")
    "m" '(:ignore t :which-key "major")
    "s" '(:ignore t :which-key "search"))
  (general-create-definer my-major-leader
    :states '(motion visual insert emacs)
    :prefix "S-SPC"
    :global-prefix "C-c m")
  (general-create-definer my-eval-leader
    :prefix "C-c e"))
