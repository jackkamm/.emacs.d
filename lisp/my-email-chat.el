;; Chat

(use-package erc
  :commands erc
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
(use-package ix :commands ix)

;; Mail

(setq message-send-mail-function 'message-send-mail-with-sendmail
      message-make-forward-subject-function 'message-forward-subject-fwd
      ;; autopopulate From: in notmuch messages
      ;; https://notmuchmail.org/emacstips/#index11h2
      mail-specify-envelope-from t
      message-sendmail-envelope-from 'header
      mail-envelope-from 'header)

(add-hook 'message-mode-hook 'flyspell-mode)
(add-hook 'message-mode-hook 'turn-off-auto-fill)
(add-hook 'message-mode-hook 'visual-line-mode)

(use-package notmuch
  :general
  (my-leader "an" 'notmuch)
  :init
  ;; load config for browse-url-mail, used by x-scheme-handler/mailto
  (with-eval-after-load 'browse-url (require 'notmuch))
  :config
  (setq notmuch-search-oldest-first nil
        notmuch-wash-wrap-lines-length 80
        notmuch-mua-compose-in 'new-window)

  (add-hook 'notmuch-show-mode-hook 'visual-line-mode)
  (add-hook 'notmuch-mua-send-hook 'notmuch-mua-attachment-check)

  ;; TODO: submit this functionality to notmuch?
  (defun my-notmuch-search-filter-jump ()
    (interactive)
    (let ((notmuch-saved-searches
           (mapcar (lambda (saved-search)
                     (plist-put (copy-seq saved-search) :query
                                (concat (notmuch-group-disjunctive-query-string
                                         (plist-get saved-search :query))
                                        " and "
                                        (notmuch-group-disjunctive-query-string
                                         (notmuch-search-get-query)))))
                   notmuch-saved-searches)))
      (notmuch-jump-search)))
  (bind-keys :map notmuch-search-mode-map
             ("J" . my-notmuch-search-filter-jump)))

(use-package org-notmuch
  :ensure org-plus-contrib
  :after (org notmuch))

(use-package gnus
  :defer t
  :commands gnus
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
  ;; No primary server
  (setq gnus-select-method '(nnnil "")))
