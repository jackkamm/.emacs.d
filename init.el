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
    ;; other prefixes
    "f" '(:ignore t :which-key "file")
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
       ;; TODO flycheck

       ;; applications
       "layers/git.el"
       "layers/email.el"

       ;; theming
       "layers/theme.el"
       "layers/window-layout.el"
       "layers/linum.el"
       "layers/hidpi.el"
       "layers/prompts.el"
       "layers/highlight.el" ;TODO SPC s h, SPC s c
       ;; TODO nicer cursor colors

       ;; languages
       "layers/python.el"
       "layers/ess.el"
       "layers/org.el"
       "layers/org-babel.el"
       "layers/tex.el"
       "layers/emacs-lisp.el"
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
