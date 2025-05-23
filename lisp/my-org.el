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
  :init
  ;; 2022-08-07: Agenda started freezing anytime I tried to load it,
  ;; even after restarting Emacs. Disabling cache persistence solved
  ;; it; the problem didn't come back even after re-enabling cache,
  ;; presumably because the bad cache state was cleared. See also the
  ;; comment in ORG-NEWS requesting help in testing this feature, and
  ;; the variables that can be set to aid debugging.
  ;;(setq org-element-cache-persistent nil)

  (setq org-fontify-done-headline nil)
  (setq org-return-follows-link t)
  (setq org-src-window-setup 'plain)
  ;;(setq org-table-header-line-p t)
  (setq org-display-remote-inline-images 'cache)

  ;; https://yiufung.net/post/org-mode-hidden-gems-pt1/
  (setq org-catch-invisible-edits 'show-and-error)
  (setq org-cycle-separator-lines 0)

  (setq org-deadline-warning-days 30)
  (setq org-agenda-start-on-weekday nil)

  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  ;;(setq org-goto-interface 'outline-path-completion)

  ;; to resize inline images
  ;;(setq org-image-actual-width '(500))
  (setq org-image-actual-width nil)

  ;; Always log the closing time, it's used by org-caldav
  (setq org-log-done 'time)
  ;; Log state changes into a drawer
  (setq org-log-into-drawer t)

  ;; C-TAB doesn't work in terminal, and org-force-cycle-archived
  ;; doesn't play nice with general-simulate-key
  (setq org-cycle-open-archived-trees t)

  ;; turn on org-indent-mode
  ;;(setq org-startup-indented t)

  (setq org-enforce-todo-dependencies t)
  (setq org-agenda-dim-blocked-tasks nil)

  (setq org-todo-keywords '((sequence
                             "MOVE(m)" ;Inbox/Refile
                             "IDEA(i)" ;Idea
                             "PEND(n)" ;Holding state
                             "ITER(r)" ;Repeating task
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
  (setq org-todo-keyword-faces
        '(("MOVE" . (:weight bold :foreground "#8c5353"))
          ("NEXT" . (:weight bold :foreground "#dca3a3"))
          ("PROG" . (:weight bold :foreground "#7cb8bb"))
          ("IDEA" . (:weight bold :foreground "#7cb8bb"))
          ("PEND" . (:weight bold :foreground "#d0bf8f"))
          ("FAIL" . (:weight bold :foreground "#8c5353"))
          ("OKAY" . (:weight bold :foreground "#7cb8bb"))
          ("PAST" . (:weight bold :foreground "#dca3a3"))))

  (setq org-use-fast-todo-selection 'expert)
  (setq org-todo-repeat-to-state "ITER")

  (setq org-agenda-custom-commands
   '(("n" "Agenda and active TODOs"
      ((agenda "" ((org-agenda-overriding-header "Upcoming deadlines")
                   (org-agenda-entry-types '(:deadline))
                   (org-agenda-span 'day)
                   (org-agenda-sorting-strategy
                    '((agenda deadline-up priority-down)))
                   (org-deadline-warning-days -90)
                   (org-agenda-deadline-faces
                    '((1.0 . org-imminent-deadline)
                      (0.9 . org-upcoming-deadline)
                      (0.0 . org-upcoming-distant-deadline)))))
       (agenda "" ((org-deadline-warning-days 0)
                   ;; Use org-agenda-show-log bcuz
                   ;; org-agenda-start-with-log-mode is ignored in
                   ;; Custom commands. But note it prevents toggling
                   ;; the log-mode within this view.
                   ;; TODO: Submit patch to document this behavior in
                   ;; the docstrings of these vars?
                   ;;(org-agenda-show-log t)
                   ;;(org-agenda-start-with-log-mode t)
                   (org-agenda-sorting-strategy
                    '((agenda habit-down time-up priority-down scheduled-down)))
                   (org-agenda-log-mode-items '(closed clock state))))
       ;; List top-level tasks only. Use "alltodo" and a filter,
       ;; instead of (todo "TODO") which would exclude parent tasks in
       ;; other states (e.g. NEXT, PROG) from the sparse subtree,
       ;; preventing us from filtering them out.
       (alltodo "" ((org-agenda-overriding-header "Top-level TODOs")
                    (org-agenda-todo-list-sublevels nil)
                    ;;(org-agenda-skip-function
                    ;;'(org-agenda-skip-subtree-if
                    ;;  'nottodo '("TODO" "NEXT" "PROG")))
                    ;; FIXME: Is this needed since I set org-agenda-todo-list-sublevels?
                    (org-agenda-skip-function
                     '(my-agenda-skip-subtree-nottodo
                       '("TODO" "MOVE" "PROG" "NEXT")))
                    (org-agenda-sorting-strategy
                     '((todo urgency-down timestamp-down)))
                    (org-agenda-todo-ignore-scheduled 'all)
                    (org-agenda-todo-ignore-deadlines 'all)))
       (tags-todo "+HOLD")))
     ("d" "All deadlines" agenda "All deadlines in the next year"
      ((org-deadline-warning-days -360)
       (org-agenda-span 'day)
       (org-agenda-entry-types '(:deadline))
       (org-agenda-sorting-strategy
        '((agenda deadline-up priority-down)))))))

  ;; NOTE org-reverse-note-order is bugged: if file starts with
  ;; section header, refiling to top-level is incorrectly inserted
  ;; TODO minimal reproducible example + bug report
  ;; (org-reverse-note-order t)

  (setq org-startup-folded t)
  (setq org-icalendar-include-todo 'all)

  (setq org-image-max-width 'window)

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
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

  :config
  ;; Disable auto-indentation
  (setq org-adapt-indentation nil)
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

  (setq org-clock-idle-time 10)

  (setq org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))

  ;; org-goto works best in emacs/insert state. No hook available, so
  ;; use an advice.
  ;; TODO? Propose a patch to add a hook for org-goto
  (advice-add 'org-goto-location :before #'evil-execute-in-emacs-state)

  ;; allows bibtex and \includesvg in latex export
  (with-eval-after-load 'ox-latex
    (setq org-latex-pdf-process
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
    ;"r" 'org-redisplay-inline-images
    ;"t" 'org-toggle-inline-images
    ;; loads image in just the current heading
    "p" 'org-link-preview
    ;; loads images in whole buffer but might be slower
    "r" 'org-link-preview-refresh
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

  (require 'org-id)

  (require 'oc-bibtex)
  (require 'oc-natbib)

  (setq org-persist-remote-files nil))

;; TODO: Also skip todo's with repeating timestamps? Can use
;; `org-get-repeat' to do that.
(defun my-agenda-skip-subtree-nottodo (kw-list)
  "Skip subtree if root keyword is not in KW-LIST or if it has HOLD tag.

This is very similar to using `org-agenda-skip-subtree-if' with
'nottodo, but the latter searches the entire subtree for the
keyword, not just the root entry."
  (let ((state (org-get-todo-state))
        (tags (org-get-tags)))
    (when (or (member "HOLD" tags) ;HACK make this an argument instead of hardcoding?
              (not (and state (member state kw-list))))
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
