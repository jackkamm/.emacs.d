(use-package undo-tree
  :general
  (my-leader "_" 'undo-tree-visualize)
  :init
  (setq undo-tree-enable-undo-in-region nil))
