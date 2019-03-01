(use-package ess-r-mode
  :ensure ess
  :mode (("/R/.*\\.q\\'"       . R-mode)
	 ("\\.[rR]\\'"         . R-mode)
	 ("\\.[rR]profile\\'"  . R-mode)
	 ("NAMESPACE\\'"       . R-mode)
	 ("CITATION\\'"        . R-mode)
	 ("\\.[Rr]out"         . R-transcript-mode)
	 ("\\.Rd\\'"           . Rd-mode))
  :commands R
  :init
  ;; many variables need to be set in :init to have effect
  (setq inferior-ess-same-window nil
        ess-indent-with-fancy-comments nil
        ess-eval-visibly 'nowait
        ess-use-flymake nil ;ess-flymake not working (7-2018)
        ess-smart-S-assign-key nil
        ;; start R session as *R* instead of *R:<project>*,
        ;; because ob-R isn't smart enough to use *R:<project> by default
        ;; TODO submit PR to ob-R.el and remove this customization
        ;; in particular, have org-babel-R-initiate-session call ess-gen-proc-buffer-name-function
        ess-gen-proc-buffer-name-function 'ess-gen-proc-buffer-name:simple
        ;; Follow Hadley Wickham's R style guide
        ess-first-continued-statement-offset 2
	ess-continued-statement-offset 0
	ess-expression-offset 2
	ess-nuke-trailing-whitespace-p t
	ess-default-style 'DEFAULT)
  :config
  (evil-set-initial-state 'ess-help-mode 'motion) ;TODO PR evil-collection
  ;; https://github.com/syl20bnr/spacemacs/pull/9364
  (define-key inferior-ess-mode-map (kbd "C-d") nil) ;TODO PR evil-collection
  (my-major-leader
    :keymaps 'ess-mode-map
    ;; predefined keymaps
    "h" 'ess-doc-map
    "r" 'ess-extra-map
    "w" 'ess-r-package-dev-map
    "d" 'ess-dev-map
    "b" 'ess-eval-buffer
    "l" 'ess-eval-line
    "r" 'ess-eval-region
    "f" 'ess-eval-function
    "p" 'ess-eval-paragraph
    "P" 'ess-eval-paragraph-and-step))

(use-package ess-R-data-view
  :after ess-r-mode)

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
