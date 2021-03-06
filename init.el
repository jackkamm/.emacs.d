;; Start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; Add lisp files to load path
(push (concat user-emacs-directory "lisp") load-path)

;; Set and load custom-file as early as possible, to prevent Custom
;; writing to init.el, and to avoid overriding other settings
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file t)

;; Initialize package and use-package

(customize-set-variable 'package-archives
                        '(("org" . "http://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(require 'bind-key)
(customize-set-variable 'use-package-always-ensure t)
(customize-set-variable 'use-package-verbose t)
(customize-set-variable 'use-package-always-defer t)

;; Load additional configurations in config.el. If it doesn't exist,
;; create it from a template

(let ((config-el (concat user-emacs-directory "config.el"))
      (template (concat user-emacs-directory "config-template.el")))
  (unless (file-exists-p config-el)
    (copy-file template config-el))
  (load config-el))
