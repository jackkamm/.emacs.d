(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode)
  :general
  (my-leader
    "o" '(:ignore t :which-key "Org")
    "ol" 'org-store-link
    "ob" 'org-revert-all-org-buffers
    "oc" 'org-capture
    "oa" 'org-agenda)
  :custom
  (org-fontify-done-headline nil)
  (org-return-follows-link t)
  (org-tags-column 0)
  (org-agenda-tags-column 0)
  (org-src-window-setup 'plain)
  ;;(org-table-header-line-p t)
  (org-display-remote-inline-images 'cache)

  ;; https://yiufung.net/post/org-mode-hidden-gems-pt1/
  (org-catch-invisible-edits 'show-and-error)
  (org-cycle-separator-lines 0)

  (org-deadline-warning-days 30)
  (org-agenda-start-on-weekday nil)

  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  ;;(org-goto-interface 'outline-path-completion)

  ;; to resize inline images
  (org-image-actual-width nil)

  ;; NOTE org-reverse-note-order is bugged: if file starts with
  ;; section header, refiling to top-level is incorrectly inserted
  ;; TODO minimal reproducible example + bug report
  ;; (org-reverse-note-order t)
  :config
  ;; Indentation
  (customize-set-variable 'org-adapt-indentation nil)
  (add-hook 'org-mode-hook (lambda () (setq evil-auto-indent nil)))

  ;; Truncate long lines so tables aren't misaligned
  (add-hook 'org-mode-hook
            (lambda () (toggle-truncate-lines 1)))
  (add-hook 'org-agenda-mode-hook
            (lambda () (toggle-truncate-lines -1)))
  ;; Use relative visual line numbers to account for folding
  (add-hook 'org-mode-hook
            (lambda () (setq-local display-line-numbers-type 'visual)))

  ;; Agenda, refile, capture, archive
  (add-to-list 'org-agenda-files "~/org")

  (customize-set-variable 'org-clock-idle-time 10)

  (customize-set-variable
   'org-refile-targets
   '((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9)))

  (customize-set-variable
   'org-capture-templates
   '(("c" "capture" entry (file "inbox.org")
      "* %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

  ;; allows bibtex and \includesvg in latex export
  (with-eval-after-load 'ox-latex
    (customize-set-variable 'org-latex-pdf-process
          (list "latexmk -shell-escape -bibtex -f -pdf %f")))

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
    "a" 'org-archive-to-archive-sibling
    ;; C-c C-, can't be typed in a terminal
    "," 'org-insert-structure-template))

;;; Load modules distributed with org-mode, that need to be loaded
;;; separately. Could alternatively use `require' or `org-modules',
;;; but "we should get rid of org-modules altogether now that Emacs
;;; has a packaging system"
;;; (https://lists.gnu.org/archive/html/emacs-orgmode/2020-02/msg00714.html)

(use-package ol-notmuch
  :ensure nil
  :after org)

;; TODO: remove after fixing C-c C-, display-buffer issues
(use-package org-tempo
  :ensure nil
  :after org)

;;; Load packages related to org-mode

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook 'evil-org-set-key-theme))

(use-package org-gcal
  :commands (org-gcal-fetch
             org-gcal-sync)
  :load-path "~/.emacs.d/lisp/org-gcal.el"
  :general
  (my-leader
    "og" 'org-gcal-fetch))

(use-package orgit :after (org magit))

(use-package zotxt
  :hook (org-mode . org-zotxt-mode))

(use-package org-ref
  :after org
  :config
  (setq reftex-default-bibliography '("~/Documents/bibliography/zotero.bib"))

  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes "~/Documents/bibliography/notes.org"
        org-ref-default-bibliography '("~/Documents/bibliography/zotero.bib")
        org-ref-pdf-directory "~/Documents/bibliography/bibtex-pdfs/"))

(use-package ox-reveal :after org)

(use-package org-present
  :commands org-present)

(with-eval-after-load "my-helm"
  (use-package helm-org-rifle
    :general
    (my-leader
      "os" 'helm-org-rifle)
    :config
    ;; Needed to avoid the error (void-function org-get-outline-path)
    ;; TODO file an issue with helm-org-rifle
    (require 'org-refile)))
