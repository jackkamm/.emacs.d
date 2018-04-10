(use-package linum-relative
  :config
  ;;(linum-relative-global-mode 1)
  (define-globalized-minor-mode
    my-global-linum-relative-mode
    linum-relative-mode
    (lambda ()
      (when (derived-mode-p 'prog-mode 'text-mode)
	(unless (memq major-mode (list 'org-mode))
	    (linum-relative-mode 1)))))
  (my-global-linum-relative-mode 1))
