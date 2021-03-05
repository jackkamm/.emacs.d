(use-package clojure-mode)

(use-package cider
  ;; :after clojure-mode
  :config
  (my-major-leader
    :keymaps 'clojure-mode-map
    "'" 'cider-jack-in
    "e" 'cider-eval-last-sexp)
  )
