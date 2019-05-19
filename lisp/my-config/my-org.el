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
  (setq org-adapt-indentation nil)

  ;; https://yiufung.net/post/org-mode-hidden-gems-pt1/
  (setq org-catch-invisible-edits 'show-and-error)
  (setq org-cycle-separator-lines 0)

  (setq org-tags-column 0)

  (setq org-agenda-files '("~/org" "~/org/old" "~/org/sorted"))

  (defun my-org-refile-targets ()
    (directory-files "~/org/sorted" t org-agenda-file-regexp))
  (setq org-refile-targets '((my-org-refile-targets :maxlevel . 1)))

  (setq org-refile-use-outline-path 'file)
  ;;(setq org-goto-interface 'outline-path-completion)
  (setq org-outline-path-complete-in-steps nil)

  ;; NOTE don't use org-reverse-note-order because of bug!
  ;; when refiling to a top-level header, if the file starts with a section header, item gets filed incorrectly
  ;; TODO minimal reproducible example + bug report
  ;;(setq org-reverse-note-order t)

  (setq org-deadline-warning-days 30)
  (setq org-agenda-start-on-weekday nil)
  (setq org-capture-templates
        '(("l" "link" entry (file "notes.org")
           "* %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
          ("n" "note" entry (file "notes.org")
           "* %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")))

  (add-hook 'org-mode-hook (lambda () (setq evil-auto-indent nil)))

  ;; Truncate long lines so tables aren't misaligned
  (add-hook 'org-mode-hook
            (lambda () (toggle-truncate-lines 1)))
  ;; Use relative visual line numbers to account for folding
  (add-hook 'org-mode-hook
            (lambda () (setq-local display-line-numbers-type 'visual)))

  ;; allow \includesvg in latex export
  ;; https://emacs-orgmode.gnu.narkive.com/TnHAVxbF/o-how-to-handle-svg-files-when-exporting-orgmode-to-html-and-pdf
  (with-eval-after-load 'ox-latex
    (setq org-latex-pdf-process
          (mapcar (lambda (x)
                    (replace-regexp-in-string "\%latex" "%latex --shell-escape" x))
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

(use-package orgit
  :after magit)
