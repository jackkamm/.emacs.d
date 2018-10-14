(setq my-search-map (make-sparse-keymap))
(general-create-definer my-search-replace-leader :prefix-map 'my-search-map)
(my-leader "s" '(:keymap my-search-map :which-key "Search/replace"))

(my-search-replace-leader "l" 'lgrep)
(my-search-replace-leader "r" 'rgrep)

(use-package projectile
  :general (my-search-replace-leader
	     "p" 'projectile-grep))

;;; helm
(with-eval-after-load "my-helm"
  (use-package helm-ag
    :commands (helm-ag
	       helm-do-ag
	       helm-ag-buffers
	       helm-do-ag-buffers)
    :general (my-search-replace-leader
	       "g" 'helm-do-ag))

  (use-package helm-projectile
    :general (my-search-replace-leader
	       "p" 'helm-projectile-ag))

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
      "i" 'swiper-from-isearch))

  (my-search-replace-leader
    "p" 'counsel-projectile-grep))

;;; wgrep

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode)

;;; iedit

(use-package evil-iedit-state
  :general
  (my-search-replace-leader
    "e" 'evil-iedit-state/iedit-mode))

;; multiple-cursors

(use-package multiple-cursors
  :bind (("S-<down-mouse-1>" . nil)
	 ("S-<mouse-1>" . 'mc/add-cursor-on-click))
  :config
  (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook 'evil-exit-emacs-state)
  (define-key mc/keymap (kbd "<return>") nil))
