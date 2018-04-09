(setq window-map (make-sparse-keymap))
(define-key leader-map (kbd "w") window-map)

(define-key window-map (kbd "m") 'delete-other-windows)
(define-key window-map (kbd "d") 'delete-window)

(winner-mode)
(define-key window-map (kbd "u") 'winner-undo)
(define-key window-map (kbd "U") 'winner-redo)

(with-eval-after-load 'evil
  (define-key window-map
    (kbd "l") 'evil-window-right)
  (define-key window-map
    (kbd "h") 'evil-window-left)
  (define-key window-map
    (kbd "j") 'evil-window-down)
  (define-key window-map
    (kbd "k") 'evil-window-up)
  )

(use-package ace-window
  :bind (:map window-map
	      ("w" . ace-select-window)
	      ("D" . ace-delete-window)
	      ("M" . ace-swap-window)))
