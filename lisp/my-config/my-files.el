(my-leader "f" '(:ignore t :which-key "files"))
(general-create-definer my-files-leader :prefix "C-c f")

(my-files-leader
 "s" 'save-some-buffers
 "c" 'write-file)

(with-eval-after-load "my-helm"
  (my-files-leader
    "f" 'helm-find-files
    "r" 'helm-recentf))

(setq dired-dwim-target t)

(use-package dired-x
  :ensure nil
  :general
  (my-files-leader
   "j" 'dired-jump))

(my-major-leader :keymaps 'dired-mode-map
  "w" 'wdired-change-to-wdired-mode)

(defun my-find-config-module (fname)
  (interactive
   (list (read-file-name
    "Find my config module: "
    (concat user-emacs-directory "lisp/my-config/")
    nil
    'confirm
    (thing-at-point 'symbol t))))
  (switch-to-buffer
   (find-file-noselect fname)))
(my-files-leader "m" 'my-find-config-module)

(recentf-mode 1)
(setq recentf-max-saved-items 1000)

;; remember cursor position, for emacs 25.1 or later
(save-place-mode 1)
