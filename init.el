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
(setq custom-file (concat user-emacs-directory "my-custom.el"))
(load custom-file t)

;; Initialize package and use-package

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-always-defer t)

;; Profiling variables
;; See also: M-x emacs-init-time
(setq use-package-verbose t)
;;(setq use-package-minimum-reported-time .01)

(require 'use-package)
(require 'bind-key)

;; Load modules for my minimal config

(require 'my-evil)
(require 'my-keymaps)

;; completion system (helm, ivy, ido)
(require 'my-completing-read)

(require 'my-buffers-files) ;includes dired, diff'ing
(require 'my-windows-frames)
(require 'my-lines-regions) ;line numbers/wrapping, parens, narrowing, etc
(require 'my-motions-jumping) ;avy, easymotion
(require 'my-search-replace) ;grep, swiper/swoop, iedit/mc
(require 'my-history-vc-undo) ;git, undo
(require 'my-send-insert) ;insert and send special text

(require 'my-themes-toggles)

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

;; see also "--allow-loopback-pinentry" in "man gpg-agent". Seems to be
;; enabled by default, but if not, set it in gpg-agent.conf
;; https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
(setq epg-pinentry-mode 'loopback)

;; Load additional configurations in config.el. If it doesn't exist,
;; create it from a template

(let ((config-el (concat user-emacs-directory "config.el"))
      (template (concat user-emacs-directory "config-template.el")))
  (unless (file-exists-p config-el)
    (copy-file template config-el))
  (load config-el))

;; Additional customizations automatically added by Emacs

(put 'upcase-region 'disabled nil)
