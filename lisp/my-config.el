;;; my-config.el --- A full emacs config             -*- lexical-binding: t; -*-
;;;
;;; Commentary: Additional configurations not in init.el, that I want
;;; to include on most installs, but not on minimal installs such as
;;; on Windows or Android termux
;;;
;;; Code:

(require 'my-org)

(require 'my-ide) ;lsp, projectile, xref, flycheck
(require 'my-company)
(require 'my-tramp)
(require 'my-shell)
(require 'my-snippets)

(require 'my-email-chat)

;; languages
(require 'my-python)
;;(require 'my-clojure)
(require 'my-literate-programming)
(require 'my-R)
(require 'my-julia)
(require 'my-tex)
;; c-c++: only enable 1 of cquery, rtags
;;(require 'my-cquery)
;;(require 'my-rtags)

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

(provide 'my-config)
;;; my-config.el ends here
