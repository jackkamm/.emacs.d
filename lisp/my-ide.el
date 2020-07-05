;;; LSP

(use-package eglot
  :commands (eglot
             eglot-ensure))

(with-eval-after-load "my-python" (add-hook 'python-mode-hook 'eglot-ensure))

;;; Find in project

;; projectile
(use-package projectile
  :commands projectile-grep
  :custom
  (projectile-use-git-grep t))

;; xref
(general-define-key
 :states '(normal motion visual)
 ;; inverse of "gd" evil-goto-definition
 "gD" 'xref-find-references)

;;; Completion

(use-package company
  :defer 2
  :config
  (global-company-mode 1)
  (my-leader "C" 'company-complete)

  (pcase my-completing-read-style
    (`ivy
     (my-leader "C" 'counsel-company))
    (`helm
     (use-package helm-company
      :config
      (my-leader "C" 'helm-company)))))

(use-package company-prescient
  :after company
  :config
  (company-prescient-mode))

;;; Syntax checking

;; flymake, built-in syntax checker. Auto-started by eglot, ess, etc
(with-eval-after-load 'flymake
  (my-leader
    :keymaps 'flymake-mode-map
    "y" '(:ignore t :which-key "Syntax")
    "yn" 'flymake-goto-next-error
    "yp" 'flymake-goto-prev-error
    "ys" 'flymake-start
    "yd" 'flymake-show-diagnostics-buffer
    "yl" 'flymake-switch-to-log-buffer))

;; flycheck, 3rd-party syntax checker that was preferred until
;; recently. Some situations may require flycheck instead of the
;; built-in flymake, e.g. when using flycheck-package for MELPA
(use-package flycheck
  :commands flycheck-mode
  :custom
  ;; customizations to improve performance
  (flycheck-check-syntax-automatically '(save idle-change mode-enabled))
  (flycheck-idle-change-delay 4)
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
  :config
  (flycheck-pos-tip-mode))

;; recommender linter for MELPA. Call `flycheck-mode' to start
(use-package flycheck-package
  :after (flycheck elisp-mode)
  :config
  (flycheck-package-setup))
