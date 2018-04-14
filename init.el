
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(defun load-layer (layer-name)
  (let ((layer-start-time (float-time)))
    (condition-case err
	(progn
	  (load (concat user-emacs-directory
			layer-name)
		nil t)
	  (message
	   (concat "Loaded " layer-name " in "
		   (format "%.2f" (- (float-time)
				     layer-start-time))
		   " seconds.")))
      (error (display-warning :error
			      (concat "Error loading "
				      layer-name ": "
				      (error-message-string err)))))))

(let ((init-start-time (float-time)))
  (setq layers
	(list
	 ;;;; MUST be loaded first!
	 "my-elisp/my-use-package.el"
	 "my-elisp/my-keys.el"
	 "my-elisp/my-org.el" ;ensure org-plus-contrib
	 ;; other core packages
	 "my-elisp/my-helm.el"
	 "my-elisp/my-hydra.el"

	 ;; editing
	 "my-elisp/my-hybrid-state.el"
	 "my-elisp/my-motions.el" ;avy, evil-easymotion, scroll hydra
	 "my-elisp/my-multiedit.el" ;iedit, multicursor
	 "my-elisp/my-parens.el" ;smartparens, evil-surround
	 "my-elisp/my-snippets.el"
	 "my-elisp/my-flycheck.el"
	 "my-elisp/my-company.el"
	 "my-elisp/my-expand-region.el"

	 ;; applications
	 "my-elisp/my-git.el"
	 "my-elisp/my-email.el"
	 "my-elisp/my-erc.el"

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

  (mapcar 'load-layer layers)

  (message
   (concat "Startup took "
	   (format "%.2f" (- (float-time)
			     init-start-time))
	   " seconds.")))

