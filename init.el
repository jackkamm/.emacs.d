;; bootstrap use-package
;; from https://github.com/jwiegley/use-package/issues/313
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; always install missing packages
(setq use-package-always-ensure t)

;; external custom-file
(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)
    (load-file custom-file))

;; start server
(require 'server)
(unless (server-running-p) (server-start))

;; leader key
(use-package bind-key)
(setq leader-map (make-sparse-keymap))
(bind-key* "M-m" leader-map)
(bind-keys :map leader-map
	   ("q q" . save-buffers-kill-terminal)
	   ("q f" . delete-frame)
	   ("b d" . kill-buffer)
	   ("b x" . kill-buffer-and-window))

;; load layers
(setq layers
      (list
       "layers/evil.el"
       "layers/helm.el"
       "layers/which-key.el"
       "layers/window.el"
       "layers/smartparens.el"
       "layers/git.el"
       "layers/linum.el"
       "layers/motion.el"
       "layers/multiedit.el"
       "layers/theme.el"
       "layers/email.el"
	;;TODO
	;; general
	;; ess python latex
	;; yasnippet flycheck
	))

(defun load-layer (layer-name)
    (condition-case err
	(load (concat user-emacs-directory
			layer-name))
	(error (display-warning :error
		(concat "Error loading "
			layer-name ": "
			(error-message-string err))))))

(mapcar 'load-layer layers)

;; TODO: move into layer
(defalias 'yes-or-no-p 'y-or-n-p)
