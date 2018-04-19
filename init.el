(let ((init-start-time (float-time)))
  ;; setup package.el, load-path
  (let ((package-init-start (float-time)))
    (require 'package)
    (setq package-enable-at-startup nil)
    (add-to-list 'package-archives
		 '("melpa" . "https://melpa.org/packages/"))

    (package-initialize)

    ;; recursively add ~/.emacs.d/lisp to beginning of load-path
    ;; add ".nosearch" file to exclude a directory
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
	 "my-config-layers/my-use-package.el"
	 "my-config-layers/my-keys.el" ;evil, general, which-key, bind-key
	 "my-config-layers/my-org.el" ;ensure org-plus-contrib
	 ;; other core packages
	 "my-config-layers/my-helm.el"
	 "my-config-layers/my-hydra.el"

	 ;; editing
	 ;;"my-config-layers/my-hybrid-state.el"
	 "my-config-layers/my-jump.el" ;SPC-j, avy, easymotion, xref
	 "my-config-layers/my-multiedit.el" ;iedit, multicursor
	 "my-config-layers/my-parens.el" ;smartparens, evil-surround
	 "my-config-layers/my-snippets.el"
	 "my-config-layers/my-flycheck.el"
	 "my-config-layers/my-company.el"
	 "my-config-layers/my-expand-region.el"
	 "my-config-layers/my-scroll-hydra.el"
	 "my-config-layers/my-undo-tree.el"

	 ;; applications
	 "my-config-layers/my-git.el"
	 "my-config-layers/my-email.el"
	 "my-config-layers/my-irc.el"
	 "my-config-layers/my-ediff.el"

	 ;; theming
	 "my-config-layers/my-theme.el"
	 "my-config-layers/my-window-layout.el"
	 "my-config-layers/my-linum.el"
	 "my-config-layers/my-hidpi.el"
	 "my-config-layers/my-prompts.el"
	 "my-config-layers/my-pos-tip.el"
	 "my-config-layers/my-highlight.el"
	 "my-config-layers/my-popwin.el"
	 "my-config-layers/my-saving.el"
	 "my-config-layers/my-minimap.el"
	 "my-config-layers/my-default-browser.el"

	 ;; languages
	 "my-config-layers/my-python.el"
	 "my-config-layers/my-ein.el"
	 "my-config-layers/my-ess.el"
	 "my-config-layers/my-emacs-lisp.el"
	 "my-config-layers/my-org-babel.el"
	 "my-config-layers/my-tex.el"
	 "my-config-layers/my-web.el"
	 ;; c-c++: only enable 1 of cquery, rtags
	 "my-config-layers/my-cquery.el"
	 ;;"my-config-layers/my-rtags.el"

	 ;; miscellaneous
	 "my-config-layers/my-start-server.el"
	 "my-config-layers/my-set-custom-file.el"
	 "my-config-layers/my-tramp.el"
	 ))

  (mapcar 'my-load-layer my-layers)

  (message
   (format "Startup took %.2f seconds."
	   (- (float-time) init-start-time))))

