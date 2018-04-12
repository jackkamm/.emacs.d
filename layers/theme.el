;(menu-bar-mode -1) 
(scroll-bar-mode -1) 
(tool-bar-mode -1) 
(blink-cursor-mode -1)

(use-package material-theme :defer t)

(setq my-light-theme 'leuven)
(setq my-dark-theme 'material)

(defun load-light-theme () (interactive)
       (disable-theme my-dark-theme)
       (load-theme my-light-theme t)
       (evil-refresh-cursor))
(defun load-dark-theme () (interactive)
       (disable-theme my-light-theme)
       (load-theme my-dark-theme t)
       (evil-refresh-cursor))

;;(load-light-theme)
;;(load-material)
(load-dark-theme)

(my-leader
  "t" '(:ignore t :which-key "theme")
  "tt" 'load-theme
  "tl" 'load-light-theme
  "td" 'load-dark-theme)

;; evil cursor colors
(setq evil-normal-state-cursor "orange"
    evil-motion-state-cursor "violet"
    evil-insert-state-cursor '(bar "turquoise")
    evil-emacs-state-cursor "turquoise")
