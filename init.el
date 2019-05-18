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

;;;; load core modules
(mapc 'load
      (list
	 ;;; load first -- all modules depend on it
       "my-core" ;evil, general, which-key, hydra

         ;;; load next to ensure org-plus-contrib
       "my-org"

         ;;; completion system, only enable 1
       ;;"my-helm"
       "my-ivy"

	;;; editing
       ;;"my-evil-collection"
       "my-files" ;dired, find-files
       "my-buffers"
       "my-search-replace" ;iedit/mc,swoop/projectile,narrowing,wgrep
       "my-jump" ;avy, easymotion, xref
       "my-display" ;window, frame
       "my-syntax-checking" ;flycheck
       "my-git"
       "my-ediff"
       "my-snippets"
       "my-company"
       "my-undo"
       "my-parens"
       "my-region"
       "my-lines" ;linenum, visual-line-mode
       "my-lsp"
       ))

;; load extra modules in config.el
(let ((config-el "~/.emacs.d/config.el"))
  (when (file-exists-p config-el)
    (load config-el)))
