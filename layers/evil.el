(use-package evil
  :config
  (evil-mode)
  ;; use emacs bindings in insert state
  (setq evil-insert-state-map
	(make-sparse-keymap))
  (evil-global-set-key 'insert
    (kbd "<escape>") 'evil-normal-state)
  ;; leader prefix
  (evil-global-set-key 'motion (kbd "SPC") leader-map)
  (evil-global-set-key 'normal (kbd "SPC") leader-map)
  ;; needed because of evil-integration.el
  (with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "SPC") nil))
  ;; rebind universal-argument
  (evil-global-set-key 'motion (kbd "C-u") 'evil-scroll-up)
  (define-key leader-map
    (kbd "u") 'universal-argument)
  ;; motion-state adjustments
  (evil-global-set-key
   'motion (kbd "i") 'evil-execute-in-emacs-state)
  (evil-global-set-key 'motion (kbd "+") nil)
  (evil-global-set-key 'motion (kbd "-") nil)
  ;; cursor colors
  (setq evil-normal-state-cursor "yellow"
	evil-motion-state-cursor "purple"
	evil-insert-state-cursor '(bar "cyan")
	evil-emacs-state-cursor "cyan")
  )

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))
