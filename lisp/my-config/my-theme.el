;;; menus, cursors, etc

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

;;; prompts

(defalias 'yes-or-no-p 'y-or-n-p)

;;; pos-tip

(use-package pos-tip)

;;; whitespace

(setq whitespace-style '(face trailing))
(setq whitespace-global-modes '(not erc-mode))
(global-whitespace-mode 1)

;;; higlighting

(use-package hl-todo
  :config
  (global-hl-todo-mode 1))

(use-package evil-search-highlight-persist
  :config
  (global-evil-search-highlight-persist)
  (my-leader
    "sc" 'evil-search-highlight-persist-remove-all))

;;; line numbers

(use-package linum-relative
  :config
  (setq linum-relative-current-symbol "")
  ;;(linum-relative-global-mode 1)
  (define-globalized-minor-mode
    my-global-linum-relative-mode
    linum-relative-mode
    (lambda ()
      (when (derived-mode-p 'prog-mode 'text-mode)
	(unless (memq major-mode (list 'org-mode))
	    (linum-relative-mode 1)))))
  (my-global-linum-relative-mode 1))

;;; theme

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

(my-leader
  "t" '(:ignore t :which-key "theme")
  "tt" 'my-load-theme
  "tT" 'load-theme
  "tD" 'disable-theme
  "tl" 'load-light-theme
  "td" 'load-dark-theme
  "tL" 'toggle-truncate-lines
  "tm" 'menu-bar-mode)
