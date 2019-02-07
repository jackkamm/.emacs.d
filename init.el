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


;;;; load modules
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
       "my-evil-extra" ;evil-collection, extra evil configs
       "my-files" ;dired, find-files
       "my-buffers"
       "my-search-replace" ;iedit/mc,swoop/projectile,narrowing,wgrep
       "my-jump" ;avy, easymotion, xref
       "my-navigation" ;minimap, navigation hydra
       "my-window-layout" ;winner, ace-window
       "my-syntax-checking" ;flycheck
       "my-git"
       "my-ediff"
       "my-snippets"
       "my-company"
       "my-undo"
       "my-parens"
       "my-expand-region"
       "my-narrow"

	 ;;; applications
       "my-email"
       "my-irc"
       "my-tramp"
       "my-shell"
       "my-startup" ;path, keychain, profiler
       "my-docker"

	 ;;; theming
       "my-theme"
       "my-emoji"
       "my-osx"
       "my-lines" ;linenum, visual-line-mode
       ;;"my-hidpi"

	 ;;; languages
       "my-python"
       "my-clojure"
       "my-ein"
       "my-R"
       "my-julia"
       "my-emacs-lisp"
       "my-tex"
       "my-web"
       "my-yaml"
       ;; c-c++: only enable 1 of cquery, rtags
       "my-cquery"
       ;;"my-rtags"
       "my-lang-misc"
       ))
