(use-package helm
  :init
  (setq helm-ff-lynx-style-map nil)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (bind-keys :map my-leader-map
	     ("SPC" . helm-M-x)
	     ("f f" . helm-find-files)
	     ("f r" . helm-recentf)
	     ("b b" . helm-mini))
  (bind-keys :map help-map
	     ("a" . helm-apropos))
  (bind-keys :map helm-map
	     ("C-<backspace>" . helm-delete-minibuffer-contents)
	     ("<tab>" . helm-execute-persistent-action)
	     ("C-i" . helm-execute-persistent-action)
	     ("C-z" . helm-select-action))
  (dolist (m (list helm-find-files-map
		     helm-read-file-map))
    (bind-keys :map m
	       ("C-<backspace>" . helm-find-files-up-one-level)
	       ("<left>" . backward-char)
	       ("<right>" . forward-char))))

;; make helm work better with tramp
(setq helm-buffer-skip-remote-checking t)

(use-package helm-projectile
  :bind (:map my-leader-map
	      ("/" . helm-projectile-ag)))

(use-package helm-swoop
  :bind (:map my-leader-map
	      ("s s" . helm-swoop)))
