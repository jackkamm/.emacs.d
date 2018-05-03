(my-leader "e" '(:ignore t :which-key "Edit"))
(general-create-definer my-edit-leader :prefix "C-c e")

(my-edit-leader
 "<tab>" 'indent-region)

;;; undo-tree

(use-package undo-tree
  :general
  (my-edit-leader
    "u" 'undo-tree-visualize))

;;; ediff

(use-package ediff
  :commands ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (use-package evil-ediff :after evil))
