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

(defvar-local my-undo-checkpoint nil)

(setq my-undo-checkpoint-show nil)

(defun my-undo-checkpoint-buffer (body pos)
  (let ((buf (get-buffer-create (concat  "*Undo Checkpoint: "
                                         (buffer-name) "*"))))
    (when my-undo-checkpoint-show
      (with-current-buffer buf
        (setq buffer-read-only nil)
        (erase-buffer)
        (insert body)
        (goto-char pos)
        (setq buffer-read-only t))
      (display-buffer buf))))

(defun my-undo-save ()
  (interactive)
  (setq my-undo-checkpoint buffer-undo-list)
  (my-undo-checkpoint-buffer (buffer-string) (point)))

(defun my-undo-jump ()
  (interactive)
  (if my-undo-checkpoint
    (let* ((nnil 0)
           (orig-body (buffer-string))
           (orig-pos (point))
           (orig-list buffer-undo-list)
           (list orig-list))
      (while (not (or (eq list nil)
                      (eq list my-undo-checkpoint)))
        (when (eq (car list) nil)
          (setq nnil (+ nnil 1)))
        (setq list (cdr list)))
      (if (eq list my-undo-checkpoint)
          (when (> nnil 0)
            (let (last-command) ;don't continue previous undo
              (dotimes (_ nnil)
                (undo)
                ;; allow redo'ing individual steps later
                (undo-boundary)
                ;; continue the undo in subsequent iterations
                (setq last-command 'undo)))
            (setq my-undo-checkpoint orig-list)
            (my-undo-checkpoint-buffer orig-body orig-pos))
        (message "Checkpoint not in undo history (consider increasing `undo-limit').")))
    (message "No undo checkpoint (did you forget to call `my-undo-save'?)")))

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
