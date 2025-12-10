;;; my-history-vc-undo.el ---                        -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Undo

;; access undo-only from visual/insert state
(define-key global-map (kbd "C-x u") 'undo-only)

;; TODO: submit to simple.el
(defun undo-continue (&optional arg)
  (interactive "*p")
  (let ((last-command 'undo))
    (undo arg)))

;; Backport of emacs28 undo-redo

(unless (fboundp 'undo-redo)
  (defun my-undo-redo (&optional arg)
    "Undo the last ARG undos."
    (interactive "*p")
    (cond
     ((not (my-undo--last-change-was-undo-p buffer-undo-list))
      (user-error "No undo to undo"))
     (t
      (let* ((ul buffer-undo-list)
             (new-ul
              (let ((undo-in-progress t))
                (while (and (consp ul) (eq (car ul) nil))
                  (setq ul (cdr ul)))
                (primitive-undo arg ul)))
             (new-pul (my-undo--last-change-was-undo-p new-ul)))
        (message "Redo%s" (if undo-in-region " in region" ""))
        (setq this-command 'undo)
        (setq pending-undo-list new-pul)
        (setq buffer-undo-list new-ul)))))

  (defun my-undo--last-change-was-undo-p (undo-list)
    (while (and (consp undo-list) (eq (car undo-list) nil))
      (setq undo-list (cdr undo-list)))
    (gethash undo-list undo-equiv-table))

  (defalias 'undo-redo 'my-undo-redo))

;; Git

(my-leader "g" '(:ignore t :which-key "Git"))

(use-package magit
  :general
  (my-leader
    "gs" 'magit-status)
  :config
  (defun my-magit-ls-lh (file)
    "Open FILE with `dired-do-async-shell-command'.
Interactively, open the file at point."
    (interactive (list (or (magit-file-at-point)
                           (completing-read "Act on file: "
                                            (magit-list-files)))))
    (shell-command (format "ls -lh '%s'" file)))
  (define-key magit-status-mode-map "." 'my-magit-ls-lh)
  (transient-append-suffix 'magit-merge "-s"
    '("-a" "Allow unrelated histories" "--allow-unrelated-histories")))

(use-package git-timemachine
  :general
  (my-leader
    "gt" 'git-timemachine))

(use-package magit-annex
  :after magit :demand t)




;; Backup files

(let ((backup-dir (concat user-emacs-directory "backups/")))
  (if (not (file-exists-p backup-dir))
      (make-directory backup-dir t))
  (setq backup-directory-alist `(("." . ,backup-dir))))

(provide 'my-history-vc-undo)
;;; my-history-vc-undo.el ends here
