(general-define-key
 :states '(normal motion visual)
 ;; inverse of "gd" evil-goto-definition
 "gD" 'xref-find-references)

(my-leader
  "g" '(:ignore t :which-key "Goto"))
(general-create-definer
  my-goto-leader
  :prefix "C-c g")

(use-package avy
  :general
  (my-goto-leader
    "s" 'avy-isearch
    "c"  'avy-goto-char-timer
    "w"  'avy-goto-word-1
    "l"  'avy-goto-line))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "C-c g g")
  (my-goto-leader
    "SPC" '(:ignore-key t :which-key "easymotion")))
