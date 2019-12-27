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

;; enable blinking cursor
(blink-cursor-mode 1) ;gui
(setq visible-cursor t) ;terminal

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

(defun my-load-theme-only (this-theme)
  "Like `load-theme', but also disables previously loaded themes."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
			     (mapcar 'symbol-name
				     (custom-available-themes))))))
  (dolist (theme custom-enabled-themes)
    (disable-theme theme))
  (load-theme this-theme))

(my-theme-leader
  "t" 'my-load-theme-only
  "T" 'customize-themes)

;; install some nice themes
(dolist (theme '(moe-theme
                 zenburn-theme
                 eziam-theme))
  (unless (package-installed-p theme)
    (package-install theme)))

;; load default theme
(load-theme 'zenburn t)

;; Emoji

(use-package emojify
  :commands (emojify-mode
	     global-emojify-mode)
  :init
    (dolist (h (list 'notmuch-show-hook
		     'notmuch-search-hook
		     'notmuch-tree-mode-hook))
      (add-hook h 'emojify-mode)))
