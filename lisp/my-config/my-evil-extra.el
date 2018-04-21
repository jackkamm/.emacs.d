(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; evil cursor colors
(setq evil-normal-state-cursor "orange"
    evil-motion-state-cursor "violet"
    evil-insert-state-cursor '(bar "green")
    evil-emacs-state-cursor "turquoise")
