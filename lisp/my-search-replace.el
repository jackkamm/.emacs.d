(setq my-search-map (make-sparse-keymap))
(general-create-definer my-search-replace-leader :prefix-map 'my-search-map)
(my-leader "s" '(:keymap my-search-map :which-key "Search/replace"))

(my-search-replace-leader "l" 'lgrep)
(my-search-replace-leader "r" 'rgrep)

;; wgrep
(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :config
  (advice-add 'wgrep-change-to-wgrep-mode :after #'evil-normal-state)
  (advice-add 'wgrep-finish-edit :after #'evil-motion-state)
  (advice-add 'wgrep-abort-changes :after #'evil-motion-state))

;; helm
(with-eval-after-load "my-helm"
  (use-package helm-ag
    :commands (helm-ag
	       helm-do-ag
	       helm-ag-buffers
	       helm-do-ag-buffers)
    :general (my-search-replace-leader
	       "g" 'helm-do-ag))

  (use-package helm-swoop
    :general (my-search-replace-leader
	       "s" 'helm-swoop)))

;; ivy
(with-eval-after-load "my-ivy"
  (use-package swiper
    :general
    (my-search-replace-leader
      "s" 'swiper
      "f" 'counsel-locate
      "i" 'swiper-from-isearch)))

;; visualstar
(use-package evil-visualstar
  :config
  (global-evil-visualstar-mode))

;; iedit
(use-package evil-iedit-state
  :general
  (my-search-replace-leader
    "e" 'evil-iedit-state/iedit-mode))

;; multiple-cursors
(use-package evil-mc
  :general (my-search-replace-leader
	     "m" 'my-toggle-evil-mc-mode)
  :init
  (setq evil-mc-custom-known-commands
        '((backward-kill-word
           . ((:default . evil-mc-execute-default-call-with-count)))
          (delete-char
           . ((:default . evil-mc-execute-default-call-with-count)))
          (kill-word
           . ((:default . evil-mc-execute-default-call-with-count)))))
  :config
  (defun my-toggle-evil-mc-mode () (interactive)
         (if evil-mc-mode
             (progn
               (evil-mc-undo-all-cursors)
               (turn-off-evil-mc-mode)
               (message "Disabled evil-mc-mode"))
           (turn-on-evil-mc-mode)
           (message "Enabled evil-mc-mode")))
  (define-key evil-mc-key-map (kbd "M-C-<mouse-1>")
    'evil-mc-toggle-cursor-on-click))
