(general-define-key
 :states '(normal motion visual)
 ;; inverse of "gd" evil-goto-definition
 "gD" 'xref-find-references)

(my-leader
  "j" '(:ignore t :which-key "Jump"))
(general-create-definer
  my-goto-leader
  :prefix "C-c j")

(use-package avy
  :general
  (my-goto-leader
    "s" 'avy-isearch
    "j"  'avy-goto-char-timer
    "w"  'avy-goto-word-1
    "l"  'avy-goto-line))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "C-c j e"))
