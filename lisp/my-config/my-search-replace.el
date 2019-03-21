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
	       "P" 'helm-projectile-ag))

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
    "P" 'counsel-projectile-grep))

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
  :bind (("M-C-<mouse-1>" . 'mc/add-cursor-on-click))
  :config
  ;; use insert/emacs state in multiple-cursors mode
  (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
  ;; remap escape to quit multiple-cursors
  (define-key mc/keymap [remap evil-normal-state] 'mc/keyboard-quit)
  ;; switch back to normal state when exiting multiple-cursors
  (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)
  ;; allow ENTER in multiple-cursors mode
  (define-key mc/keymap (kbd "<return>") nil))
