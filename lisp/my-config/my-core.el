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
  (general-create-definer my-leader
    :states '(motion normal visual insert emacs)
    :prefix "SPC"
    :keymaps 'override
    :global-prefix "M-m")
  (my-leader
    "u" 'universal-argument
    "z" 'evil-execute-in-emacs-state
    "!" 'shell-command
    "h" '(:keymap help-map :which-key "help")
    "<tab>" 'indent-region
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
    "m" '(:ignore t :which-key "major")
    "j" '(:ignore t :which-key "jump")
    "i" '(:ignore t :which-key "insert")
    "g" '(:ignore t :which-key "git")
    "s" '(:ignore t :which-key "search"))
  (define-key key-translation-map (kbd "SPC c") (kbd "C-c"))
  (define-key key-translation-map (kbd "M-m c") (kbd "C-c"))
  (general-create-definer my-major-leader
    :states '(motion visual insert emacs)
    :prefix "SPC m"
    :global-prefix "M-m m")
  (general-create-definer my-eval-leader
    :states '(motion visual insert emacs)
    :prefix "SPC e"
    :global-prefix "M-m e"))
