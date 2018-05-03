(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; evil cursor colors
(setq evil-normal-state-cursor "orange"
    evil-motion-state-cursor "violet"
    evil-insert-state-cursor '(bar "green")
    evil-emacs-state-cursor "turquoise")

;;;; use emacs bindings in insert state
;;(setq evil-insert-state-map (make-sparse-keymap))
;;(evil-global-set-key 'insert (kbd "<escape>") 'evil-normal-state)
;;(setq evil-insert-state-cursor '(bar "turquoise"))
