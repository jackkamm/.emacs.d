;;; my-ide.el --- IDE setup                          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'my-python)

;;; LSP

(use-package eglot)
(add-hook 'python-mode-hook 'eglot-ensure)

;;(setq eldoc-display-functions '(eldoc-display-in-echo-area eldoc-display-in-buffer))
(setq eldoc-echo-area-prefer-doc-buffer t)

;;; Find in project

(setq project-vc-merge-submodules nil)

;;;; projectile
;;(use-package projectile
;;  :init
;;  (setq projectile-use-git-grep t))

;; xref
(general-define-key
 :states '(normal motion visual)
 ;; inverse of "gd" evil-goto-definition
 "gD" 'xref-find-references)

;;; Syntax checking

;; flymake, built-in syntax checker. Auto-started by eglot, ess, etc
(with-eval-after-load 'flymake
  (defhydra my-flymake-hydra ()
    "flymake"
    ("n" flymake-goto-next-error "next")
    ("p" flymake-goto-prev-error "prev")
    ("s" flymake-start "start")
    ("l" flymake-show-diagnostics-buffer "list")
    ("L" flymake-switch-to-log-buffer "Log" :color blue))
  (my-leader
    :keymaps 'flymake-mode-map
    "y" 'my-flymake-hydra/body))

;; flycheck, 3rd-party syntax checker that was preferred until
;; recently. Some situations may require flycheck instead of the
;; built-in flymake, e.g. when using flycheck-package for MELPA
(use-package flycheck
  :init
  ;; customizations to improve performance
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 4)

  :config
  ;; nicer popup window
  (with-eval-after-load 'popwin
    (push '("^\\*Flycheck.+\\*$"
          :regexp t
          :dedicated t
          :position bottom
	  ;;:noselect t
	  :stick t)
        popwin:special-display-config)))

(use-package flycheck-pos-tip
  :after flycheck
  :demand t
  :config
  (flycheck-pos-tip-mode))

;; recommender linter for MELPA. Call `flycheck-mode' to start
(use-package flycheck-package
  :after (flycheck elisp-mode)
  :demand t
  :config
  (flycheck-package-setup))

(provide 'my-ide)
;;; my-ide.el ends here
