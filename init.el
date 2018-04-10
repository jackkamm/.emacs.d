;; bootstrap use-package
;; (https://github.com/jwiegley/use-package/issues/313)
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

;; bind-key
(use-package bind-key)

;; evil
(use-package evil
  :config
  (evil-mode)
  (evil-global-set-key 'motion (kbd "SPC") nil))

;; general
(use-package general
  :config
  (general-override-mode)
  (general-create-definer leader-bind
    :states '(motion
	      normal ;override normal bindings
	      visual insert emacs)
    :prefix "SPC"
    :keymaps 'override
    :global-prefix "M-m"
    :prefix-map 'leader-map)
  ;; create leader-map
  (leader-bind
    "u" 'universal-argument
    "q q" 'save-buffers-kill-terminal
    "q f" 'delete-frame
    "b d" 'kill-buffer
    "b x" 'kill-buffer-and-window
    "z" 'evil-execute-in-emacs-state
    "!" 'shell-command)
  (general-create-definer leader-bind-local
    :states '(motion visual insert emacs)
    :prefix "SPC m"
    :global-prefix "M-m m"))

;; org-plus-contrib
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(use-package org
  :defer t :ensure org-plus-contrib)

;; load layers
(setq layers
      (list
       ;; completion
       "layers/helm.el"

       ;; editing
       "layers/evil.el"
       "layers/motion.el" ;avy, evil-easymotion
       "layers/multiedit.el" ;iedit, multicursor
       "layers/smartparens.el"
       "layers/snippet.el"
       ;; TODO: flycheck undo-tree

       ;; applications
       "layers/git.el"
       "layers/email.el"

       ;; theming
       "layers/theme.el"
       "layers/window-layout.el"
       "layers/which-key.el"
       "layers/linum.el"
       "layers/hidpi.el"

       ;; languages
       "layers/python.el"
       "layers/ess.el"
       "layers/org.el"
       "layers/org-babel.el"
       "layers/tex.el"
       ;; TODO: c-c++

       ;; initialization
       "layers/start-server.el"
       "layers/set-custom-file.el"
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

