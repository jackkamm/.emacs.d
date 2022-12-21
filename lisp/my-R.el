;;; my-R.el --- R config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; NOTE syntax checking (flymake): should be auto-enabled when lintr
;; installed from CRAN. If it doesn't work, try creating ~/.R (cf
;; https://github.com/emacs-ess/ESS/issues/883)

(use-package ess-r-mode
  :ensure ess
  :init
  ;; many variables need to be set in :init to have effect
  (setq ess-indent-with-fancy-comments nil
        ess-eval-visibly 'nowait
        ess-smart-S-assign-key nil
        ess-style 'RStudio)
  :config
  ;; HACK Setting ess-style globally doesn't work in org src buffers
  ;; TODO File an issue with ESS
  ;; See also: https://github.com/emacs-ess/ESS/issues/661
  (add-hook 'ess-mode-hook (lambda () (ess-set-style 'RStudio 'quiet)))

  ;; https://github.com/syl20bnr/spacemacs/pull/9364
  (define-key inferior-ess-mode-map (kbd "C-d") nil) ;TODO PR evil-collection

  (defun my-run-R (r-cmd)
    "Run R, using R-CMD as the R executable."
    (interactive (list (read-string "R executable: " "R")))
    (let ((inferior-ess-r-program r-cmd)) (R)))

  ;; temporary workaround for https://github.com/emacs-ess/ESS/issues/1193
  (defun my-inferior-ess-init ()
      (setq-local ansi-color-for-comint-mode 'filter))
  (add-hook 'inferior-ess-mode-hook 'my-inferior-ess-init)

  (my-major-leader
    :keymaps 'ess-mode-map
    ;; predefined keymaps
    "c" 'ess-force-buffer-current
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

(provide 'my-R)
;;; my-R.el ends here
