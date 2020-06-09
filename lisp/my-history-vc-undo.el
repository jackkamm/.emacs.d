;; Undo

;; disable undo-tree
;; https://www.reddit.com/r/emacs/comments/85t95p/undo_tree_unrecognized_entry_in_undo_list/
(with-eval-after-load 'evil
  (global-undo-tree-mode -1)
  (evil-define-key 'normal 'global "u" 'undo-only))

;;(use-package undo-propose
;;  :ensure nil
;;  :general
;;  (my-leader "U" 'undo-propose))

;; Git

(my-leader "g" '(:ignore t :which-key "Git"))

(use-package magit
  :general
  (my-leader
    "gs" 'magit-status))

(use-package git-timemachine
  :general
  (my-leader
    "gt" 'git-timemachine))
