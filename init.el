;; Start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; Set custom file
(setq custom-file (concat user-emacs-directory "custom.el"))

;; Initialize packages
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap and configure use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(setq use-package-always-ensure t) ;install missing packages

;; Set up load path
(let ((default-directory (concat user-emacs-directory "lisp/")))
  ;; recursively prepend to load-path
  ;; NOTE add ".nosearch" file to exclude directory
  (setq load-path
	(append
	 (let ((load-path (copy-sequence load-path))) ;shadow
	   (append
	    (copy-sequence
	     (normal-top-level-add-to-load-path '(".")))
	    (normal-top-level-add-subdirs-to-load-path)))
	 load-path)))

;; Initialize the core packages required by the rest of my config:
;; evil, general, which-key, hydra

;; evil
(use-package evil
  :custom
  (evil-overriding-maps nil)
  (evil-intercept-maps nil)
  (evil-want-keybinding nil) ;needed for evil-collection
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil) ;allow org-mode TAB in terminal
  (evil-symbol-word-search t)
  (evil-respect-visual-line-mode t)
  ;; make emacs- and insert-states identical
  (evil-disable-insert-state-bindings t)
  :config
  ;; get rid of motion state everywhere
  (defalias 'evil-motion-state 'evil-insert-state)
  ;; get rid of emacs state nearly everywhere
  (mapc (lambda (mode) (evil-set-initial-state mode 'insert))
        evil-emacs-state-modes)
  ;;(setq evil-motion-state-tag (propertize
  ;;                            "  MOTION  " 'face
  ;;                            '((:background "purple" :foreground "black"))))
  (setq evil-emacs-state-tag (propertize
                              "  EMACS  " 'face
                              '((:background "blue" :foreground "black"))))
  (setq evil-insert-state-tag (propertize
                               "  INSERT  " 'face
                               '((:background "green" :foreground "black"))))
  ;; Remove SPC/RET keybindings
  (evil-global-set-key 'motion (kbd "SPC") nil)
  (evil-global-set-key 'motion (kbd "RET") nil)
  ;; https://vim.fandom.com/wiki/Unused_keys
  (evil-global-set-key 'motion "+" 'repeat)
  ;; Start evil
  (evil-mode))

;; which-key
(use-package which-key
  :custom
  (which-key-sort-order 'which-key-key-order-alpha)
  (which-key-enable-extended-define-key t)
  :config
  (which-key-mode))

;; general
(use-package general
  :config
  (general-override-mode)

  (general-create-definer my-leader :prefix "C-c")

  (general-define-key
   :keymaps 'override
   :states '(normal motion visual)
   "SPC" (general-simulate-key "C-c"))

  (my-leader
    "a" '(:ignore t :which-key "Applications")
    "q" '(:ignore t :which-key "Quit")
    "m" '(:ignore t :which-key "Major")
    "k" 'which-key-show-top-level
    "qq" 'save-buffers-kill-emacs
    "h" '(:keymap help-map :which-key "Help")
    "H" 'info-apropos
    "c" (general-simulate-key "C-c C-c")
    "u" 'universal-argument)

  (general-create-definer my-major-leader
    :states '(normal motion visual emacs insert)
    :prefix "_"
    :global-prefix "C-c m"))

;; hydra
(use-package hydra)

(use-package hercules)


;;; Load additional configurations

(mapc 'load
      (list
       ;; load first to ensure org-plus-contrib
       "my-org"

       ;; completion system, only enable 1
       "my-helm"
       ;;"my-ivy"

       "my-buffers-files" ;includes dired, diff'ing
       "my-windows-frames"
       "my-lines-regions" ;line numbers/wrapping, parens, narrowing, etc
       "my-motions-jumping" ;avy, easymotion
       "my-search-replace" ;grep, swiper/swoop, iedit/mc
       "my-history-vc-undo" ;git, undo
       "my-ide" ;lsp, projectile, xref, company, flycheck
       "my-tramp"
       "my-shell"
       "my-snippets"

       "my-startup" ;exec-path-from-shell, keychain, esup
       "my-theme"

       "my-email-chat"

       ;; languages
       "my-python"
       ;;"my-clojure"
       "my-literate-programming"
       "my-R"
       "my-julia"
       "my-emacs-lisp"
       "my-tex"
       "my-yaml"
       "my-ledger"
       ;; c-c++: only enable 1 of cquery, rtags
       ;;"my-cquery"
       ;;"my-rtags"
       "my-lang-misc"
       ))

(load custom-file t)
