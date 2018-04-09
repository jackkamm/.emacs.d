(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 
(blink-cursor-mode -1)

(define-key leader-map (kbd "t") 'load-theme)

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t)
  )
