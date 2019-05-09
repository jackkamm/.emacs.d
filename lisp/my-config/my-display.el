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
   ("M" . ace-swap-window))
  :config
  (set-face-attribute
     'aw-leading-char-face nil
     :weight 'bold
     :height 2.0))

(setq help-window-select t)
