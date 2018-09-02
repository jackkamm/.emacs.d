(setq my-files-map (make-sparse-keymap))
(general-create-definer my-files-leader :prefix-map 'my-files-map)
(my-leader "f" '(:keymap my-files-map :which-key "File"))

(my-files-leader
 "s" 'save-some-buffers
 "c" 'write-file)

(with-eval-after-load "my-helm"
  (my-files-leader
    "f" 'helm-find-files
    "r" 'helm-recentf))

(with-eval-after-load "my-ivy"
  (my-files-leader
    "f" 'counsel-find-file
    "r" 'counsel-recentf))

;; human-readable file sizes
(setq dired-listing-switches "-alh")
;; copy to dired in other-window by default
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

(setq recentf-max-saved-items 1000)

;; remember cursor position, for emacs 25.1 or later
(save-place-mode 1)
