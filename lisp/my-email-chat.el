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
                   "autossh" "-M" "0" "-o" "ServerAliveInterval 45" "-o" "ServerAliveCountMax 2"  "-L" "9000:localhost:9000" "weechat")
    (sleep-for 2))
  (erc :server "localhost" :port "9000" :nick "snackattack"))
(my-leader "ai" 'my-irc)

;; pastebin for IRC
(use-package ix :commands ix)

;; Mail

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq message-make-forward-subject-function 'message-forward-subject-fwd)

;; Send mail from the address specified in the From: header
;; https://notmuchmail.org/emacstips/#index11h2
;; NOTE: additional config needed to initially populate From:
;; notmuch does it automatically but gnus does not
(setq mail-specify-envelope-from t
      message-sendmail-envelope-from 'header
      mail-envelope-from 'header)

(use-package notmuch
  :general
  (my-leader "an" 'notmuch)
  :init
  ;; load config for browse-url-mail, used by x-scheme-handler/mailto
  (with-eval-after-load 'browse-url (require 'notmuch))
  :config
  (with-eval-after-load 'org
    (require 'org-notmuch))

  (add-hook 'notmuch-show-mode-hook
            (lambda () (toggle-truncate-lines -1)))

  (add-to-list 'notmuch-tagging-keys
               '("x" ("+killed" "-unread") "Kill thread"))

  ;; bind notmuch-help to leader
  (my-major-leader
    :keymaps 'notmuch-common-keymap
    "h" 'notmuch-help)

  (my-major-leader
    :keymaps 'notmuch-show-mode-map
    "f" 'notmuch-show-forward-message
    "r" 'notmuch-show-reply-sender
    "R" 'notmuch-show-reply)

  (setq notmuch-search-oldest-first nil
        notmuch-wash-wrap-lines-length 80
        notmuch-mua-compose-in 'new-window
        ;; ensures +sent (needed for some messages to self?)
        notmuch-fcc-dirs "sent +sent")

  (setq notmuch-saved-searches
        '((:name "inbox" :query "tag:inbox date:90d.." :key "i")
          (:name "sent" :query "tag:sent date:90d.." :key "t")
          (:name "unread" :key "u"
           :query "tag:unread AND (tag:inbox OR tag:to-me OR thread:{tag:flagged})")
          (:name "new-news" :key "n"
           :query "tag:unread NOT tag:inbox NOT subject:/^Re\\:/")
          (:name "old-news" :key "o"
           :query "tag:unread (NOT tag:inbox) subject:/^Re\\:/")))

  (add-hook 'notmuch-mua-send-hook 'notmuch-mua-attachment-check)

  (add-hook 'message-mode-hook 'flyspell-mode)
  ;; see discussion of line wrapping and format=flowed here:
  ;; https://github.com/legoscia/messages-are-flowing/issues/9#issuecomment-565504136
  (add-hook 'message-mode-hook 'turn-off-auto-fill)
  (add-hook 'message-mode-hook 'visual-line-mode))

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
