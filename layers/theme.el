(menu-bar-mode -1) 
(scroll-bar-mode -1) 
(tool-bar-mode -1) 
(blink-cursor-mode -1)

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t)
  (defun load-solarized-light () (interactive)
	 (load-theme 'solarized-light))
  (defun load-solarized-dark () (interactive)
	 (load-theme 'solarized-dark))
  (my-leader
    "t" '(:ignore t :which-key "theme")
    "tt" 'load-theme
    "tl" 'load-solarized-light
    "td" 'load-solarized-dark))

;; evil cursor colors
(setq evil-normal-state-cursor "orange"
    evil-motion-state-cursor "violet"
    evil-insert-state-cursor '(bar "turquoise")
    evil-emacs-state-cursor "turquoise")
