;; Start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; Set custom-file as early as possible, to prevent any possibility of
;; Custom writing to init.el. However, don't load it yet -- make sure
;; `load-path' has been properly set before doing any configurations
(setq custom-file (concat user-emacs-directory "custom.el"))

;; Initialize package
;; cf https://github.com/jwiegley/use-package/issues/313#issue-128754131

(require 'package)
(customize-set-variable 'package-archives
                        '(("org" . "http://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Set up load path
(let ((default-directory (concat user-emacs-directory "lisp/")))
  ;; recursively prepend to load-path
  ;; NOTE add ".nosearch" file to exclude directory
  (setq load-path
	(append
	 (let ((load-path (copy-sequence load-path))) ;shadow
	   (append
	    (copy-sequence
	     (normal-top-level-add-to-load-path '(".")))
	    (normal-top-level-add-subdirs-to-load-path)))
	 load-path)))

;; Load custom-file now, before any other configurations, to try and
;; prevent it from clobbering other settings
(load custom-file t)

;; use-package
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
