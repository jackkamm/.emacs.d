
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

;; TODO: rename all config files to my- to prevent load-path conflicts
(let ((init-start-time (float-time)))
  (setq layers
	(list
	 ;;;; MUST be loaded first!
	 "layers/bootstrap-use-package.el"
	 "layers/core-keymaps.el"
	 ;; other core packages
	 "layers/helm.el"
	 "layers/hydra.el"

	 ;; load early to ensure org-plus-contrib
	 "layers/org.el"

	 ;; editing
	 "layers/evil-insert-hybrid.el"
	 "layers/motion.el" ;avy, evil-easymotion, scroll hydra
	 "layers/multiedit.el" ;iedit, multicursor
	 "layers/parens.el" ;smartparens, evil-surround
	 "layers/snippet.el"
	 "layers/flycheck.el"
	 "layers/company.el"
	 "layers/expand-region.el"

	 ;; applications
	 "layers/git.el"
	 "layers/email.el"
	 "layers/erc.el"

	 ;; theming
	 "layers/theme.el"
	 "layers/window-layout.el"
	 "layers/linum.el"
	 "layers/hidpi.el"
	 "layers/prompts.el"
	 "layers/pos-tip.el"
	 "layers/highlight.el"
	 "layers/popwin.el"
	 "layers/saving.el"
	 "layers/minimap.el"

	 ;; languages
	 "layers/python.el"
	 "layers/ein.el"
	 "layers/ess.el"
	 "layers/emacs-lisp.el"
	 "layers/org-babel.el"
	 "layers/tex.el"
	 "layers/web.el"
	 ;; c-c++: only enable 1 of cquery, rtags
	 "layers/cquery.el"
	 ;;"layers/rtags.el"

	 ;; miscellaneous
	 "layers/start-server.el"
	 "layers/set-custom-file.el"
	 "layers/tramp.el"
	 ))

  (mapcar 'load-layer layers)

  (message
   (concat "Startup took "
	   (format "%.2f" (- (float-time)
			     init-start-time))
	   " seconds.")))

