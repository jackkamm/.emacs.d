;; Start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; Set custom-file as early as possible, to prevent any possibility of
;; Custom writing to init.el. However, don't load it yet -- make sure
;; `load-path' has been properly set before doing any configurations
(customize-set-variable 'custom-file (concat user-emacs-directory "custom.el"))

;; TODO: move to early-init.el?
;; Initialize packages
(require 'package)
(customize-set-variable 'package-enable-at-startup nil)
(customize-set-variable 'package-archives
                        '(("org" . "http://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Bootstrap and configure use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Ensure org-plus-contrib is installed to preempt the bundled
;; org-mode. Don't load it yet, in case we prefer to use a more
;; updated version on the load-path
(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

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

(load "my-base")

;;; Load additional configurations

;; Typically, post-init.el should load my-core.el, unless on Windows
;; or desiring a minimal install

(load (concat user-emacs-directory "post-init.el") t)
