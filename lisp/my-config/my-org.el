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
  ;(setq org-image-actual-width nil)
  ;; https://stackoverflow.com/a/35261577
  (add-to-list 'image-type-file-name-regexps '("\\.pdf\\'" . imagemagick))
  (add-to-list 'image-file-name-extensions "pdf")
  (setq imagemagick-types-inhibit (remove 'PDF imagemagick-types-inhibit))
  (setq org-image-actual-width 600)
  :config
  (setq org-agenda-files (list "~/Dropbox/org-files/old-agenda.org"
			       "~/Dropbox/org-files/notes.org"
			       "~/Dropbox/org-files/todo.org"
			       "~/Dropbox/org-files/gmail-calendar.org"
			       "~/Dropbox/org-files/czb-calendar.org"
			       "~/Dropbox/org-files/calendar.org"))
  (setq org-agenda-start-on-weekday nil)
  (setq org-capture-templates
	'(("t" "todo" entry (file "~/Dropbox/org-files/todo.org")
	   "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
	  ("c" "calendar" entry (file "~/Dropbox/org-files/calendar.org")
	   "* %?\n  %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

  (add-hook 'org-mode-hook (lambda () (setq evil-auto-indent nil)))

  ;;; org-babel

  (setq org-confirm-babel-evaluate nil)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (python . t)
     (emacs-lisp . t)
     (shell . t)
     (ipython . t)))

  ;; macro for "C-c ' C-c c m b C-c '"
  ;; open block (C-c '), eval buffer (C-c c m b), close block (C-c ')
  ;; assumes convention (C-c c m b) to eval buffer across modes
  (fset 'my-babel-async-eval-session
	(lambda (&optional arg) "Keyboard macro." (interactive "p")
	  (kmacro-exec-ring-item
	   (quote ("'cmb'" 0 "%d")) arg)))

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
    "t" 'org-toggle-inline-images))

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



