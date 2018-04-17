
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(let ((init-start-time (float-time)))
  (defun my-load-elisp (module-path)
    (let ((module-init-start (float-time)))
      (condition-case err
	  (progn
	    (load (expand-file-name module-path
				    user-emacs-directory)
		  nil t)
	    (message
	     (concat "Loaded " module-path " in "
		     (format "%.2f" (- (float-time)
				       module-init-start))
		     " seconds.")))
	(error
	 (display-warning :error
			  (concat "Error loading "
				  module-path ": "
				  (error-message-string err)))))))

  (setq my-elisp-modules
	(list
	 ;;;; MUST be loaded first!
	 "my-elisp/my-use-package.el"
	 "my-elisp/my-keys.el"
	 "my-elisp/my-org.el" ;ensure org-plus-contrib
	 ;; other core packages
	 "my-elisp/my-helm.el"
	 "my-elisp/my-hydra.el"

	 ;; editing
	 ;;"my-elisp/my-hybrid-state.el"
	 "my-elisp/my-jump.el" ;SPC-j: avy, easymotion, xref, etc
	 "my-elisp/my-multiedit.el" ;iedit, multicursor
	 "my-elisp/my-parens.el" ;smartparens, evil-surround
	 "my-elisp/my-snippets.el"
	 "my-elisp/my-flycheck.el"
	 "my-elisp/my-company.el"
	 "my-elisp/my-expand-region.el"
	 "my-elisp/my-scroll-hydra.el"

	 ;; applications
	 "my-elisp/my-git.el"
	 "my-elisp/my-email.el"
	 "my-elisp/my-irc.el"

	 ;; theming
	 "my-elisp/my-theme.el"
	 "my-elisp/my-window-layout.el"
	 "my-elisp/my-linum.el"
	 "my-elisp/my-hidpi.el"
	 "my-elisp/my-prompts.el"
	 "my-elisp/my-pos-tip.el"
	 "my-elisp/my-highlight.el"
	 "my-elisp/my-popwin.el"
	 "my-elisp/my-saving.el"
	 "my-elisp/my-minimap.el"
	 "my-elisp/my-default-browser.el"

	 ;; languages
	 "my-elisp/my-python.el"
	 "my-elisp/my-ein.el"
	 "my-elisp/my-ess.el"
	 "my-elisp/my-emacs-lisp.el"
	 "my-elisp/my-org-babel.el"
	 "my-elisp/my-tex.el"
	 "my-elisp/my-web.el"
	 ;; c-c++: only enable 1 of cquery, rtags
	 "my-elisp/my-cquery.el"
	 ;;"my-elisp/my-rtags.el"

	 ;; miscellaneous
	 "my-elisp/my-start-server.el"
	 "my-elisp/my-set-custom-file.el"
	 "my-elisp/my-tramp.el"
	 ))

  (mapcar 'my-load-elisp my-elisp-modules)

  (message
   (concat "Startup took "
	   (format "%.2f" (- (float-time)
			     init-start-time))
	   " seconds.")))

