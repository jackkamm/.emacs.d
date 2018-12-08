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

;(use-package lispy
;  :commands lispy-mode
;  :init
;  (add-hook 'emacs-lisp-mode-hook 'lispy-mode)
;  (add-hook 'clojure-mode-hook 'lispy-mode)
;  :config
;  ;; disables the special (location) key-theme
;  (lispy-set-key-theme '(lispy c-digits)))
;
;(use-package lispyville
;  ;:after (lispy evil)
;  :config
;  (add-hook 'lispy-mode-hook #'lispyville-mode)
;  (lispyville-set-key-theme
;   '(operators
;     c-w
;     escape
;     wrap
;     slurp/barf-lispy
;     additional-movement
;     additional-wrap)))

