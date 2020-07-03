(use-package helm
  :custom
  (helm-split-window-default-side 'other)
  (helm-buffer-skip-remote-checking t)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (my-leader
    "R" 'helm-resume
    "y" 'helm-show-kill-ring)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (bind-keys :map help-map
	     ("a" . helm-apropos)
             ("i" . helm-info))
  (bind-keys :map helm-map
  	     ("C-<backspace>" . helm-delete-minibuffer-contents)
  	     ("<tab>" . helm-execute-persistent-action)
  	     ("C-i" . helm-execute-persistent-action)
  	     ("M-o" . helm-select-action))
  (dolist (m (list helm-find-files-map
		     helm-read-file-map))
    (bind-keys :map m
	       ("C-<backspace>" . helm-find-files-up-one-level)
	       ("<left>" . backward-char)
	       ("<right>" . forward-char))))

(use-package helm-projectile
    :commands (helm-projectile-ag
               helm-projectile-find-file-dwim))

(use-package helm-ag
  :commands (helm-ag
             helm-do-ag
             helm-ag-buffers
             helm-do-ag-buffers
             helm-do-grep-ag)
  :config
  (bind-keys :map helm-ag-mode-map
             ((kbd "<tab>") . helm-ag-mode-jump-other-window)))

(use-package helm-swoop
  :commands helm-swoop)
