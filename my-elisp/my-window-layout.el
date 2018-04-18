(setq window-map (make-sparse-keymap))

(my-leader
  "w" '(:keymap window-map :which-key "window"))

(winner-mode)
(bind-keys :map window-map
	   ("m" . delete-other-windows)
	   ("d" . delete-window)
	   ("u" . winner-undo)
	   ("U" . winner-redo)
	   ("l" . evil-window-right)
	   ("h" . evil-window-left)
	   ("j" . evil-window-down)
	   ("k" . evil-window-up)
	   ("L" . evil-window-move-far-right)
	   ("H" . evil-window-move-far-left)
	   ("K" . evil-window-move-very-top)
	   ("J" . evil-window-move-very-bottom))


(use-package ace-window
  :bind (:map window-map
	      ("w" . ace-select-window)
	      ("D" . ace-delete-window)
	      ("M" . ace-swap-window)))
