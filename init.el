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
  :init
  (setq evil-want-integration nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode)
  (evil-global-set-key 'motion (kbd "SPC") nil)
  (evil-global-set-key 'motion (kbd "RET") nil))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; which-key
(use-package which-key :config (which-key-mode))

;; general
(use-package general
  :config
  (general-override-mode)
  (general-create-definer my-leader
    :states '(motion
	      normal ;override normal bindings
	      visual insert emacs)
    :prefix "SPC"
    :keymaps 'override
    :global-prefix "M-m"
    :prefix-map 'my-leader-map)
  ;; create my-leader-map
  (my-leader
    "u" 'universal-argument
    "z" 'evil-execute-in-emacs-state
    "!" 'shell-command
    "h" '(:keymap help-map :which-key "help")
    ;; buffers
    "b" '(:ignore t :which-key "buffer")
    "b d" 'kill-buffer
    "b x" 'kill-buffer-and-window
    ;; quitting
    "q" '(:ignore t :which-key "quit")
    "q q" 'save-buffers-kill-terminal
    "q f" 'delete-frame
    ;; files
    "f" '(:ignore t :which-key "file")
    "fs" 'save-buffer
    ;; other prefixes
    "e" '(:ignore t :which-key "eval")
    "m" '(:ignore t :which-key "major")
    "j" '(:ignore t :which-key "jump")
    "i" '(:ignore t :which-key "insert")
    "g" '(:ignore t :which-key "git")
    "s" '(:ignore t :which-key "search"))
  (define-key key-translation-map (kbd "SPC c") (kbd "C-c"))
  (general-create-definer my-major-leader
    :states '(motion visual insert emacs)
    :prefix "SPC m"
    :global-prefix "M-m m")
  (general-create-definer my-eval-leader
    :states '(motion visual insert emacs)
    :prefix "SPC e"
    :global-prefix "M-m e"))

;; org-plus-contrib
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(use-package org
  ;;:defer t
  :ensure org-plus-contrib)

;; load layers
(setq layers
      (list
       ;; completion
       "layers/helm.el"

       ;; editing
       "layers/evil-insert-hybrid.el"
       "layers/motion.el" ;avy, evil-easymotion
       "layers/multiedit.el" ;iedit, multicursor
       "layers/parens.el" ;smartparens, evil-surround
       "layers/snippet.el"
       "layers/flycheck.el"
       "layers/company.el"

       ;; applications
       "layers/git.el"
       "layers/email.el"

       ;; theming
       "layers/theme.el"
       "layers/window-layout.el"
       "layers/linum.el"
       "layers/hidpi.el"
       "layers/prompts.el"
       "layers/pos-tip.el"
       "layers/highlight.el" ;TODO SPC s h, SPC s c
       "layers/popwin.el"
       ;; TODO nicer cursor colors

       ;; languages
       "layers/python.el"
       "layers/ess.el"
       "layers/org.el"
       "layers/org-babel.el"
       "layers/tex.el"
       "layers/emacs-lisp.el"
       "layers/ein.el"
       ;; TODO c-c++ ein

       ;; miscellaneous
       "layers/start-server.el"
       "layers/set-custom-file.el"
       "layers/tramp.el"
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
