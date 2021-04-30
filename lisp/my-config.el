;;; Additional configurations not in init.el, that I want to include
;;; on most installs, but not on minimal installs such as on Windows
;;; or Android termux

(mapc 'load
      (list
       "my-org"

       "my-ide" ;lsp, projectile, xref, company, flycheck
       "my-tramp"
       "my-shell"
       "my-snippets"

       "my-email-chat"

       ;; languages
       "my-python"
       ;;"my-clojure"
       "my-literate-programming"
       "my-R"
       "my-julia"
       "my-tex"
       ;; c-c++: only enable 1 of cquery, rtags
       ;;"my-cquery"
       ;;"my-rtags"
       ))

;;;; other miscellaneous settings and packages

;;; man settings
(setq Man-width 80)

;;; startup settings

;;; emacs-lisp-mode
(my-major-leader
  :keymaps 'emacs-lisp-mode-map
  "r" 'eval-region
  "b" 'eval-buffer
  "f" 'eval-defun
  "l" 'eval-last-sexp)

;;; miscellaneous major-modes
(use-package dockerfile-mode)

(use-package csv-mode)

(use-package go-mode)

(use-package snakemake-mode)

(use-package markdown-mode
  :init (setq markdown-command "pandoc"))

;; dependancy of nextflow-mode
(use-package groovy-mode)

(use-package nextflow-mode
  :ensure nil
  :load-path (lambda () (concat user-emacs-directory "lisp/nextflow-mode"))
  :mode (("\\.nf\\'" . nextflow-mode)))

(use-package yaml-mode)

(use-package ledger-mode)

(use-package pkgbuild-mode)
