;;; my-evil.el --- evil config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package evil
  :demand t
  :init
  (setq evil-overriding-maps nil
        evil-intercept-maps nil
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil ;allow org-mode TAB in terminal
        evil-symbol-word-search t
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-redo
        evil-disable-insert-state-bindings t)

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
  (add-hook 'view-mode-hook 'evil-insert-state)
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

(provide 'my-evil)
;;; my-evil.el ends here
