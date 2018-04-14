;; org-plus-contrib
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(use-package org
  :ensure org-plus-contrib
  :mode "\\.org\\'"
  :commands (org-agenda org-capture)
  :config
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
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

