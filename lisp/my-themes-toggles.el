;;; my-themes-toggles.el --- Theming & toggles  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:



(setq my-theme-map (make-sparse-keymap))
(general-create-definer my-toggle-leader :prefix-map 'my-theme-map)
(my-leader "t" '(:keymap my-theme-map :which-key "Themes/Toggles"))

(my-toggle-leader
  "c" 'toggle-case-fold-search
  "v" 'visual-line-mode
  "l" 'toggle-truncate-lines
  "m" 'menu-bar-mode
  "n" 'display-line-numbers-mode
  "w" 'subword-mode
  "W" 'superword-mode
  "p" 'auto-fill-mode)

;; disable toolbar/scrollbar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(tool-bar-mode -1)

;; enable tab-bar
(tab-bar-mode 1)

;; minimap
(use-package minimap
  :general
  (my-leader "tM" 'minimap-mode))

;;;; make the cursor more visible
;;(global-hl-line-mode 1)

;; workaround: in server mode, cursor doesn't blink by default
(blink-cursor-mode 1)

;; pos-tip
(use-package pos-tip :demand t)

;;;; whitespace
(setq whitespace-style '(face trailing))
;; doesn't place nice with poly-R-mode
;; TODO disable it only in poly-R-mode?
;;(add-hook 'prog-mode-hook 'whitespace-mode)

(setq-default indent-tabs-mode nil)

;;;; higlighting
;;;; 2024-08-03: Commented b/c `hl-todo-keyword-faces' is rather
;;;; manually defined and doesn't play well with all themes (e.g. xemacs)
;;(use-package hl-todo
;;  :defer 5
;;  :config
;;  (global-hl-todo-mode 1))

;; Themes

;;;; install some nice themes
;;(dolist (theme '(moe-theme
;;                 ;;eziam-themes
;;                 color-theme-modern ;contains xemacs
;;                 zenburn-theme))
;;  (unless (package-installed-p theme)
;;    (package-install theme)))

;; Note that my-base-theme.el should be in `custom-theme-directory'
(load-theme 'my-base t)

(defun my-load-theme-only (this-theme)
  "Like `load-theme', but also disables previously loaded themes."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
			     (mapcar 'symbol-name
				     (custom-available-themes))))))
  (dolist (theme custom-enabled-themes)
    (disable-theme theme))
  (load-theme 'my-base t)
  (load-theme this-theme))

(my-toggle-leader
  "t" 'my-load-theme-only
  "T" 'customize-themes)

;; Emoji

(use-package emojify
  :init
    (dolist (h (list 'notmuch-show-hook
		     'notmuch-search-hook
		     'notmuch-tree-mode-hook))
      (add-hook h 'emojify-mode)))

(provide 'my-themes-toggles)
;;; my-themes-toggles.el ends here
