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

;; leader key
(setq leader-map (make-sparse-keymap))

;; load layers
(mapcar
 'load (mapcar
	'(lambda
	   (layer)
	   (concat "~/.emacs.d/lisp/"
		   (symbol-name layer)
		   ".el"))
	'(
	  theme
	  evil
	  helm
	  which-key
	  window
	  smartparens
	  git
	  )))
