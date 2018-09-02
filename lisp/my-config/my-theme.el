;; menus, cursors, etc
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

;; prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; pos-tip
(use-package pos-tip)

;; whitespace
(setq whitespace-style '(face trailing))
(setq whitespace-global-modes '(not erc-mode))
(global-whitespace-mode 1)

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

;; relative line numbers in programming modes
(use-package linum-relative
  :config
  (setq linum-relative-current-symbol "")
  (add-hook 'prog-mode-hook 'linum-relative-on)
  (add-hook 'conf-mode-hook 'linum-relative-on))

;; line wrap in text modes
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; theme
(use-package spacemacs-theme :defer t)
(setq my-dark-theme 'spacemacs-dark)
(setq my-light-theme 'spacemacs-light)

(defun my-load-theme (th)
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
			     (mapcar 'symbol-name
				     (custom-available-themes))))))
  (mapcar 'disable-theme custom-enabled-themes)
  (load-theme th t)
  (evil-refresh-cursor))

(defun load-light-theme () (interactive)
       (my-load-theme my-light-theme))

(defun load-dark-theme () (interactive)
       (my-load-theme my-dark-theme))

(load-dark-theme)

;; leader
(my-leader
  "t" '(:ignore t :which-key "theme")
  "tt" 'my-load-theme
  "tT" 'load-theme
  "tD" 'disable-theme
  "tl" 'load-light-theme
  "td" 'load-dark-theme
  "tv" 'visual-line-mode
  "tm" 'menu-bar-mode)
