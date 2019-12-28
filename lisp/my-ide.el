;;; LSP

(use-package lsp-mode :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-doc-enable nil))
(use-package company-lsp :commands company-lsp)

(with-eval-after-load "my-python" (add-hook 'python-mode-hook #'lsp))

;;; Find in project

;; projectile
(with-eval-after-load "my-search-replace"
  (use-package projectile
    :general (my-search-replace-leader
               "p" 'projectile-grep)
    :init
    (setq projectile-use-git-grep t))

  (with-eval-after-load "my-helm"
    (use-package helm-projectile
      :general (my-search-replace-leader
                 "P" 'helm-projectile-ag)))

  (with-eval-after-load "my-ivy"
    (my-search-replace-leader
      "P" 'counsel-projectile-grep)))

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

  (with-eval-after-load "my-ivy"
    (my-leader "C" 'counsel-company))

  (with-eval-after-load "my-helm"
    (use-package helm-company
      :config
      (my-leader "C" 'helm-company))))

(use-package company-prescient
  :after company
  :config
  (company-prescient-mode))

;;; Syntax checking

(use-package flycheck
  :defer 4
  :init
  (setq flycheck-global-modes (list 'not
                                    ;; false positives
                                    'emacs-lisp-mode
                                    ;; hanging, false positives
                                    'ess-mode)
        ;; improve performance
        flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 4)
  :config
  (global-flycheck-mode)
  ;; which-key
  (define-key global-map (kbd "C-c !") '("flycheck"))
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

(use-package flycheck-package
  :after (flycheck elisp-mode)
  :config
  (flycheck-package-setup))
