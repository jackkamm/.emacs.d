(setq org-agenda-files (list "~/Dropbox/org/agenda.org"))
(setq org-capture-templates
    '(("t" "todo" entry (file "~/Dropbox/org/agenda.org")
       "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n"
       :prepend t)))
