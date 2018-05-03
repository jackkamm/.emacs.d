(my-leader "w" '(:ignore t :which-key "Window"))
(general-create-definer my-windows-leader :prefix "C-c w")

(winner-mode)
(my-windows-leader
 "m" 'delete-other-windows
 "d" 'delete-window
 "u" 'winner-undo
 "U" 'winner-redo
 "l" 'evil-window-right
 "h" 'evil-window-left
 "j" 'evil-window-down
 "k" 'evil-window-up
 "L" 'evil-window-move-far-right
 "H" 'evil-window-move-far-left
 "K" 'evil-window-move-very-top
 "J" 'evil-window-move-very-bottom)

(use-package ace-window
  :general
  (my-windows-leader
   "w" 'ace-select-window
   "D" 'ace-delete-window
   "M" 'ace-swap-window))

(use-package popwin
  :config
  (popwin-mode 1)
  (push '("^\*Async Shell Command\*.+$"
	  :regexp t
	  :noselect t)
	popwin:special-display-config)
  (push '("*Help*" :noselect t)
	popwin:special-display-config))
