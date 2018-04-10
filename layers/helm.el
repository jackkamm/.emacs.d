(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  (bind-keys :map leader-map
	     ("SPC" . helm-M-x)
	     ("f f" . helm-find-files)
	     ("f r" . helm-recentf)
	     ("b b" . helm-buffers-list))
  ;; rebind tab
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action)
  (define-key helm-map (kbd "M-x")  'helm-select-action)
  )

(use-package helm-projectile
  :bind (:map leader-map
	      ("/" . helm-projectile-ag)))

(use-package helm-swoop
  :bind (:map leader-map
	      ("s s" . helm-swoop)))
