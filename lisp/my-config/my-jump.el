(general-define-key
 :states '(normal motion visual)
 ;; inverse of "gd" evil-goto-definition
 "gD" 'xref-find-references)

(my-leader
  "g" '(:ignore t :which-key "Goto"))
(general-create-definer
  my-goto-leader
  :prefix "C-c g")
(general-define-key
 :keymaps 'override
 :states '(normal motion visual)
 "g SPC" (general-simulate-key "C-c g" :which-key "my-motions"))

(use-package avy
  :general
  (my-goto-leader
    "s" 'avy-isearch
    "g"  'avy-goto-char-timer
    "w"  'avy-goto-word-1
    "l"  'avy-goto-line))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "C-c g e")
  (my-goto-leader
    "SPC" '(:ignore-key t :which-key "easymotion")))
