;; org-plus-contrib
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(use-package org
  :ensure org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  :general
  (my-leader
    "o" '(:ignore t :which-key "org")
    "ol" 'org-store-link
    "oc" 'org-capture
    "oa" 'org-agenda)
  :init
  (setq org-return-follows-link t)
  :config
  (my-major-leader
    :keymaps 'org-mode-map
    "r" 'org-redisplay-inline-images
    "l" 'org-insert-link
    "m" 'org-ctrl-c-ctrl-c)
  (setq org-agenda-files (list "~/Dropbox/org/agenda.org"))
  (setq org-capture-templates
	'(("t" "todo" entry (file "~/Dropbox/org/agenda.org")
	   "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n"
	   :prepend t))))

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
