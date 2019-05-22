(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1)
  (setq evilmi-always-simple-jump t)
  ;; mhtml-mode
  (plist-put evilmi-plugins 'mhtml-mode
             '((evilmi-template-get-tag evilmi-template-jump)
               (evilmi-simple-get-tag evilmi-simple-jump)
               (evilmi-html-get-tag evilmi-html-jump))))

(use-package lispyville
 :commands lispyville-mode
 :init
 (add-hook 'emacs-lisp-mode-hook 'lispyville-mode)
 (add-hook 'clojure-mode-hook 'lispyville-mode)
 :config
 (lispyville-set-key-theme
  '(operators
    c-w
    slurp/barf-lispy
    additional-movement)))

(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :init
  (with-eval-after-load "my-theme"
    (my-theme-leader "r" 'rainbow-delimiters-mode)))
