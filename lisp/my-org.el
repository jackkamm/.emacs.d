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
  :bind
  (:map org-mode-map
        ("C-c $" . org-archive-subtree-default))
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

  (org-archive-default-command 'org-archive-to-archive-sibling)

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
  (add-hook 'org-agenda-mode-hook
            (lambda () (toggle-truncate-lines -1)))
  ;; Use relative visual line numbers to account for folding
  (add-hook 'org-mode-hook
            (lambda () (setq-local display-line-numbers-type 'visual)))

  ;; Agenda, refile, and capture
  (add-to-list 'org-agenda-files "~/org")
  (add-to-list 'org-agenda-files "~/org/old" t)

  (defun my-org-refile-targets ()
    (directory-files "~/org" t org-agenda-file-regexp))
  (setq org-refile-targets '((my-org-refile-targets :maxlevel . 1)))

  (setq org-capture-templates
        '(("l" "link" entry (file "inbox.org")
           "* %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
          ("n" "note" entry (file "inbox.org")
           "* %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")))

  ;; allow \includesvg in latex export
  ;; https://emacs-orgmode.gnu.narkive.com/TnHAVxbF/o-how-to-handle-svg-files-when-exporting-orgmode-to-html-and-pdf
  (with-eval-after-load 'ox-latex
    (setq org-latex-pdf-process
          (mapcar (lambda (x)
                    (replace-regexp-in-string
                     "\%latex" "%latex --shell-escape" x))
                  org-latex-pdf-process)))

  ;; ediff
  ;; https://emacs.stackexchange.com/questions/21335/prevent-folding-org-files-opened-by-ediff
  (defun my-org-ediff-hook ()
    (when (eql major-mode 'org-mode)
      (org-show-all)
      (when org-inline-image-overlays
        (org-toggle-inline-images))))
  (add-hook 'ediff-prepare-buffer-hook 'my-org-ediff-hook)

  ;; bind major keys
  (my-major-leader
    :keymaps 'org-mode-map
    "r" 'org-redisplay-inline-images
    "t" 'org-toggle-inline-images
    "e" 'org-export-dispatch
    ;; C-c C-, can't be typed in a terminal
    "," 'org-insert-structure-template))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook 'evil-org-set-key-theme))

(use-package orgit :after (org magit))

;; TODO autoload
(use-package zotxt
  :config
  (add-hook 'org-mode-hook 'org-zotxt-mode))
