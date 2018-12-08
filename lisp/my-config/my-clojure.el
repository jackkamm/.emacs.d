(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.cljc\\'" . clojurec-mode)))

(use-package cider
  ;; :after clojure-mode
  :commands cider-jack-in
  :config
  (my-major-leader
    :keymaps 'clojure-mode-map
    "'" 'cider-jack-in
    "e" 'cider-eval-last-sexp)
  )
