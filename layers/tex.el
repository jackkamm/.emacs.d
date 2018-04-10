(use-package tex
  :defer t
  :ensure auctex
  :general
  (leader-bind-local
    :keymaps 'LaTeX-mode-map
    "m" 'TeX-command-master
    "e" 'LaTeX-environment))
