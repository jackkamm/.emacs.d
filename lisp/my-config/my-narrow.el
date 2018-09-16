(setq my-narrow-map (make-sparse-keymap))
(general-create-definer my-narrow-leader :prefix-map 'my-narrow-map)
(my-leader "n" '(:keymap my-narrow-map :which-key "narrow"))

(put 'narrow-to-region 'disabled nil)
(setq narrow-to-defun-include-comments t)
(my-narrow-leader
  "r" 'narrow-to-region
  "f" 'narrow-to-defun
  "w" 'widen)
