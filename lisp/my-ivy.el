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
  (counsel-mode)
  :config
  ;; override shadowing of yank-pop, since counsel-yank-pop doesn't
  ;; work in minibuffer
  (define-key counsel-mode-map [remap yank-pop] nil)
  (my-leader "y" 'counsel-yank-pop))

(use-package counsel-projectile
  :commands (counsel-projectile counsel-projectile-grep))

(use-package ivy-prescient
  :config
  ;; TODO autoload?
  (ivy-prescient-mode))
