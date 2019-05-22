(setq my-region-map (make-sparse-keymap))
(general-create-definer my-region-leader :prefix-map 'my-region-map)
(my-leader "r" '(:keymap my-region-map :which-key "Region"))

(put 'narrow-to-region 'disabled nil)
(setq narrow-to-defun-include-comments t)
(my-region-leader
  "TAB" 'indent-region
  "n" 'narrow-to-region
  "f" 'narrow-to-defun
  "w" 'widen)

(use-package expand-region
  :general
  (my-region-leader
    "v" 'er/expand-region)
  :config
  (setq expand-region-contract-fast-key "V"
	expand-region-reset-fast-key "r"))
