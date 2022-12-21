;;; my-clojure.el --- Setup clojure -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package clojure-mode)

(use-package cider
  ;; :after clojure-mode
  :config
  (my-major-leader
    :keymaps 'clojure-mode-map
    "'" 'cider-jack-in
    "e" 'cider-eval-last-sexp))

(provide 'my-clojure)
;;; my-clojure.el ends here
