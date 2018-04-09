(use-package evil
  :config
  (evil-mode)
  ;; use emacs bindings in insert state
  (setq evil-insert-state-map
	(make-sparse-keymap))
  (define-key evil-insert-state-map
    (kbd "<escape>") 'evil-normal-state)
  ;; leader prefix
  (define-key evil-motion-state-map
    (kbd "SPC") leader-map)
  (define-key evil-insert-state-map
    (kbd "M-m") leader-map)
  (define-key evil-emacs-state-map
    (kbd "M-m") leader-map)
  ;; rebind universal-argument
  (define-key evil-motion-state-map
    (kbd "C-u") 'evil-scroll-up)
  (define-key leader-map
    (kbd "u") 'universal-argument)
  ;; i in motion state executes in emacs state
  (define-key evil-motion-state-map
    (kbd "i") 'evil-execute-in-emacs-state)
  ;; cursor colors
  (setq evil-normal-state-cursor "yellow"
	evil-motion-state-cursor "purple"
	evil-insert-state-cursor '(bar "cyan")
	evil-emacs-state-cursor "cyan")
  ;; start dired-mode in motion state
  (evil-set-initial-state 'dired-mode 'motion)
  )

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))
