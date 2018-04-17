;; based on spacemacs ess layer
(use-package ess
  :mode (("/R/.*\\.q\\'"       . R-mode) 
	 ("\\.[rR]\\'"         . R-mode)
	 ("\\.[rR]nw\\'"       . Rnw-mode)
	 ("\\.[rR]profile\\'"  . R-mode)
	 ("NAMESPACE\\'"       . R-mode)
	 ("CITATION\\'"        . R-mode)
	 ("\\.jl\\'"           . ess-julia-mode)
	 ("\\.[Rr]out"         . R-transcript-mode)
	 ("\\.Rd\\'"           . Rd-mode))
  :commands (R julia)
  :config
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