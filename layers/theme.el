(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 
(blink-cursor-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t)
  )
