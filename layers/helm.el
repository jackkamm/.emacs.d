(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  (bind-keys :map my-leader-map
	     ("SPC" . helm-M-x)
	     ("f f" . helm-find-files)
	     ("f r" . helm-recentf)
	     ("b b" . helm-buffers-list))
  (bind-keys :map help-map
	     ("a" . helm-apropos))
  (bind-keys :map helm-map
	     ("<tab>" . helm-execute-persistent-action)
	     ("C-i" . helm-execute-persistent-action)
	     ("C-z" . helm-select-action)
	     ("M-x" . helm-select-action)))

(use-package helm-projectile
  :bind (:map my-leader-map
	      ("/" . helm-projectile-ag)))

(use-package helm-swoop
  :bind (:map my-leader-map
	      ("s s" . helm-swoop)))
