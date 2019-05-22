(if (version< emacs-version "26")
    (use-package web-mode
      :mode
      (("\\.html\\'"       . web-mode)
       ("\\.htm\\'"        . web-mode)
       ("\\.xml\\'"        . web-mode))))

(with-eval-after-load "my-lines"
  (add-hook 'mhtml-mode-hook (lambda () (visual-line-mode -1))))
