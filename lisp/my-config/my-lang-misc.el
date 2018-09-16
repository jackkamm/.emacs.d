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
