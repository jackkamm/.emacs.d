(use-package avy
  :bind (:map my-leader-map
	      ("j j" . avy-goto-char-timer)
	      ("j w" . avy-goto-word-1)
	      ("j l" . avy-goto-line)))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "SPC j e"))
