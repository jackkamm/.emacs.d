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

(use-package groovy-mode
  :mode (("\\.nf\\'" . groovy-mode)))
