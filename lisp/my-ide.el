;; LSP

(use-package lsp-mode :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(with-eval-after-load "my-python" (add-hook 'python-mode-hook #'lsp))

;; xref

(general-define-key
 :states '(normal motion visual)
 ;; inverse of "gd" evil-goto-definition
 "gD" 'xref-find-references)

;; Completion

(use-package company
  :defer 2
  :custom
  (global-company-mode t)
  :config
  (my-leader "C" 'company-complete)

  (with-eval-after-load "my-ivy"
    (my-leader "C" 'counsel-company))

  (with-eval-after-load "my-helm"
    (use-package helm-company
      :config
      (my-leader "C" 'helm-company))))

(use-package company-prescient
  :config
  ;; TODO autoload?
  (company-prescient-mode))

;; Syntax checking

(use-package flycheck
  :config
  (global-flycheck-mode)
  (setq flycheck-global-modes
  	(list 'not
  	      'emacs-lisp-mode ;false positives
  	      'ess-mode ;hanging, false positives
	      ))
  ;; improve performance
  (setq flycheck-check-syntax-automatically
  	'(save idle-change mode-enabled))
  (setq flycheck-idle-change-delay 4)
  ;; keybinds
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
  :defer t
  :init
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode)))

;; TODO lazy-load this
(use-package flycheck-package
  :after flycheck
  :config
  (flycheck-package-setup))
