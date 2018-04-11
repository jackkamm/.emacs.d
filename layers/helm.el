(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  (bind-keys :map my-leader-map
	     ("SPC" . helm-M-x)
	     ("f f" . helm-find-files)
	     ("f r" . helm-recentf)
	     ("b b" . helm-mini))
  (bind-keys :map helm-map
	     ("a" . helm-apropos)
	     ("<tab>" . helm-execute-persistent-action)
	     ("C-i" . helm-execute-persistent-action)
	     ("C-z" . helm-select-action)
	     ("M-x" . helm-select-action)
	     ("C-j" . helm-next-line)
	     ("C-k" . helm-previous-line))
  (bind-keys :map helm-find-files-map
	     ("C-<backspace>" . helm-find-files-up-one-level)
	     ("<left>" . backward-char)
	     ("<right>" . forward-char)))

(use-package helm-projectile
  :bind (:map my-leader-map
	      ("/" . helm-projectile-ag)))

(use-package helm-swoop
  :bind (:map my-leader-map
	      ("s s" . helm-swoop)))
