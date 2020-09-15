;; Undo

;; disable undo-tree
;; https://www.reddit.com/r/emacs/comments/85t95p/undo_tree_unrecognized_entry_in_undo_list/
(with-eval-after-load 'evil
  (global-undo-tree-mode -1)
  (evil-define-key 'normal 'global "u" 'undo-only)
  (evil-define-key 'normal 'global (kbd "C-r") 'undo-redo))

;; access undo-only from visual/insert state
(define-key global-map (kbd "C-x u") 'undo-only)

;; NOTE: use `revert-buffer' instead of `undo-propose' for checkpointing
;;(use-package undo-propose
;;  :ensure nil
;;  :general
;;  (my-leader "U" 'undo-propose))

;; TODO: submit to simple.el
(defun undo-continue (&optional arg)
  (interactive)
  (let ((last-command 'undo))
    (undo arg)))

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

;; Backup files

(let ((backup-dir (concat user-emacs-directory "backups/")))
  (if (not (file-exists-p backup-dir))
      (make-directory backup-dir t))
  (customize-set-variable 'backup-directory-alist `(("." . ,backup-dir))))
