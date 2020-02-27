(use-package helm
  :custom
  (helm-split-window-default-side 'other)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (my-leader "R" 'helm-resume)
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

;; make helm work better with tramp
(setq helm-buffer-skip-remote-checking t)
