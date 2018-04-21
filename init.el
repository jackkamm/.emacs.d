(let ((init-start-time (float-time)))
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

  ;;;; add pre-module configurations here

  ;;;; configuration modules to load
  (setq my-modules
	(list
	 ;;; load first -- all modules depend on it
	 "my-core" ;evil, general, which-key

	 ;;; load next to ensure org-plus-contrib
	 "my-org"

	 ;;; core editor modules
	 "my-helm"
	 "my-hydra"
	 "my-evil-extra" ;evil-collection, extra evil configs
	 ;;"my-hybrid-state"
	 "my-jump" ;SPC-j: avy, easymotion, xref
	 "my-multiedit" ;iedit, evil-mc, narrow-region
	 "my-parens" ;smartparens, evil-surround
	 "my-snippets" ;yasnippet
	 "my-flycheck"
	 "my-company"
	 "my-expand-region"
	 "my-navigation" ;minimap
	 "my-undo-tree"

	 ;;; applications
	 "my-git"
	 "my-email"
	 "my-irc"
	 "my-ediff"

	 ;;; theming
	 "my-theme"
	 "my-window-layout"
	 "my-linum"
	 "my-hidpi"
	 "my-prompts"
	 "my-pos-tip"
	 "my-highlight" ;hl-todo, evil-highlight-persist
	 "my-popwin"
	 "my-saving"
	 "my-default-browser"
	 "my-whitespace"

	 ;;; languages
	 "my-python"
	 "my-ein"
	 "my-ess"
	 "my-emacs-lisp"
	 "my-org-babel"
	 "my-tex"
	 "my-web"
	 ;; c-c++: only enable 1 of cquery, rtags
	 "my-cquery"
	 ;;"my-rtags"

	 ;;; miscellaneous
	 "my-start-server"
	 "my-set-custom-file"
	 "my-functions" ;misc. useful functions
	 "my-tramp"
	 ))

  ;;;; load my configuration modules
  (defun my-load-module (module)
    (let ((module-init-start (float-time)))
      (condition-case err
	  (progn
	    (load module nil t)
	    (message
	     (concat "Loaded " module " in "
		     (format "%.2f" (- (float-time)
				       module-init-start))
		     " seconds.")))
	(error
	 (display-warning :error
			  (concat "Error loading "
				  module ": "
				  (error-message-string err)))))))
  (mapcar 'my-load-module my-modules)

  ;;;; add post module configurations here

  ;;;; finished
  (message
   (format "Startup took %.2f seconds."
	   (- (float-time) init-start-time))))
