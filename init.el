;; Start emacs server
(require 'server)
(unless (server-running-p) (server-start))

;; Add lisp files to load path
(push (concat user-emacs-directory "lisp") load-path)

(let ((default-directory (concat user-emacs-directory "site-lisp/")))
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

;; Set and load custom-file as early as possible, to prevent Custom
;; writing to init.el, and to avoid overriding other settings
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file t)

;; Initialize package and use-package

(require 'package)

(customize-set-variable 'package-archives
                        '(("melpa" . "https://melpa.org/packages/")
                          ("gnu" . "https://elpa.gnu.org/packages/")
                          ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(customize-set-variable 'use-package-always-ensure t)
(customize-set-variable 'use-package-always-defer t)

;; Profiling variables
;; See also: M-x emacs-init-time
(customize-set-variable 'use-package-verbose t)
;;(customize-set-variable 'use-package-minimum-reported-time .01)

(require 'use-package)
(require 'bind-key)

;; Load modules for my minimal config

(require 'my-evil)
(require 'my-keymaps)

;; TODO: Replace with load with require
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
       "my-send-insert" ;insert and send special text

       "my-themes-toggles"
       ))

;; Security: Clear the keylog after entering passwords
;;
;; TODO: Submit this as a security bug to Emacs? They already know
;; about cominit-send-invisible, but the help for read-passwd doesn't
;; mention this issue, and it is affected as well

(defun my-clear-keylog (&rest r)
  "Advice to fix security bug in `comint-send-invisible', as of emacs27.

In particular, the help for `comint-send-invisible' says:
Security bug: your string can still be temporarily recovered with
C-h l; ‘clear-this-command-keys’ can fix that."
  (clear-this-command-keys))

(advice-add #'comint-send-invisible :after #'my-clear-keylog)
(advice-add #'read-passwd :after #'my-clear-keylog)

;; Load additional configurations in config.el. If it doesn't exist,
;; create it from a template

(let ((config-el (concat user-emacs-directory "config.el"))
      (template (concat user-emacs-directory "config-template.el")))
  (unless (file-exists-p config-el)
    (copy-file template config-el))
  (load config-el))

;; Additional customizations automatically added by Emacs

(put 'upcase-region 'disabled nil)
