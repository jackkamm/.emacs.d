;; start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; set custom file
(setq custom-file (concat user-emacs-directory
			  "custom.el"))
(if (file-exists-p custom-file)
    (load-file custom-file))

;; packages
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(setq use-package-always-ensure t) ;install missing packages

; load path
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
