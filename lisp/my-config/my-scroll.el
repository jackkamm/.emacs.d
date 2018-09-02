(use-package minimap
  :init
  (require 'hydra)
  (defhydra my-nav-hydra ()
    "scroll"
    ("d" evil-scroll-down "down")
    ("u" evil-scroll-up "up")
    ("f" evil-scroll-page-down "page-down")
    ("b" evil-scroll-page-up "page-up")
    ("e" evil-scroll-line-down "scroll-down")
    ("y" evil-scroll-line-up "scroll-up")
    ("m" minimap-mode "toggle-minimap")
    ("q" nil "quit")
    ("Q" minimap-mode "quit-toggle-minimap" :exit t))
  (my-leader
    "N" '(my-nav-hydra/body :which-key "navigate-scroll"))
  :commands (minimap-mode))
