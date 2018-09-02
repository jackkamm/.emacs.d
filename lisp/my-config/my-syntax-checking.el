(setq my-errors-map (make-sparse-keymap))
(general-create-definer my-errors-leader :prefix-map 'my-errors-map)
(my-leader "x" '(:keymap my-errors-map :which-key "Syntax"))

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
  (my-errors-leader
    "r" 'flycheck-list-errors
    "j" 'flycheck-next-error
    "k" 'flycheck-previous-error)
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
