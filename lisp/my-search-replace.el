(setq my-search-map (make-sparse-keymap))
(general-create-definer my-search-replace-leader :prefix-map 'my-search-map)
(my-leader "s" '(:keymap my-search-map :which-key "Search/replace"))

(my-search-replace-leader
  "l" 'lgrep
  "r" 'rgrep
  "c" 'evil-ex-nohighlight)

;; wgrep
(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :config
  (advice-add 'wgrep-change-to-wgrep-mode :after #'evil-normal-state)
  (advice-add 'wgrep-finish-edit :after #'evil-motion-state)
  (advice-add 'wgrep-abort-changes :after #'evil-motion-state))

;; projectile
(with-eval-after-load 'projectile
  (my-search-replace-leader
    "p" 'projectile-grep))

(pcase my-completing-read-style
  (`helm
   (my-search-replace-leader
     "g" 'helm-do-grep-ag
     "S" 'helm-do-ag-buffers
     "s" 'helm-swoop
     "P" 'helm-projectile-ag))
  (`ivy
   (my-search-replace-leader
     "s" 'swiper
     "S" 'swiper-all
     "f" 'counsel-locate
     "g" 'counsel-ag
     "P" 'counsel-projectile-grep
     "i" 'swiper-from-isearch)))

;; visualstar
(use-package evil-visualstar
  :config
  (global-evil-visualstar-mode))

;; iedit
(use-package evil-iedit-state
  :general
  (my-search-replace-leader
    "e" 'evil-iedit-state/iedit-mode))

;; multiple-cursors
(use-package evil-mc
  :general (my-search-replace-leader
	     "m" 'my-toggle-evil-mc-mode)
  :init
  (setq evil-mc-custom-known-commands
        '((backward-kill-word
           . ((:default . evil-mc-execute-default-call-with-count)))
          (delete-char
           . ((:default . evil-mc-execute-default-call-with-count)))
          (kill-word
           . ((:default . evil-mc-execute-default-call-with-count)))))
  :config
  (defun my-toggle-evil-mc-mode () (interactive)
         (if evil-mc-mode
             (progn
               (evil-mc-undo-all-cursors)
               (turn-off-evil-mc-mode)
               (message "Disabled evil-mc-mode"))
           (turn-on-evil-mc-mode)
           (message "Enabled evil-mc-mode")))
  (define-key evil-mc-key-map (kbd "M-C-<mouse-1>")
    'evil-mc-toggle-cursor-on-click))
