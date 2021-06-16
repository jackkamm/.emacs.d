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
  (org-image-actual-width '(750))

  (org-log-done 'time)
  (org-agenda-start-with-log-mode t)

  ;; remove scheduled/deadline items from Todo view, since they will
  ;; appear in Agenda view. Especially useful for repeating items.
  (org-agenda-todo-ignore-scheduled t)
  (org-agenda-todo-ignore-deadlines 'far)

  ;; make the todo list shorter by skipping sublevels
  (org-agenda-todo-list-sublevels nil)

  ;; C-TAB doesn't work in terminal, and org-force-cycle-archived
  ;; doesn't play nice with general-simulate-key
  (org-cycle-open-archived-trees t)

  ;; turn on org-indent-mode
  ;;(org-startup-indented t)

  (org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

  (org-todo-keywords '((sequence "IDEA" "PEND" "TODO" "|" "DONE" "WONT" "STALE")))
  ;; Colors inspired from `hl-todo-keyword-faces'
  (org-todo-keyword-faces '(("IDEA" . (:weight bold :foreground "#7cb8bb"))
                            ("PEND" . (:weight bold :foreground "#d0bf8f"))
                            ("WONT" . (:weight bold :foreground "#8c5353"))))
  (org-todo-repeat-to-state "TODO")

  (org-agenda-custom-commands
   '(("n" "Agenda and active TODOs"
      ((agenda "")
       (todo "TODO")))))

  ;; NOTE org-reverse-note-order is bugged: if file starts with
  ;; section header, refiling to top-level is incorrectly inserted
  ;; TODO minimal reproducible example + bug report
  ;; (org-reverse-note-order t)
  :init
  ;; TODO implement this functionality via a prefix argument instead?
  (defun my-org-store-link-no-id ()
    (interactive)
    (let (org-id-link-to-org-use-id)
      (call-interactively 'org-store-link)))

  (defun my-org-set-created ()
    (interactive)
    (org-set-property "CREATED" (format-time-string "[%Y-%m-%d]")))
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
  
  ;; Following `org-sort-entries', the creation time is assumed to be
  ;; the first inactive timestamp at the beginning of a line
  (customize-set-variable
   'org-capture-templates
   '(("n" "note" entry (file+function "diary.org" my-org-capture-iso-week-fun)
      "* %?\n%u" :empty-lines 1 :jump-to-captured t :tree-type week)
     ("l" "link" entry (file+function "diary.org" my-org-capture-iso-week-fun)
      "* %?%:subject\n%u\n\n%a" :empty-lines 1 :tree-type week)))

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

  ;; bind major keys
  (my-major-leader
    :keymaps 'org-mode-map
    "r" 'org-redisplay-inline-images
    "t" 'org-toggle-inline-images
    "e" 'org-export-dispatch
    "a" 'org-archive-to-archive-sibling
    ;; C-c C-, can't be typed in terminal
    "," 'org-insert-structure-template)

  ;; self-contained html export
  ;; https://www.reddit.com/r/orgmode/comments/7dyywu/creating_a_selfcontained_html/
  ;; TODO: submit to org-mode
  (defun org-html--format-image (source attributes info)
    (format "<img src=\"data:image/%s;base64,%s\"%s />"
            (or (file-name-extension source) "")
            (base64-encode-string
             (with-temp-buffer
	       (insert-file-contents-literally source)
	       (buffer-string)))
            (file-name-nondirectory source)))

  ;; Load modules distributed with org-mode, that need to be loaded
  ;; separately. Could alternatively use `require' or `org-modules',
  ;; but "we should get rid of org-modules altogether now that Emacs
  ;; has a packaging system"
  ;; (https://lists.gnu.org/archive/html/emacs-orgmode/2020-02/msg00714.html)

  (require 'ol-notmuch)
  (require 'org-id)
  ;; TODO: remove after fixing C-c C-, display-buffer issues
  (require 'org-tempo))

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
