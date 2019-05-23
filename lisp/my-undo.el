;; disable undo-tree because of it's awful bug
;; https://www.reddit.com/r/emacs/comments/85t95p/undo_tree_unrecognized_entry_in_undo_list/
(with-eval-after-load 'evil
  (global-undo-tree-mode -1))

(use-package undo-propose
  :ensure nil
  :general
  (my-leader "U" 'undo-propose))
