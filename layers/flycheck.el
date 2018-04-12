(use-package flycheck
  :config
  ;; enable flycheck globally
  (global-flycheck-mode)
  (setq flycheck-global-modes
	;; exclude emacs-lisp (too many false positives)
  	(list 'not 'emacs-lisp-mode))
  ;; improve performance
  (setq flycheck-check-syntax-automatically
  	'(save idle-change mode-enabled))
  (setq flycheck-idle-change-delay 4)
  ;; keybinds
  (my-leader
    "r" '(:ignore t :which-key "errors")
    "rr" 'flycheck-list-errors
    "rj" 'flycheck-next-error
    "rk" 'flycheck-previous-error)
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
