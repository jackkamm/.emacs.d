(setq my-frames-map (make-sparse-keymap))
(general-create-definer my-frames-leader :prefix-map 'my-frames-map)
(my-leader "F" '(:keymap my-frames-map :which-key "Frames"))

(defun my-pop-window ()
  (interactive)
  (let ((buffer (current-buffer))
        (window (selected-window)))
    (make-frame)
    (delete-window window)))

(my-frames-leader
 "n" 'make-frame
 "p" 'my-pop-window
 "d" 'delete-frame)

(my-leader
  "w" '(evil-window-map :which-key "Window"))

(bind-keys
 :map evil-window-map
 ((kbd "<down>") . evil-window-down)
 ((kbd "<up>") . evil-window-up)
 ((kbd "<right>") . evil-window-right)
 ((kbd "<left>") . evil-window-left))

(winner-mode)
;; Use hydra so winner-undo works with my general-simulate-key leader
(defhydra my-winner-hydra ()
  "winner"
  ("u" winner-undo)
  ("U" winner-redo))

(bind-keys
 :map evil-window-map
 ("m" . delete-other-windows)
 ("d" . delete-window)
 ("u" . my-winner-hydra/winner-undo)
 ("U" . my-winner-hydra/winner-redo))

(use-package ace-window
  :bind
  (:map evil-window-map
   ("w" . ace-select-window)
   ("D" . ace-delete-window)
   ("M" . ace-swap-window))
  :config
  (set-face-attribute
     'aw-leading-char-face nil
     :weight 'bold
     :height 2.0))

(setq help-window-select t)
