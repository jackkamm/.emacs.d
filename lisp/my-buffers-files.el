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
 "i" 'ibuffer
 "I" 'ibuffer-other-window
 "o" 'switch-to-buffer-other-window)

(pcase my-completing-read-style
  (`helm
   (my-buffers-leader "b" 'helm-mini))
  (`ivy
   (my-buffers-leader "b" 'ivy-switch-buffer))
  (_
   (my-buffers-leader "b" 'switch-to-buffer)))

(customize-set-variable 'Buffer-menu-name-width 60)

;; Files

(setq my-files-map (make-sparse-keymap))
(general-create-definer my-files-leader :prefix-map 'my-files-map)
(my-leader "f" '(:keymap my-files-map :which-key "File"))

(my-files-leader
  "s" 'save-some-buffers
  "c" 'write-file
  "o" 'find-file-other-window)

(pcase my-completing-read-style
  (`helm
   (my-files-leader
     "f" 'helm-find-files
     "r" 'helm-recentf
     "p" 'helm-projectile-find-file-dwim))
  (`ivy
   (setq counsel-find-file-at-point t)
   (my-files-leader
     "f" 'counsel-find-file
     "r" 'counsel-recentf))
  (_
   (my-files-leader
     "f" 'find-file
     "r" 'recentf-open-files
     "p" 'project-find-file)))

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

(recentf-mode 1)
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

;; Diff'ing

(use-package ediff
  :ensure nil
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
