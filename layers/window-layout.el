(setq window-map (make-sparse-keymap))
(define-key leader-map (kbd "w") window-map)

(winner-mode)
(bind-keys :map window-map
	   ("m" . delete-other-windows)
	   ("d" . delete-window)
	   ("u" . winner-undo)
	   ("U" . winner-redo)
	   ("l" . evil-window-right)
	   ("h" . evil-window-left)
	   ("j" . evil-window-down)
	   ("k" . evil-window-up))


(use-package ace-window
  :bind (:map window-map
	      ("w" . ace-select-window)
	      ("D" . ace-delete-window)
	      ("M" . ace-swap-window)))
