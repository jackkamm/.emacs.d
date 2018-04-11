(use-package flycheck
  :config
  (global-flycheck-mode)
  (setq flycheck-global-modes
	(list 'not 'emacs-lisp-mode))
  (setq flycheck-check-syntax-automatically
	'(save idle-change mode-enabled))
  (setq flycheck-idle-change-delay 4)
  (with-eval-after-load 'popwin
    (push '("^\\*Flycheck.+\\*$"
          :regexp t
          :dedicated t
          :position bottom
          :stick t
          :noselect t)
        popwin:special-display-config)))

(use-package flycheck-pos-tip
  :defer t
  :init
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode)))
