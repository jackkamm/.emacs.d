(let ((init-start-time (float-time)))
  ;; setup package.el, load-path
  (let ((package-init-start (float-time)))
    (require 'package)
    (setq package-enable-at-startup nil)
    (add-to-list 'package-archives
		 '("melpa" . "https://melpa.org/packages/"))

    (package-initialize)

    (let ((default-directory  (concat user-emacs-directory "lisp/")))
      (normal-top-level-add-to-load-path '("."))
      (normal-top-level-add-subdirs-to-load-path))

    (message
     (format "Initialized packages, load-path in %.2f seconds."
	     (- (float-time) package-init-start))))

  ;; function to load layer, time it, catch any errors
  (defun my-load-layer (layer-path)
    (let ((layer-init-start (float-time)))
      (condition-case err
	  (progn
	    (load (expand-file-name layer-path
				    user-emacs-directory)
		  nil t)
	    (message
	     (concat "Loaded " layer-path " in "
		     (format "%.2f" (- (float-time)
				       layer-init-start))
		     " seconds.")))
	(error
	 (display-warning :error
			  (concat "Error loading "
				  layer-path ": "
				  (error-message-string err)))))))

  (setq my-layers
	(list
	 ;;;; MUST be loaded first!
	 "my-layers/my-use-package.el"
	 "my-layers/my-keys.el" ;evil, general, which-key, bind-key
	 "my-layers/my-org.el" ;ensure org-plus-contrib
	 ;; other core packages
	 "my-layers/my-helm.el"
	 "my-layers/my-hydra.el"

	 ;; editing
	 ;;"my-layers/my-hybrid-state.el"
	 "my-layers/my-jump.el" ;SPC-j: avy, easymotion, xref, etc
	 "my-layers/my-multiedit.el" ;iedit, multicursor
	 "my-layers/my-parens.el" ;smartparens, evil-surround
	 "my-layers/my-snippets.el"
	 "my-layers/my-flycheck.el"
	 "my-layers/my-company.el"
	 "my-layers/my-expand-region.el"
	 "my-layers/my-scroll-hydra.el"
	 "my-layers/my-undo-tree.el"

	 ;; applications
	 "my-layers/my-git.el"
	 "my-layers/my-email.el"
	 "my-layers/my-irc.el"
	 "my-layers/my-ediff.el"

	 ;; theming
	 "my-layers/my-theme.el"
	 "my-layers/my-window-layout.el"
	 "my-layers/my-linum.el"
	 "my-layers/my-hidpi.el"
	 "my-layers/my-prompts.el"
	 "my-layers/my-pos-tip.el"
	 "my-layers/my-highlight.el"
	 "my-layers/my-popwin.el"
	 "my-layers/my-saving.el"
	 "my-layers/my-minimap.el"
	 "my-layers/my-default-browser.el"

	 ;; languages
	 "my-layers/my-python.el"
	 "my-layers/my-ein.el"
	 "my-layers/my-ess.el"
	 "my-layers/my-emacs-lisp.el"
	 "my-layers/my-org-babel.el"
	 "my-layers/my-tex.el"
	 "my-layers/my-web.el"
	 ;; c-c++: only enable 1 of cquery, rtags
	 "my-layers/my-cquery.el"
	 ;;"my-layers/my-rtags.el"

	 ;; miscellaneous
	 "my-layers/my-start-server.el"
	 "my-layers/my-set-custom-file.el"
	 "my-layers/my-tramp.el"
	 ))

  (mapcar 'my-load-layer my-layers)

  (message
   (format "Startup took %.2f seconds."
	   (- (float-time) init-start-time))))

