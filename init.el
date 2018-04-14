
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
	 "layers/my-use-package.el"
	 "layers/my-keys.el"
	 ;; other core packages
	 "layers/my-helm.el"
	 "layers/my-hydra.el"

	 ;; load early to ensure org-plus-contrib
	 "layers/my-org.el"

	 ;; editing
	 "layers/my-hybrid-state.el"
	 "layers/my-motions.el" ;avy, evil-easymotion, scroll hydra
	 "layers/my-multiedit.el" ;iedit, multicursor
	 "layers/my-parens.el" ;smartparens, evil-surround
	 "layers/my-snippets.el"
	 "layers/my-flycheck.el"
	 "layers/my-company.el"
	 "layers/my-expand-region.el"

	 ;; applications
	 "layers/my-git.el"
	 "layers/my-email.el"
	 "layers/my-erc.el"

	 ;; theming
	 "layers/my-theme.el"
	 "layers/my-window-layout.el"
	 "layers/my-linum.el"
	 "layers/my-hidpi.el"
	 "layers/my-prompts.el"
	 "layers/my-pos-tip.el"
	 "layers/my-highlight.el"
	 "layers/my-popwin.el"
	 "layers/my-saving.el"
	 "layers/my-minimap.el"

	 ;; languages
	 "layers/my-python.el"
	 "layers/my-ein.el"
	 "layers/my-ess.el"
	 "layers/my-emacs-lisp.el"
	 "layers/my-org-babel.el"
	 "layers/my-tex.el"
	 "layers/my-web.el"
	 ;; c-c++: only enable 1 of cquery, rtags
	 "layers/my-cquery.el"
	 ;;"layers/my-rtags.el"

	 ;; miscellaneous
	 "layers/my-start-server.el"
	 "layers/my-set-custom-file.el"
	 "layers/my-tramp.el"
	 ))

  (mapcar 'load-layer layers)

  (message
   (concat "Startup took "
	   (format "%.2f" (- (float-time)
			     init-start-time))
	   " seconds.")))

