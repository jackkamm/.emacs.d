(use-package ivy
  :init
  (setq ivy-use-selectable-prompt t)
  (setq ivy-re-builders-alist
	'((t . ivy--regex-ignore-order)))
  (setq ivy-use-virtual-buffers t)
  (ivy-mode)
  :general (my-leader "R" 'ivy-resume))

(use-package ivy-hydra)

(use-package counsel
  :init
  (counsel-mode))
