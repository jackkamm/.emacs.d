;; disable undo-tree because of it's awful bug
;; https://www.reddit.com/r/emacs/comments/85t95p/undo_tree_unrecognized_entry_in_undo_list/
(with-eval-after-load 'evil
  (global-undo-tree-mode -1))

(my-evil-leader
  "_" 'undo-only)

;;(use-package undo-tree
;;  :general
;;  (my-leader "_" 'undo-tree-visualize)
;;  :init
;;  (setq undo-tree-enable-undo-in-region nil))
