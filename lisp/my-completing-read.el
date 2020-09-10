;; helm

(use-package helm
  :custom
  (helm-split-window-default-side 'other)
  (helm-buffer-skip-remote-checking t)
  :commands helm-mode
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

(use-package helm-ag
  :commands (helm-ag
             helm-do-ag
             helm-ag-buffers
             helm-do-ag-buffers
             helm-do-grep-ag)
  :config
  (bind-keys :map helm-ag-mode-map
             ((kbd "<tab>") . helm-ag-mode-jump-other-window)))

(use-package helm-projectile
  :commands (helm-projectile-ag
             helm-projectile-find-file-dwim))

;; ivy

(use-package ivy
  :init
  (setq ivy-use-selectable-prompt t)
  (setq ivy-re-builders-alist
	'((t . ivy--regex-ignore-order)))
  (setq ivy-use-virtual-buffers t)
  :commands ivy-mode)

(use-package swiper
  :commands (swiper
             swiper-all
             swiper-from-isearch))

(use-package ivy-hydra :after ivy)

(use-package counsel
  :commands counsel-mode
  :config
  ;; override shadowing of yank-pop, since counsel-yank-pop doesn't
  ;; work in minibuffer
  (define-key counsel-mode-map [remap yank-pop] nil))

(use-package counsel-projectile
  :commands (counsel-projectile counsel-projectile-grep))

(use-package ivy-prescient
  :after ivy
  :commands ivy-prescient-mode)

;; icomplete

(use-package icomplete
  :custom
  (icomplete-tidy-shadowed-file-names t)
  ;;(icomplete-show-matches-on-no-input t)
  :bind (:map icomplete-minibuffer-map
              ("RET" . icomplete-fido-ret)
              ("M-j" . icomplete-fido-exit)
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

;; activate preferred completion system

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
  ((or `hybrid `builtin)
   (icomplete-mode 1)
   (customize-set-variable 'completion-styles '(orderless))
   (setq completion-category-defaults nil)
   (setq completion-ignore-case t)
   (customize-set-variable 'read-buffer-completion-ignore-case t)
   (customize-set-variable 'read-file-name-completion-ignore-case t)))
