;;; my-keymaps.el --- Keymaps config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package which-key
  :demand t
  :init
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-enable-extended-define-key t)
  :bind (:map help-map
              ("y" . which-key-show-top-level))
  :config
  (which-key-mode))

;; general
(use-package general
  :demand t
  :config
  (general-override-mode)

  (general-create-definer my-leader :prefix "C-c")

  (general-define-key
   :keymaps 'override
   :states '(normal motion visual)
   "SPC" (general-simulate-key "C-c"))

  ;; Alternatives for keybindings that don't work in webVNC
  (general-define-key
   :keymaps 'override
   "C-j" (general-simulate-key "C-n")
   "C-k" (general-simulate-key "C-p")
   "C-c SPC" (general-simulate-key "C-SPC"))

  (my-leader
    "a" '(:ignore t :which-key "Applications")
    ;; because M-q might be overridden on macOS
    "q" (general-simulate-key "M-q")
    "m" '(:ignore t :which-key "Major")
    ;;"Q" 'save-buffers-kill-emacs
    "h" '(:keymap help-map :which-key "Help")
    "r" '(:keymap ctl-x-r-map :which-key "Registers/Rectangles")
    "x" '(:keymap ctl-x-map :which-key "C-x")
    ;; simulate key instead of using keymap, for sake of kmacro-bind-to-key
    "k" (general-simulate-key "C-x C-k" :which-key "Keyboard macros")
    "c" (general-simulate-key "C-c C-c"))

  (general-create-definer my-major-leader
    :prefix "C-c m")

  (general-define-key
   :states '(normal motion visual)
   "_" 'universal-argument))

;; hydra
(use-package hydra :demand t)
(use-package hercules :demand t)

(provide 'my-keymaps)
;;; my-keymaps.el ends here
