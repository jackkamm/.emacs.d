;; use emacs bindings in insert state
(setq evil-insert-state-map
    (make-sparse-keymap))

(evil-global-set-key 'insert (kbd "<escape>") 'evil-normal-state)

(setq evil-insert-state-cursor '(bar "turquoise"))
