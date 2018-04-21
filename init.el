(let ((init-start-time (float-time)))
  ;; Initial setup
  (let ((setup-init-start (float-time)))
    ;; initialize packages
    (require 'package)
    (setq package-enable-at-startup nil)
    (add-to-list 'package-archives
		 '("melpa" . "https://melpa.org/packages/"))

    (package-initialize)

    ;; bootstrap use-package
    (unless (package-installed-p 'use-package)
      (package-refresh-contents)
      (package-install 'use-package))

    (eval-when-compile
      (require 'use-package))
    (require 'bind-key)

    ;; always install missing packages
    (setq use-package-always-ensure t)

    ;; recursively add ~/.emacs.d/lisp to beginning of load-path
    ;; NOTE add ".nosearch" file to exclude a directory
    (let ((default-directory (concat user-emacs-directory "lisp/")))
      (setq load-path
	    (append
	     (let ((load-path (copy-sequence load-path))) ;; Shadow
	       (append
		(copy-sequence
		 (normal-top-level-add-to-load-path '(".")))
		(normal-top-level-add-subdirs-to-load-path)))
	     load-path)))

    (message
     (format "Initial setup in %.2f seconds."
	     (- (float-time) setup-init-start))))

  ;; function to load module, time it, catch any errors
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

  (setq my-modules
	(list
	 ;;;; MUST be loaded first!
	 "my-keys" ;evil, general, which-key
	 "my-org" ;ensure org-plus-contrib
	 ;; other core packages
	 "my-helm"
	 "my-hydra"

	 ;; miscellaneous useful functions
	 "my-functions"

	 ;; editing
	 ;"my-hybrid-state"
	 "my-jump" ;SPC-j: avy, easymotion, xref
	 "my-multiedit" ;iedit, evil-mc, narrow-region
	 "my-parens" ;smartparens, evil-surround
	 "my-snippets" ;yasnippet
	 "my-flycheck"
	 "my-company"
	 "my-expand-region"
	 "my-navigation" ;minimap
	 "my-undo-tree"

	 ;; applications
	 "my-git"
	 "my-email"
	 "my-irc"
	 "my-ediff"

	 ;; theming
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

	 ;; languages
	 "my-python"
	 "my-ein"
	 "my-ess"
	 "my-emacs-lisp"
	 "my-org-babel"
	 "my-tex"
	 "my-web"
	 ;; c-c++: only enable 1 of cquery, rtags
	 "my-cquery"
	 ;"my-rtags"

	 ;; miscellaneous
	 "my-start-server"
	 "my-set-custom-file"
	 "my-tramp"
	 ))

  (mapcar 'my-load-module my-modules)

  (message
   (format "Startup took %.2f seconds."
	   (- (float-time) init-start-time))))
