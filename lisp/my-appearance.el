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

;;;; make the cursor more visible
;;(global-hl-line-mode 1)

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
                 eziam-theme))
  (unless (package-installed-p theme)
    (package-install theme)))

;; load default theme
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
