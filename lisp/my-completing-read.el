;;; my-completing-read.el --- completing-read setup  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; helm

(use-package helm
  :init
  (setq helm-split-window-default-side 'other
        helm-buffer-skip-remote-checking t)

  :config
  (require 'helm-config)

  (bind-keys :map helm-map
             ("C-<backspace>" . helm-delete-minibuffer-contents)
             ("<tab>" . helm-execute-persistent-action)
             ("C-i" . helm-execute-persistent-action)
             ("M-o" . helm-select-action))

  (with-eval-after-load 'helm-files
    (dolist (m (list helm-find-files-map
                     helm-read-file-map))
      (bind-keys :map m
                 ("C-<backspace>" . helm-find-files-up-one-level)
                 ("<left>" . backward-char)
                 ("<right>" . forward-char)))))

(use-package helm-projectile)

;; ivy

(use-package ivy
  :init
  (setq ivy-use-selectable-prompt t)
  (setq ivy-re-builders-alist
	'((t . ivy--regex-ignore-order)))
  (setq ivy-use-virtual-buffers t))

(use-package swiper)

(use-package ivy-hydra :after ivy :demand t)

(use-package counsel
  :config
  ;; override shadowing of yank-pop, since counsel-yank-pop doesn't
  ;; work in minibuffer
  (define-key counsel-mode-map [remap yank-pop] nil))

(use-package counsel-projectile)

(use-package ivy-prescient
  :after ivy
  :demand t)

;; icomplete

(use-package icomplete
  :ensure nil
  :bind (:map icomplete-minibuffer-map
              ("RET" . icomplete-force-complete-and-exit)
              ("M-j" . exit-minibuffer)
              ;; Replacement for M-TAB which might be intercepted by the OS
              ("TAB" . icomplete-force-complete)
              ;; default C-, and C-. bindings may not work in terminal
              ("<down>" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("<up>" . icomplete-backward-completions)
              ("C-p" . icomplete-backward-completions)))

;; provides helm-style completion for icomplete. Though helm provides
;; an implementation for `completion-styles-alist', it is incomplete,
;; in particular `helm-completion-try-completion' is not properly
;; implemented. `orderless' provides a full working implementation.
(use-package orderless)

(use-package icomplete-vertical
  :bind (:map icomplete-minibuffer-map
              ("C-v" . icomplete-vertical-toggle))
  :demand t)

(use-package selectrum
  :init
  (setq selectrum-display-style '(horizontal)
        ;; for better behavior when moving files with dired-dwim-target
        selectrum-files-select-input-dirs t))

;; activate preferred completion system

(setq my-completing-read-style 'selectrum)
;;(setq my-completing-read-style 'hybrid)
;;(setq my-completing-read-style 'builtin)
;;(setq my-completing-read-style 'helm)
;;(setq my-completing-read-style 'ivy)

(pcase my-completing-read-style
  (`helm
   (helm-mode 1)
   (my-leader
     "R" 'helm-resume
     "Y" 'helm-show-kill-ring)
   (global-set-key (kbd "M-x") 'helm-M-x)
   (bind-keys :map help-map
              ("a" . helm-apropos)
              ("i" . helm-info)))
  (`ivy
   (ivy-mode 1)
   (counsel-mode 1)
   (my-leader
     "R" 'ivy-resume
     "Y" 'counsel-yank-pop)
   (ivy-prescient-mode))
  (`selectrum
   (setq completion-styles '(orderless))
   (selectrum-mode +1))
  ((or `hybrid `builtin)
   (setq completion-styles '(orderless))
   (setq completion-category-defaults nil)
   (setq completion-ignore-case t)
   (setq read-buffer-completion-ignore-case t)
   (setq read-file-name-completion-ignore-case t)
   (icomplete-mode 1)))

;; The following option makes in-buffer completion a bit nicer,
;; avoiding the annoying pop-up buffer when there are 2 or more
;; completions. However, it messes up minibuffer completion when using
;; icomplete with the orderless completion style, which stops working
;; because SPC autocompletes.
;;
;; TODO: Find a way to re-enable this without messing up minibuffer
;; completion, or find a better solution.
;;
;; Perhaps this is relevant?
;; "Trying to understand 'icomplete-in-buffer'"
;; https://lists.gnu.org/archive/html/emacs-devel/2021-07/msg00004.html
;;
;;(setq completion-cycle-threshold t)

(provide 'my-completing-read)
;;; my-completing-read.el ends here

