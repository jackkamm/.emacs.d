;; org-plus-contrib
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(use-package org
  :ensure org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  :general
  (my-leader
    "o" '(:ignore t :which-key "Org")
    "ol" 'org-store-link
    "oc" 'org-capture
    "oa" 'org-agenda)
  :init
  (setq org-return-follows-link t)
  :config
  (setq org-agenda-files (list "~/Dropbox/org/agenda.org"))
  (setq org-capture-templates
	'(("t" "todo" entry (file "~/Dropbox/org/agenda.org")
	   "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n"
	   :prepend t)))

  ;;; org-babel

  (setq org-confirm-babel-evaluate nil)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (python . t)
     (emacs-lisp . t)
     (shell . t)
     (ipython . t)))

  ;; macro for "C-c ' C-c m e b C-c '"
  ;; open block (C-c '), eval buffer (C-c m e b), close block (C-c ')
  ;; assumes convention (C-c m e b) to eval buffer across modes
  (fset 'my-babel-async-eval-session
	(lambda (&optional arg) "Keyboard macro." (interactive "p")
	  (kmacro-exec-ring-item
	   (quote ("'meb'" 0 "%d")) arg)))

  (with-eval-after-load 'hydra
    (defhydra my-babel-hydra ()
      "babel"
      ("n" org-babel-next-src-block "next")
      ("p" org-babel-previous-src-block "previous")
      ("s" my-babel-async-eval-session "send-session")
      ("x" org-babel-execute-maybe "execute")
      ("q" nil "quit")))

  ;;; bind major keys

  (my-major-leader
    :keymaps 'org-mode-map
    "b" 'my-babel-hydra/body
    "s" 'my-babel-async-eval-session
    "x" 'org-babel-execute-maybe
    "r" 'org-redisplay-inline-images
    "l" 'org-insert-link
    "m" 'org-ctrl-c-ctrl-c))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (evil-define-minor-mode-key 'motion 'evil-org-mode
    (kbd "RET") 'evil-org-return)
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package ob-ipython :defer t
  :config
  (with-eval-after-load 'popwin
    (push '("^\*ob-ipython-.+\*.+$"
	    :regexp t
	    :noselect t)
	  popwin:special-display-config)))



