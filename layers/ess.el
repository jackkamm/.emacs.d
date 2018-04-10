;; based on spacemacs ess layer
(use-package ess
  :mode (("\\.sp\\'"           . S-mode)
	 ("/R/.*\\.q\\'"       . R-mode)
	 ("\\.[qsS]\\'"        . S-mode)
	 ("\\.ssc\\'"          . S-mode)
	 ("\\.SSC\\'"          . S-mode)
	 ("\\.[rR]\\'"         . R-mode)
	 ("\\.[rR]nw\\'"       . Rnw-mode)
	 ("\\.[sS]nw\\'"       . Snw-mode)
	 ("\\.[rR]profile\\'"  . R-mode)
	 ("NAMESPACE\\'"       . R-mode)
	 ("CITATION\\'"        . R-mode)
	 ("\\.omg\\'"          . omegahat-mode)
	 ("\\.hat\\'"          . omegahat-mode)
	 ("\\.lsp\\'"          . XLS-mode)
	 ("\\.do\\'"           . STA-mode)
	 ("\\.ado\\'"          . STA-mode)
	 ("\\.[Ss][Aa][Ss]\\'" . SAS-mode)
	 ("\\.jl\\'"           . ess-julia-mode)
	 ("\\.[Ss]t\\'"        . S-transcript-mode)
	 ("\\.Sout"            . S-transcript-mode)
	 ("\\.[Rr]out"         . R-transcript-mode)
	 ("\\.Rd\\'"           . Rd-mode)
	 ("\\.[Bb][Uu][Gg]\\'" . ess-bugs-mode)
	 ("\\.[Bb][Oo][Gg]\\'" . ess-bugs-mode)
	 ("\\.[Bb][Mm][Dd]\\'" . ess-bugs-mode)
	 ("\\.[Jj][Aa][Gg]\\'" . ess-jags-mode)
	 ("\\.[Jj][Oo][Gg]\\'" . ess-jags-mode)
	 ("\\.[Jj][Mm][Dd]\\'" . ess-jags-mode))
  :commands (R stata julia SAS)
  :config
  ;; https://github.com/syl20bnr/spacemacs/pull/9364
  (define-key inferior-ess-mode-map (kbd "C-d") nil)
  ;; Follow Hadley Wickham's R style guide
  (setq ess-first-continued-statement-offset 2
	ess-continued-statement-offset 0
	ess-expression-offset 2
	ess-nuke-trailing-whitespace-p t
	ess-default-style 'DEFAULT)
  (leader-bind-local
    :keymaps '(ess-julia-mode-map ess-mode-map)
    "m"  'ess-eval-region-or-function-or-paragraph-and-step
    "'"  'spacemacs/ess-start-repl
    "si" 'spacemacs/ess-start-repl
    "ss" 'ess-switch-to-inferior-or-script-buffer
    "sS" 'ess-switch-process
    ;; REPL
    "sB" 'ess-eval-buffer-and-go
    "sb" 'ess-eval-buffer
    "sd" 'ess-eval-region-or-line-and-step
    "sD" 'ess-eval-function-or-paragraph-and-step
    "sL" 'ess-eval-line-and-go
    "sl" 'ess-eval-line
    "sR" 'ess-eval-region-and-go
    "sr" 'ess-eval-region
    "sF" 'ess-eval-function-and-go
    "sf" 'ess-eval-function
    ;; predefined keymaps
    "h" 'ess-doc-map
    "r" 'ess-extra-map
    "w" 'ess-r-package-dev-map
    "d" 'ess-dev-map
    ;; noweb
    "cC" 'ess-eval-chunk-and-go
    "cc" 'ess-eval-chunk
    "cd" 'ess-eval-chunk-and-step
    "cm" 'ess-noweb-mark-chunk
    "cN" 'ess-noweb-previous-chunk
    "cn" 'ess-noweb-next-chunk))

(use-package ess-smart-equals
  :defer t
  :init
  (progn
    (add-hook 'ess-mode-hook 'ess-smart-equals-mode)
    (add-hook 'inferior-ess-mode-hook 'ess-smart-equals-mode)))
