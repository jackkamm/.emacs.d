(if (version< emacs-version "26")
    (use-package web-mode
      :mode
      (("\\.html\\'"       . web-mode)
       ("\\.htm\\'"        . web-mode)
       ("\\.xml\\'"        . web-mode))))
