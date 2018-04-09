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
      '(
	evil
	helm
	which-key
	window
	smartparens
	git
	linum
	motion
	multiedit
	theme
	))

(defun load-layer (layer-symbol)
  (let ((layer-name (symbol-name layer-symbol)))
    (condition-case err
	(load (concat
		user-emacs-directory "layers/"
		layer-name ".el"))
      (error (display-warning :error
	      (concat "Error loading "
		      layer-name ": "
		      (error-message-string err)))))))

(mapcar 'load-layer layers)
