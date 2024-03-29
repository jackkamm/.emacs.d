;;; my-motions-jumping.el --- Configs for moving around  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq my-jump-map (make-sparse-keymap))
(general-create-definer my-jump-leader :prefix-map 'my-jump-map)
(my-leader "j" '(:keymap my-jump-map :which-key "Jump"))

(my-jump-leader
  "i" 'evil-jump-forward
  "o" 'evil-jump-backward)

(use-package avy
  :general
  (my-jump-leader
    "s" 'avy-isearch
    "j"  'avy-goto-char-timer
    "w"  'avy-goto-word-1
    "l"  'avy-goto-line))

(use-package evil-easymotion
  :demand t
  :config
  (evilem-default-keybindings "C-c e"))
(my-leader "e" '(:ignore t :which-key "easymotion"))

(provide 'my-motions-jumping)
;;; my-motions-jumping.el ends here
