(my-leader "j" '(:ignore t :which-key "Jump"))
(general-create-definer my-jump-leader :prefix "C-c j")

(my-jump-leader
  ;; xref
  "d" 'xref-find-definitions
  "r" 'xref-find-references)

(use-package avy
  :general
  (my-jump-leader
    "s" 'avy-isearch
    "j"  'avy-goto-char-timer
    "w"  'avy-goto-word-1
    "l"  'avy-goto-line))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "C-c j e")
  (my-jump-leader
    "e" '(:ignore-key t :which-key "easymotion")))
