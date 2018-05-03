(use-package undo-tree
  :general
  (my-leader
    "u" '(:ignore-key t :which-key "undo")
    "uu" 'undo-tree-visualize))
