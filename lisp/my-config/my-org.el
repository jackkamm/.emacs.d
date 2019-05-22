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
  :custom
  (org-return-follows-link t)
  (org-tags-column 0)
  (org-agenda-tags-column 0)

  ;; https://yiufung.net/post/org-mode-hidden-gems-pt1/
  (org-catch-invisible-edits 'show-and-error)
  (org-cycle-separator-lines 0)

  (org-deadline-warning-days 30)
  (org-agenda-start-on-weekday nil)

  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  ;;(org-goto-interface 'outline-path-completion)

  ;; NOTE org-reverse-note-order is bugged: if file starts with
  ;; section header, refiling to top-level is incorrectly inserted
  ;; TODO minimal reproducible example + bug report
  ;; (org-reverse-note-order t)
  :config
  ;; Indentation
  (setq org-adapt-indentation nil)
  (add-hook 'org-mode-hook (lambda () (setq evil-auto-indent nil)))

  ;; Truncate long lines so tables aren't misaligned
  (add-hook 'org-mode-hook
            (lambda () (toggle-truncate-lines 1)))
  ;; Use relative visual line numbers to account for folding
  (add-hook 'org-mode-hook
            (lambda () (setq-local display-line-numbers-type 'visual)))

  ;; Agenda, refile, and capture

  (setq org-agenda-files '("~/org" "~/org/old" "~/org/sorted"))

  (defun my-org-refile-targets ()
    (directory-files "~/org/sorted" t org-agenda-file-regexp))
  (setq org-refile-targets '((my-org-refile-targets :maxlevel . 1)))

  (setq org-capture-templates
        '(("l" "link" entry (file "notes.org")
           "* %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
          ("n" "note" entry (file "notes.org")
           "* %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")))

  ;; allow \includesvg in latex export
  ;; https://emacs-orgmode.gnu.narkive.com/TnHAVxbF/o-how-to-handle-svg-files-when-exporting-orgmode-to-html-and-pdf
  (with-eval-after-load 'ox-latex
    (setq org-latex-pdf-process
          (mapcar (lambda (x)
                    (replace-regexp-in-string
                     "\%latex" "%latex --shell-escape" x))
                  org-latex-pdf-process)))

  ;;; bind major keys
  (my-major-leader
    :keymaps 'org-mode-map
    "r" 'org-redisplay-inline-images
    "t" 'org-toggle-inline-images
    "e" 'org-export-dispatch
    "n" 'org-babel-next-src-block
    "p" 'org-babel-previous-src-block
    ;; C-c C-, can't be typed in a terminal
    "," 'org-insert-structure-template))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook 'evil-org-set-key-theme))

(use-package orgit :after (org magit))
