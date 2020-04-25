;;; man settings
(setq Man-width 80)

;;; startup settings

;; set $PATH, e.g. when starting from OSX or systemd
;; For systemd, it's preferred to set variables in ~/.config/environment.d/,
;; but this doesn't work for $PATH in Ubuntu 18.04
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;;; emacs-lisp-mode
(my-major-leader
  :keymaps 'emacs-lisp-mode-map
  "r" 'eval-region
  "b" 'eval-buffer
  "f" 'eval-defun
  "l" 'eval-last-sexp)

;;; miscellaneous major-modes
(use-package dockerfile-mode
  :mode (("Dockerfile\\'" . dockerfile-mode)))

(use-package csv-mode
  :mode (("\\.csv\\'" . csv-mode)))

(use-package go-mode
  :mode (("\\.go\\'" . go-mode)
	 ("\\.rf\\'" . go-mode)))

(use-package snakemake-mode
  :mode (("Snakefile\\'" . snakemake-mode)
	 ("\\.\\(?:sm\\)?rules\\'" . snakemake-mode)
	 ("\\.smk\\'" . snakemake-mode)
	 ("\\.snakefile\\'" . snakemake-mode)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

(use-package nextflow-mode
  :ensure nil
  :mode (("\\.nf\\'" . nextflow-mode)))

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)
	 ("\\.yaml\\'" . yaml-mode)))

(use-package ledger-mode
  :mode (("\\.ledger\\'" . ledger-mode)))

(use-package pkgbuild-mode
  :mode (("PKGBUILD\\'" . pkgbuild-mode)))
