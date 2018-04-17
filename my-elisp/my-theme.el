(menu-bar-mode -1) 
(scroll-bar-mode -1) 
(tool-bar-mode -1) 
(blink-cursor-mode -1)

(use-package material-theme :defer t)

(setq my-light-theme 'leuven)
(setq my-dark-theme 'material)

(defun my-load-theme (th)
       (mapcar 'disable-theme custom-enabled-themes)
       (load-theme th t)
       (evil-refresh-cursor))

(defun load-light-theme () (interactive)
       (my-load-theme my-light-theme))

(defun load-dark-theme () (interactive)
       (my-load-theme my-dark-theme))

(my-leader
  "t" '(:ignore t :which-key "theme")
  "tt" 'load-theme
  "tT" 'disable-theme
  "tl" 'load-light-theme
  "td" 'load-dark-theme)

(load-dark-theme)
