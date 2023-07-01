;;; my-R.el --- R config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; NOTE syntax checking (flymake): should be auto-enabled when lintr
;; installed from CRAN. If it doesn't work, try creating ~/.R (cf
;; https://github.com/emacs-ess/ESS/issues/883)

;; temporary workaround for https://github.com/emacs-ess/ESS/issues/1193
;; Specifically, https://github.com/emacs-ess/ESS/issues/1193#issuecomment-1129862888
(use-package xterm-color
  :autoload xterm-color-filter)

(defun my-iess-colors-workaround ()
  "Workaround for https://github.com/emacs-ess/ESS/issues/1193"
  ;; Uncomment in case of performance issues. (xterm-color
  ;; recommends disabling font-lock in some modes)
  ;;(font-lock-mode -1)
  ;;(make-local-variable 'font-lock-function)
  (add-hook 'comint-preoutput-filter-functions #'xterm-color-filter -90 t)
  (setq-local ansi-color-for-comint-mode nil))

(use-package ess-r-mode
  :ensure ess
  :init
  ;; many variables need to be set in :init to have effect
  (setq ess-indent-with-fancy-comments nil
        ess-eval-visibly 'nowait
        ess-smart-S-assign-key nil
        ess-style 'RRR)
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

  (add-hook 'inferior-ess-mode-hook #'my-iess-colors-workaround)

  ;; company breaks in reticulate::repl_python
  ;; it's also kinda slow/annoying in iESS anyways
  (add-hook 'inferior-ess-mode-hook (lambda () (company-mode -1)))

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
