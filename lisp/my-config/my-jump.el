(general-define-key
 :states '(normal motion)
 ;; inverse of "gd" evil-goto-definition
 "gD" 'xref-find-references)

(my-leader
  "g" '(:ignore t :which-key "Jump"))
(general-create-definer
  my-jump-leader
  :prefix "C-c g")
(general-define-key
 :keymaps 'override
 :states '(normal motion visual)
 "g SPC" (general-simulate-key "C-c g" :which-key "Jump"))

(use-package avy
  :general
  (my-jump-leader
    "s" 'avy-isearch
    "j"  'avy-goto-char-timer
    "w"  'avy-goto-word-1
    "l"  'avy-goto-line))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "C-c g SPC")
  (my-jump-leader
    "SPC" '(:ignore-key t :which-key "easymotion")))
