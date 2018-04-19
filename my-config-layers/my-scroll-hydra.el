(with-eval-after-load 'hydra
    (defhydra my-nav-hydra ()
      "scroll"
      ("d" evil-scroll-down "down")
      ("u" evil-scroll-up "up")
      ("f" evil-scroll-page-down "page-down")
      ("b" evil-scroll-page-up "page-up")
      ("m" minimap-mode "minimap")
      ("q" nil "quit"))
    (my-leader
      "n" '(my-nav-hydra/body :which-key "navigate")))
