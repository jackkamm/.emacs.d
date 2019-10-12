(setq my-theme-map (make-sparse-keymap))
(general-create-definer my-theme-leader :prefix-map 'my-theme-map)
(my-leader "t" '(:keymap my-theme-map :which-key "Theme"))

(my-theme-leader
  "v" 'visual-line-mode
  "l" 'toggle-truncate-lines
  "m" 'menu-bar-mode)

;; disable toolbar/scrollbar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(tool-bar-mode -1)

;; minimap
(use-package minimap
  :general
  (my-leader "tM" 'minimap-mode))

;; disable blinking cursor:
(blink-cursor-mode -1) ;gui
(setq visible-cursor nil) ;terminal

;; pos-tip
(use-package pos-tip)

;;;; whitespace
(setq whitespace-style '(face trailing))
(add-hook 'prog-mode-hook 'whitespace-mode)

(setq-default indent-tabs-mode nil)

;; higlighting
(use-package hl-todo
  :defer 5
  :config
  (global-hl-todo-mode 1))

(use-package evil-search-highlight-persist
  :config
  (global-evil-search-highlight-persist)
  (my-leader
    "sc" 'evil-search-highlight-persist-remove-all))

;; Themes

(unless (package-installed-p 'moe-theme) (package-install 'moe-theme))

(my-theme-leader
  "T" 'load-theme
  "D" 'disable-theme)

(load-theme 'moe-dark t)

;; Emoji

(use-package emojify
  :commands (emojify-mode
	     global-emojify-mode)
  :init
    (dolist (h (list 'notmuch-show-hook
		     'notmuch-search-hook
		     'notmuch-tree-mode-hook))
      (add-hook h 'emojify-mode)))
