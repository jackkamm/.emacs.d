;; evil
(use-package evil
  :demand t
  :custom
  (evil-overriding-maps nil)
  (evil-intercept-maps nil)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil)            ;allow org-mode TAB in terminal
  (evil-symbol-word-search t)
  (evil-respect-visual-line-mode t)
  ;; make emacs- and insert-states identical
  (evil-disable-insert-state-bindings t)
  (evil-undo-system 'undo-redo)
  :config
  ;; get rid of motion state everywhere
  (defalias 'evil-motion-state 'evil-insert-state)
  ;; get rid of emacs state nearly everywhere
  (mapc (lambda (mode) (evil-set-initial-state mode 'insert))
        evil-emacs-state-modes)
  ;; set special states to insert mode
  (evil-set-initial-state 'special-mode 'insert)
  (evil-set-initial-state 'image-mode 'insert)
  (evil-set-initial-state 'dired-mode 'insert)
  ;;(setq evil-motion-state-tag (propertize
  ;;                            "  MOTION  " 'face
  ;;                            '((:background "purple" :foreground "black"))))
  (setq evil-emacs-state-tag (propertize
                              "  EMACS  " 'face
                              '((:background "blue" :foreground "black"))))
  (setq evil-insert-state-tag (propertize
                               "  INSERT  " 'face
                               '((:background "green" :foreground "black"))))
  ;; Remove SPC/RET keybindings
  (evil-global-set-key 'motion (kbd "SPC") nil)
  (evil-global-set-key 'motion (kbd "RET") nil)
  ;; https://vim.fandom.com/wiki/Unused_keys
  (evil-global-set-key 'motion "+" 'repeat)
  ;; Start evil
  (evil-mode))

;; which-key
(use-package which-key
  :demand t
  :custom
  (which-key-sort-order 'which-key-key-order-alpha)
  (which-key-enable-extended-define-key t)
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

(setq my-completing-read-style 'selectrum)
;;(setq my-completing-read-style 'hybrid)
;;(setq my-completing-read-style 'builtin)
;;(setq my-completing-read-style 'helm)
;;(setq my-completing-read-style 'ivy)

(mapc 'load
      (list
       ;; completion system (helm, ivy, ido)
       "my-completing-read"

       "my-buffers-files" ;includes dired, diff'ing
       "my-windows-frames"
       "my-lines-regions" ;line numbers/wrapping, parens, narrowing, etc
       "my-motions-jumping" ;avy, easymotion
       "my-search-replace" ;grep, swiper/swoop, iedit/mc
       "my-history-vc-undo" ;git, undo
       "my-send-insert" ;insert and send special text

       "my-themes-toggles"
       ))

;; security. Clear the keylog after entering passwords

;; TODO: Submit this as a security bug to Emacs? They already know
;; about cominit-send-invisible, but the help for read-passwd doesn't
;; mention this issue, and it is affected as well

(defun my-clear-keylog (&rest r)
  "Advice to fix security bug in `comint-send-invisible', as of emacs27.

In particular, the help for `comint-send-invisible' says:
Security bug: your string can still be temporarily recovered with
C-h l; ‘clear-this-command-keys’ can fix that."
  (clear-this-command-keys))

(advice-add #'comint-send-invisible :after #'my-clear-keylog)
(advice-add #'read-passwd :after #'my-clear-keylog)
