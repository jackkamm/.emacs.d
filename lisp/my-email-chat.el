;; Chat

(use-package erc
  :ensure nil
  :config
  (add-to-list 'erc-modules 'notifications))

(defun my-irc (tunnelp)
  (interactive
   (list (y-or-n-p "Open tunnel?")))
  (when tunnelp
    (start-process "*autossh weechat*" "*autossh weechat*"
                   "autossh" "-M" "0" "-o" "ServerAliveInterval 45" "-o"
                   "ServerAliveCountMax 2"  "-L" "9000:localhost:9000" "weechat")
    (sleep-for 2))
  (erc :server "localhost" :port "9000" :nick "snackattack"))
(my-leader "ai" 'my-irc)

;; pastebin for IRC
(use-package ix)

;; Mail

(setq message-send-mail-function 'message-send-mail-with-sendmail
      message-make-forward-subject-function 'message-forward-subject-fwd
      ;; autopopulate From: in notmuch messages
      ;; https://notmuchmail.org/emacstips/#index11h2
      mail-specify-envelope-from t
      message-sendmail-envelope-from 'header
      mail-envelope-from 'header
      message-directory "~/mail")

(add-hook 'message-mode-hook 'flyspell-mode)
(add-hook 'message-mode-hook 'turn-off-auto-fill)
(add-hook 'message-mode-hook 'visual-line-mode)

;; https://emacs.stackexchange.com/questions/41175/how-to-warn-before-sending-email-if-subject-is-empty
(defun my-confirm-empty-subject ()
  "Allow user to quit when current message subject is empty."
  (or (message-field-value "Subject")
      (yes-or-no-p "Really send without Subject? ")
      (keyboard-quit)))

(use-package notmuch
  ;; https://notmuchmail.org/notmuch-emacs/ recommends against
  ;; installing notmuch.el from ELPA. However, it's sometimes
  ;; necessary, e.g. when using notmuch remotely.
  ;; TODO: make a defvar to control this.
  ;;:ensure nil
  :general
  (my-leader "an" 'notmuch)
  :custom
  (notmuch-search-oldest-first nil)
  (notmuch-wash-wrap-lines-length 80)
  (notmuch-mua-compose-in 'new-window)
  (notmuch-always-prompt-for-sender t)
  :init
  ;; load config for browse-url-mail, used by x-scheme-handler/mailto
  (with-eval-after-load 'browse-url (require 'notmuch))
  :config
  (add-hook 'notmuch-show-mode-hook 'visual-line-mode)
  (add-hook 'notmuch-mua-send-hook 'notmuch-mua-attachment-check)
  (add-hook 'notmuch-mua-send-hook 'my-confirm-empty-subject)
  (add-hook 'notmuch-hello-mode-hook (lambda () (display-line-numbers-mode -1)))

  ;; workaround: `notmuch-read-query' ignores `completion-category-defaults'
  ;; TODO: submit fix to notmuch? cf "Programmed Completion" Info,
  ;; keywords "metadata","category". Challenge:
  ;; `completion-table-dynamic' doesn't permit setting metadata.
  (defun my-notmuch-read-query-advice (oldfun prompt)
    (let ((completion-styles '(substring)))
      (funcall oldfun prompt)))
  (advice-add 'notmuch-read-query :around 'my-notmuch-read-query-advice)

  ;; originally based on `notmuch-jump-search'
  ;; TODO: submit this functionality to notmuch?
  (defun my-notmuch-search-filter-jump (negate)
    (interactive "P")
    (let (action-map)
    (dolist (saved-search notmuch-saved-searches)
      (let* ((saved-search (notmuch-hello-saved-search-to-plist saved-search))
	     (key (plist-get saved-search :key)))
	(when key
	  (let ((name (plist-get saved-search :name))
		(query (plist-get saved-search :query)))
	    (push
             (list key name
                   `(lambda ()
                      (notmuch-search-filter
                       ',(if negate
                             (concat "not "
                                     (notmuch-group-disjunctive-query-string
                                      query))
                           query))))
             action-map)))))
    (setq action-map (nreverse action-map))
    (notmuch-jump action-map "Filter: ")))
  (bind-keys :map notmuch-show-mode-map
             ("a" . nil)
             ("x" . nil))
  (bind-keys :map notmuch-search-mode-map
             ("L" . my-notmuch-search-filter-jump)
             ("a" . nil)
             ("x" . nil))
  (bind-keys :map notmuch-tree-mode-map
             ("a" . nil)
             ("x" . nil)))

(use-package ol-notmuch :after (org notmuch))

(use-package gnus
  :ensure nil
  :general
  (my-leader "ag" 'gnus)
  :init
  ;; Configurations taken from spacemacs
  (setq
   ;;gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B (%c) %s%)\n"
   ;;gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
   ;;gnus-group-line-format "%M%S%p%P%5y:%B %G\n";;"%B%(%g%)"
   gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
   gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date))
  :config
  (setq gnus-summary-next-group-on-exit nil)
  ;; No primary server
  (setq gnus-select-method '(nnnil "")))
