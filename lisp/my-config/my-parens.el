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
  ;; access the "raw" default evil-jump
  (my-leader
    "%" 'evil-jump-item)
  ;; mhtml-mode
  (plist-put evilmi-plugins 'mhtml-mode '((evilmi-template-get-tag evilmi-template-jump)
                                          (evilmi-simple-get-tag evilmi-simple-jump)
                                          (evilmi-html-get-tag evilmi-html-jump))))
