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
        ;; FIXME workaround to accommodate ob-R :session
        ;; TODO PR (org-babel-R-initiate-session, ess-gen-proc-buffer-name-function)
        ess-gen-proc-buffer-name-function 'ess-gen-proc-buffer-name:simple
        ess-style 'RStudio)
  :config
  ;; HACK Setting ess-style globally doesn't work in org src buffers
  ;; TODO File an issue with ESS
  ;; See also: https://github.com/emacs-ess/ESS/issues/661
  (add-hook 'ess-mode-hook (lambda () (ess-set-style 'RStudio 'quiet)))
  (evil-set-initial-state 'ess-help-mode 'motion) ;TODO PR evil-collection
  ;; https://github.com/syl20bnr/spacemacs/pull/9364
  (define-key inferior-ess-mode-map (kbd "C-d") nil) ;TODO PR evil-collection
  ;; Control which frame to display *R*
  ;; https://ess.r-project.org/Manual/ess.html#Controlling-buffer-display
  (setq display-buffer-alist
        (append
         '(("*R"
            (display-buffer-reuse-window)
            (reusable-frames . 0)))
         display-buffer-alist))
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
