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

;; my-undo-save/jump

;; NOTE: A similar functionality of jumping in the undo-history can be
;; achieved with `revert-buffer' (as noted in the Undo manual),
;; however it doesn't count as an `undo' (so can't be skipped over
;; with `undo-only'), and also swapping places in the undo-history is
;; a nice feature of `my-undo-jump'

(defvar-local my-undo-register nil)

(defun my-undo-save ()
  (interactive)
  (setq my-undo-register buffer-undo-list))

(defun my-undo-jump ()
  (interactive)
  (if my-undo-register
    (let* ((nnil 0)
           (orig-list buffer-undo-list)
           (list orig-list))
      (while (not (or (eq list nil)
                      (eq list my-undo-register)))
        (when (eq (car list) nil)
          (setq nnil (+ nnil 1)))
        (setq list (cdr list)))
      (if (eq list my-undo-register)
          (when (> nnil 0)
            ;; prevent continuing undo
            (setq last-command this-command)
            (undo nnil)
            (setq my-undo-register orig-list))
        (message "Failed to find saved location in undo-history.")))
    (message "No saved undo-history (did you forget to call `my-undo-save'?)")))

;; TODO: Functionality that pops up the buffer corresponding to
;; my-undo-register in a side-by-side window for easy reference

(my-leader
  "U" '(:ignore t :which-key "Undo")
  "Us" 'my-undo-save
  "Uj" 'my-undo-jump)

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
