  ;;;; Initial setup
(let ((setup-init-start (float-time)))
    ;;; initialize packages
  (require 'package)
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/"))

  (package-initialize)

    ;;; bootstrap and setup use-package
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  (eval-when-compile
    (require 'use-package))
  (require 'bind-key)

  (setq use-package-always-ensure t) ;install missing packages

    ;;; setup load path
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

  (message
   (format "Initial setup in %.2f seconds."
	   (- (float-time) setup-init-start))))

  ;;;; load modules
(mapc 'load
      (list
	 ;;; load first -- all modules depend on it
       "my-core" ;evil, general, which-key, hydra

	 ;;; load next to ensure org-plus-contrib
       "my-org"

         ;;; other miscellaneous setup
       "my-setup" ;custom-file, server-start

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

	 ;;; applications
       "my-inbox"
       "my-irc"
       "my-tramp"

	 ;;; theming
       "my-theme"
       "my-emoji"
       "my-osx"
       ;;"my-hidpi"

	 ;;; languages
       "my-python"
       "my-ein"
       "my-ess"
       "my-emacs-lisp"
       "my-tex"
       "my-web"
       "my-yaml"
       ;; c-c++: only enable 1 of cquery, rtags
       "my-cquery"
       ;;"my-rtags"
       "my-lang-misc"
       ))
