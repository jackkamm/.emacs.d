(my-leader
  "w" '(evil-window-map :which-key "Window"))

(winner-mode)
(bind-keys
 :map evil-window-map
 ("m" . delete-other-windows)
 ("d" . delete-window)
 ("u" . winner-undo)
 ("U" . winner-redo))

(use-package ace-window
  :bind
  (:map evil-window-map
   ("w" . ace-select-window)
   ("D" . ace-delete-window)
   ("M" . ace-swap-window)))

(use-package popwin
  :config
  (popwin-mode 1)
  (push '("^\*Async Shell Command\*.+$"
	  :regexp t
	  :noselect t)
	popwin:special-display-config)
  (push '("*Help*" :stick t)
	popwin:special-display-config))
