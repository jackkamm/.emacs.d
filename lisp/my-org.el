;;; my-org.el --- Org config                         -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package org
  :ensure nil
  :general
  (my-leader
    "o" '(:ignore t :which-key "Org")
    "ol" 'org-store-link
    "oL" 'my-org-store-link-no-id
    "ob" 'org-revert-all-org-buffers
    "oc" 'org-capture
    "oa" 'org-agenda
    "oC" 'my-org-set-created)
  :custom
  ;; 2022-08-07: Agenda started freezing anytime I tried to load it,
  ;; even after restarting Emacs. Disabling cache persistence solved
  ;; it; the problem didn't come back even after re-enabling cache,
  ;; presumably because the bad cache state was cleared. See also the
  ;; comment in ORG-NEWS requesting help in testing this feature, and
  ;; the variables that can be set to aid debugging.
  ;;(org-element-cache-persistent nil)

  (org-fontify-done-headline nil)
  (org-return-follows-link t)
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
  ;;(org-image-actual-width '(500))
  (org-image-actual-width nil)

  ;; Always log the closing time, it's used by org-caldav
  (org-log-done 'time)
  ;; Log state changes into a drawer
  (org-log-into-drawer t)
  ;; Set this globally, bcuz it doesn't seem to work when setting in
  ;; org-agenda-custom-commands
  (org-agenda-start-with-log-mode t)

  ;; C-TAB doesn't work in terminal, and org-force-cycle-archived
  ;; doesn't play nice with general-simulate-key
  (org-cycle-open-archived-trees t)

  ;; turn on org-indent-mode
  ;;(org-startup-indented t)

  (org-enforce-todo-dependencies t)
  (org-agenda-dim-blocked-tasks nil)

  (org-todo-keywords '((sequence
                        "MOVE(m)" ;Inbox/Refile
                        "IDEA(i)" ;Idea
                        "PEND(n)" ;Holding state
                        "ITER(r/!)" ;Repeating task
                        "TODO(t)" ;Needs action
                        "NEXT(x)" ;On the docket
                        "PROG(g!)" ;In progress
                        "|"
                        "DONE(d)" ;Completed
                        "DUPE(u)" ;Duplicate
                        "FAIL(f)" ;Tried but failed
                        "OKAY(y)" ;Delegated or otherwise resolved
                        "PAST(a)" ;Stale/expired
                        "SKIP(k)" ;Skipping/cancelling
                        )))

  ;; Colors inspired from `hl-todo-keyword-faces'
  (org-todo-keyword-faces '(("NEXT" . (:weight bold :foreground "#dca3a3"))
                            ("PROG" . (:weight bold :foreground "#7cb8bb"))
                            ("IDEA" . (:weight bold :foreground "#7cb8bb"))
                            ("PEND" . (:weight bold :foreground "#d0bf8f"))
                            ("FAIL" . (:weight bold :foreground "#8c5353"))
                            ("OKAY" . (:weight bold :foreground "#7cb8bb"))
                            ("PAST" . (:weight bold :foreground "#dca3a3"))))
  (org-use-fast-todo-selection 'expert)
  (org-todo-repeat-to-state "ITER")

  (org-agenda-custom-commands
   '(("n" "Agenda and active TODOs"
      ((agenda "" ((org-agenda-log-mode-items '(closed clock state))))
       (todo "MOVE")
       (todo "PROG")
       (todo "NEXT")
       ;; List top-level tasks only. Use "alltodo" and a filter,
       ;; instead of (todo "TODO") which would exclude parent tasks in
       ;; other states (e.g. NEXT, PROG) from the sparse subtree,
       ;; preventing us from filtering them out.
       (alltodo "" ((org-agenda-overriding-header "Top-level TODOs")
                    ;;(org-agenda-todo-list-sublevels nil)
                    ;;(org-agenda-skip-function
                    ;;'(org-agenda-skip-subtree-if
                    ;;  'nottodo '("TODO" "NEXT" "PROG")))
                    (org-agenda-skip-function
                     '(my-agenda-skip-subtree-nottodo
                       '("TODO")))))))))

  ;; NOTE org-reverse-note-order is bugged: if file starts with
  ;; section header, refiling to top-level is incorrectly inserted
  ;; TODO minimal reproducible example + bug report
  ;; (org-reverse-note-order t)

  (org-startup-folded t)
  (org-icalendar-include-todo 'all)
  :init
  ;; TODO implement this functionality via a prefix argument instead?
  (defun my-org-store-link-no-id ()
    (interactive)
    (let (org-id-link-to-org-use-id)
      (call-interactively 'org-store-link)))

  (defun my-org-set-created ()
    (interactive)
    (org-set-property "CREATED" (format-time-string "[%Y-%m-%d]")))

  ;; Setting this with :custom no longer worked after org commit
  ;; 578d99b2aad1c5ec9bfbcb2da064cba367b48c30
  (customize-set-variable 'org-id-link-to-org-use-id
                          'create-if-interactive-and-no-custom-id)

  :config
  ;; Disable auto-indentation
  (customize-set-variable 'org-adapt-indentation nil)
  (add-hook 'org-mode-hook (lambda () (setq evil-auto-indent nil)))
  (add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))

  ;; Truncate long lines so tables aren't misaligned
  (add-hook 'org-mode-hook
            (lambda () (toggle-truncate-lines 1)))

  ;; Use relative visual line numbers to account for folding
  (add-hook 'org-mode-hook
            (lambda () (setq-local display-line-numbers-type 'visual)))

  ;; Line numbers in agenda may cause slight visual misalignments
  (add-hook 'org-agenda-mode-hook
               (lambda () (display-line-numbers-mode -1)))

  (customize-set-variable 'org-clock-idle-time 10)

  (customize-set-variable
   'org-refile-targets
   '((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9)))

  (defun my-org-capture-iso-week-fun ()
    (require 'org-datetree)
    (require 'cal-iso)
    (let* ((d (calendar-gregorian-from-absolute (org-today)))
           (year (calendar-extract-year d))
	   (month (calendar-extract-month d))
	   (day (calendar-extract-day d))
	   (time (encode-time 0 0 0 day month year))
	   (iso-date (calendar-iso-from-absolute
		      (calendar-absolute-from-gregorian d)))
	   (weekyear (nth 2 iso-date))
           (weekday (nth 1 iso-date))
	   (week (nth 0 iso-date))
           ;; NOTE: not an ISO standard
           (weekmonth (calendar-extract-month
                       ;; anchor on Thurs, to be consistent with weekyear
                       (calendar-gregorian-from-absolute
                        (calendar-iso-to-absolute `(,week 4 ,weekyear))))))
      (org-datetree--find-create
       "^\\*+[ \t]+\\([12][0-9]\\{3\\}\\)\\(\\s-*?\
\\([ \t]:[[:alnum:]:_@#%%]+:\\)?\\s-*$\\)"
       weekyear)
      (org-datetree--find-create
       "^\\*+[ \t]+%d-\\([01][0-9]\\) \\w+$"
       weekyear weekmonth)
      (org-datetree--find-create
       "^\\*+[ \t]+%d-W\\([0-5][0-9]\\)$"
       weekyear weekmonth week
       (format "%d-W%02d" weekyear week))))

  ;; org-goto works best in emacs/insert state. No hook available, so
  ;; use an advice.
  ;; TODO? Propose a patch to add a hook for org-goto
  (advice-add 'org-goto-location :before #'evil-execute-in-emacs-state)

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

  ;; Because shift-TAB doesn't work in screen
  (defhydra my-org-cycle-hydra ()
    "org-cycle"
    ;; NOTE should this be "<tab>" or "TAB"?
    ("TAB" org-global-cycle))

  ;; bind major keys
  (my-major-leader
    :keymaps 'org-mode-map
    "r" 'org-redisplay-inline-images
    "t" 'org-toggle-inline-images
    "e" 'org-export-dispatch
    "a" 'org-archive-to-archive-sibling
    "TAB" 'my-org-cycle-hydra/org-global-cycle
    ;; Alt bindings for keys that can't be typed in terminal
    "," 'org-insert-structure-template
    "h" 'org-metaleft
    "j" 'org-metadown
    "k" 'org-metaup
    "l" 'org-metaright
    "H" 'org-shiftmetaleft
    "J" 'org-shiftmetadown
    "K" 'org-shiftmetaup
    "L" 'org-shiftmetaright)

  ;; Load modules distributed with org-mode, that need to be loaded
  ;; separately. Could alternatively use `require' or `org-modules',
  ;; but "we should get rid of org-modules altogether now that Emacs
  ;; has a packaging system"
  ;; (https://lists.gnu.org/archive/html/emacs-orgmode/2020-02/msg00714.html)

  ;; Markdown export. Useful for Github (its default org exporter is
  ;; limited), or as input to pandoc --self-contained --to html.
  (require 'ox-md)

  (require 'org-id))

;; TODO: Also skip todo's with repeating timestamps? Can use
;; `org-get-repeat' to do that.
(defun my-agenda-skip-subtree-nottodo (kw-list)
  "Skip subtree if root keyword is not in KW-LIST.

This is very similar to using `org-agenda-skip-subtree-if' with
'nottodo, but the latter searches the entire subtree for the
keyword, not just the root entry."
  (let ((state (org-get-todo-state)))
    (unless (or (not state) (member state kw-list))
      (save-excursion (org-end-of-subtree t)))))

;;; Load packages related to org-mode

(use-package orgit
  :after (org magit) :demand t)

(use-package zotxt
  :hook (org-mode . org-zotxt-mode))

;;;; Not actively used, slow load time, unclear how to autoload.
;;;; helm-bibtex is an alternative, possibly more lightweight. Look
;;;; into it when needing this functionality again.
;;(use-package org-ref
;;  :after org
;;  :demand t
;;  :config
;;  (setq reftex-default-bibliography '("~/Documents/bibliography/zotero.bib"))
;;
;;  ;; see org-ref for use of these variables
;;  (setq org-ref-bibliography-notes "~/Documents/bibliography/notes.org"
;;        org-ref-default-bibliography '("~/Documents/bibliography/zotero.bib")
;;        org-ref-pdf-directory "~/Documents/bibliography/bibtex-pdfs/"))

;;;; Not actively used, slow loading, unclear how to autoload
;;(use-package ox-reveal
;;  :after org :demand t)

(use-package org-present)

(use-package helm-org-rifle
  :general
  (my-leader
    "os" 'helm-org-rifle)
  :config
  ;; Needed to avoid the error (void-function org-get-outline-path)
  ;; TODO file an issue with helm-org-rifle
  (require 'org-refile))

(use-package ox-html-selfcontained
  :after org
  :load-path (lambda () (concat user-emacs-directory "lisp/ox-html-selfcontained"))
  :ensure nil
  :demand t
  :config
  (ox-html-selfcontained-mode 1))

(provide 'my-org)
;;; my-org.el ends here
