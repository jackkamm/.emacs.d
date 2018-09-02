(use-package ivy
  :init
  (setq ivy-use-selectable-prompt t)
  (setq ivy-re-builders-alist
	'((t . ivy--regex-ignore-order)))
  (ivy-mode))

(use-package ivy-hydra)

(use-package counsel
  :init
  (counsel-mode))
