(use-package ess-site
  :ensure ess
  :mode (("/R/.*\\.q\\'"       . R-mode)
	 ("\\.[rR]\\'"         . R-mode)
	 ("\\.[rR]profile\\'"  . R-mode)
	 ("NAMESPACE\\'"       . R-mode)
	 ("CITATION\\'"        . R-mode)
	 ("\\.jl\\'"           . ess-julia-mode)
	 ("\\.[Rr]out"         . R-transcript-mode)
	 ("\\.Rd\\'"           . Rd-mode))
  :commands (R julia)
  :init
  (setq inferior-ess-same-window nil)
  :config
  ;; TODO: PR evil-collection
  (evil-set-initial-state 'ess-help-mode 'motion)
  ;; fix annoying ESS indentation
  ;; http://r.789695.n4.nabble.com/Commenting-conventions-td3216584.html
  (setq ess-indent-with-fancy-comments nil)
  ;; https://github.com/syl20bnr/spacemacs/pull/9364
  (define-key inferior-ess-mode-map (kbd "C-d") nil)
  ;; Follow Hadley Wickham's R style guide
  (setq ess-first-continued-statement-offset 2
	ess-continued-statement-offset 0
	ess-expression-offset 2
	ess-nuke-trailing-whitespace-p t
	ess-default-style 'DEFAULT)
  (my-major-leader
    :keymaps '(ess-julia-mode-map ess-mode-map)
    ;; predefined keymaps
    "h" 'ess-doc-map
    "r" 'ess-extra-map
    "w" 'ess-r-package-dev-map
    "d" 'ess-dev-map)
  (my-eval-leader
    :keymaps '(ess-julia-mode-map ess-mode-map)
    ;; REPL
    "e"  'ess-eval-region-or-function-or-paragraph-and-step
    "B" 'ess-eval-buffer-and-go
    "b" 'ess-eval-buffer
    "d" 'ess-eval-region-or-line-and-step
    "D" 'ess-eval-function-or-paragraph-and-step
    "L" 'ess-eval-line-and-go
    "l" 'ess-eval-line
    "R" 'ess-eval-region-and-go
    "r" 'ess-eval-region
    "F" 'ess-eval-function-and-go
    "f" 'ess-eval-function))

(use-package ess-smart-equals
  :commands ess-smart-equals-mode
  :init
  (progn
    (add-hook 'ess-mode-hook 'ess-smart-equals-mode)
    (add-hook 'inferior-ess-mode-hook 'ess-smart-equals-mode)))

(use-package polymode
  :mode (("\\.[rR]nw\\'" . poly-noweb+r-mode)
	 ("\\.Rmd" . poly-markdown+r-mode))
  :config
  (require 'poly-R)
  (require 'poly-noweb)
  (require 'poly-markdown)
  (setq polymode-weave-output-file-format "%s")
  (setq polymode-exporter-output-file-format "%s")
  (setq polymode-display-process-buffers nil)
  (setq polymode-display-output-file nil)
  ;; AUCTeX integration
  (with-eval-after-load 'tex
    (add-to-list 'TeX-command-list
  		 '("polymode-export" "(polymode-export)"
  		   TeX-run-function nil (latex-mode) :help) t)
    (mapc (lambda (suffix)
	    (add-to-list 'TeX-file-extensions suffix))
	  '("nw" "Snw" "Rnw"))
    (add-hook 'poly-noweb+r-mode-hook
	      (lambda ()
		(setq TeX-command-default "polymode-export")))))
