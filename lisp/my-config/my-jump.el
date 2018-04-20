(use-package evil-search-highlight-persist
  :config
  (global-evil-search-highlight-persist)
  (my-leader
    "sc" 'evil-search-highlight-persist-remove-all))

(use-package avy
  :general
  (my-leader
    "ja" 'avy-isearch
    "jj"  'avy-goto-char-timer
    "jw"  'avy-goto-word-1
    "jl"  'avy-goto-line))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "SPC j e")
  (evilem-default-keybindings "M-m j e")
  (my-leader
    "je" '(:ignore-key t :which-key "easymotion")))

(my-leader
  ;; xref
  "jd" 'xref-find-definitions
  "jr" 'xref-find-references
  ;; dired
  "jD" 'dired-jump)
