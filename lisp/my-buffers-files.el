;; Buffers

(setq my-buffers-map (make-sparse-keymap))
(general-create-definer my-buffers-leader :prefix-map 'my-buffers-map)
(my-leader "b" '(:keymap my-buffers-map :which-key "Buffer"))

(my-buffers-leader
 "d" 'kill-current-buffer
 "D" 'kill-buffer
 "x" 'kill-buffer-and-window
 "r" 'revert-buffer
 "#" 'server-edit
 "c" 'clone-indirect-buffer
 "m" 'buffer-menu
 "M" 'buffer-menu-other-window
 "o" 'switch-to-buffer-other-window)

(with-eval-after-load "my-helm"
  (my-buffers-leader
   "b" 'helm-mini))

(with-eval-after-load "my-ivy"
  (my-buffers-leader
    "b" 'ivy-switch-buffer))

;; Files

(setq my-files-map (make-sparse-keymap))
(general-create-definer my-files-leader :prefix-map 'my-files-map)
(my-leader "f" '(:keymap my-files-map :which-key "File"))

(my-files-leader
 "s" 'save-some-buffers
 "c" 'write-file
 "o" 'find-file-other-window)

(with-eval-after-load "my-helm"
  (my-files-leader
    "f" 'helm-find-files
    "r" 'helm-recentf))

(with-eval-after-load "my-ivy"
  (setq counsel-find-file-at-point t)
  (my-files-leader
    "f" 'counsel-find-file
    "r" 'counsel-recentf))

(defun my-find-config-module (fname)
  (interactive
   (list (read-file-name
    "Find my config module: "
    (concat user-emacs-directory "lisp/"))))
  (switch-to-buffer
   (find-file-noselect fname)))
(my-files-leader "m" 'my-find-config-module)

(defun my-copy-filename ()
  (interactive)
  (message
   (kill-new
    (or (buffer-file-name)
	default-directory))))
(my-files-leader "y" 'my-copy-filename)

(setq recentf-max-saved-items 1000)

(save-place-mode 1)

;; Dired

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

(evil-set-initial-state 'wdired-mode 'normal)

;; Diff'ing

(use-package ediff
  :commands ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
