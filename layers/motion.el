(use-package avy
  :bind (:map my-leader-map
	      ("j j" . avy-goto-char-timer)
	      ("j w" . avy-goto-word-1)
	      ("j l" . avy-goto-line)))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "SPC j e"))

(with-eval-after-load 'hydra
    (defhydra my-scroll-hydra (my-leader-map "n")
      "scroll"
      ("d" evil-scroll-down)
      ("u" evil-scroll-up)
      ("f" evil-scroll-page-down)
      ("b" evil-scroll-page-up)
      ("q" nil "quit")))
