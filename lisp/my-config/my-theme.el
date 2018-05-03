(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

(setq my-light-theme 'leuven)

(use-package spacemacs-theme :defer t)
(setq my-dark-theme 'spacemacs-dark)

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

(my-leader
  "t" '(:ignore t :which-key "theme")
  "tt" 'my-load-theme
  "tT" 'load-theme
  "tD" 'disable-theme
  "tl" 'load-light-theme
  "td" 'load-dark-theme
  "tL" 'toggle-truncate-lines
  "tm" 'menu-bar-mode)

(load-dark-theme)
