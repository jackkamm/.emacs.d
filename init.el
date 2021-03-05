;; Start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; Set custom-file as early as possible, to prevent any possibility of
;; Custom writing to init.el. However, don't load it yet -- make sure
;; `load-path' has been properly set before doing any configurations
(setq custom-file (concat user-emacs-directory "custom.el"))

;; Initialize package
;; cf https://github.com/jwiegley/use-package/issues/313#issue-128754131

(require 'package)
(customize-set-variable 'package-archives
                        '(("org" . "http://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Ensure org-plus-contrib is installed to preempt the bundled
;; org-mode. Don't load it yet, in case we prefer to include a more
;; updated version on the load-path
(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

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

;; Load custom-file now, before any other configurations, to try and
;; prevent it from clobbering other settings
(load custom-file t)

;; Initialize and configure core packages:
;; use-package, evil, general, which-key, hydra

;; use-package
(require 'use-package)
(require 'bind-key)
(customize-set-variable 'use-package-always-ensure t)
(customize-set-variable 'use-package-verbose t)

;; evil
(use-package evil
  :custom
  (evil-overriding-maps nil)
  (evil-intercept-maps nil)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil)            ;allow org-mode TAB in terminal
  (evil-symbol-word-search t)
  (evil-respect-visual-line-mode t)
  ;; make emacs- and insert-states identical
  (evil-disable-insert-state-bindings t)
  (evil-undo-system 'undo-redo)
  :config
  ;; get rid of motion state everywhere
  (defalias 'evil-motion-state 'evil-insert-state)
  ;; get rid of emacs state nearly everywhere
  (mapc (lambda (mode) (evil-set-initial-state mode 'insert))
        evil-emacs-state-modes)
  ;; set special states to insert mode
  (evil-set-initial-state 'special-mode 'insert)
  (evil-set-initial-state 'image-mode 'insert)
  (evil-set-initial-state 'dired-mode 'insert)
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
  :bind (:map help-map
              ("y" . which-key-show-top-level))
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
    "qq" 'save-buffers-kill-emacs
    "h" '(:keymap help-map :which-key "Help")
    "r" '(:keymap ctl-x-r-map :which-key "Registers/Rectangles")
    "x" '(:keymap ctl-x-map :which-key "C-x")
    ;; simulate key instead of using keymap, for sake of kmacro-bind-to-key
    "k" (general-simulate-key "C-x C-k" :which-key "Keyboard macros")
    "c" (general-simulate-key "C-c C-c"))

  (general-create-definer my-major-leader
    :prefix "C-c m")

  (general-define-key
   :states '(normal motion visual)
   "_" 'universal-argument))

;; hydra
(use-package hydra)
(use-package hercules)

(setq my-completing-read-style 'hybrid)
;;(setq my-completing-read-style 'builtin)
;;(setq my-completing-read-style 'helm)
;;(setq my-completing-read-style 'ivy)

(mapc 'load
      (list
       ;; completion system (helm, ivy, ido)
       "my-completing-read"

       "my-buffers-files" ;includes dired, diff'ing
       "my-windows-frames"
       "my-lines-regions" ;line numbers/wrapping, parens, narrowing, etc
       "my-motions-jumping" ;avy, easymotion
       "my-search-replace" ;grep, swiper/swoop, iedit/mc
       "my-history-vc-undo" ;git, undo

       "my-themes-toggles"
       ))

;; Load additional configurations in ~/.my-emacs.el. Typically, this
;; should file should include a line like
;;
;; (load "my-config")
;;
;; unless desiring a minimal install

(load "~/.my-emacs.el" t)
