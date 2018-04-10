;; use emacs bindings in insert state
(setq evil-insert-state-map
    (make-sparse-keymap))
(evil-global-set-key 'insert
(kbd "<escape>") 'evil-normal-state)

;; needed because of evil-integration.el
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "SPC") nil))

;; motion-state adjustments
(evil-global-set-key 'motion (kbd "C-u") 'evil-scroll-up)
(evil-global-set-key 'motion (kbd "RET") nil)

;; cursor colors
(setq evil-normal-state-cursor "yellow"
    evil-motion-state-cursor "purple"
    evil-insert-state-cursor '(bar "cyan")
    evil-emacs-state-cursor "cyan")

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

;; override `comint-delchar-or-maybe-eof'
(with-eval-after-load 'comint
  (bind-keys :map comint-mode-map
	     ("C-d" . nil)
	     ("C-c C-d" . comint-delchar-or-maybe-eof)))
