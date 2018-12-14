(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(blink-cursor-mode -1)
(tool-bar-mode -1)

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

;; theme
(use-package material-theme
  :config
  (setq my-dark-theme 'material)
  (setq my-light-theme 'material-light))

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
  "tr" 'toggle-truncate-lines
  "tm" 'menu-bar-mode)

(setq-default indent-tabs-mode nil)
