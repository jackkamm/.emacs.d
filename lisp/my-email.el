(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq message-make-forward-subject-function 'message-forward-subject-fwd)

(use-package notmuch
  :general
  (my-leader
    "an" 'notmuch)
  :init
  ;; load config for browse-url-mail, used by x-scheme-handler/mailto
  (with-eval-after-load 'browse-url (require 'notmuch))
  :config
  (require 'org-notmuch)

  (add-to-list 'notmuch-tagging-keys '("x" ("+killed" "-unread") "Kill thread"))

  ;; bind notmuch-help to leader
  (my-major-leader
    :keymaps 'notmuch-common-keymap
    "h" 'notmuch-help)

  (my-major-leader
    :keymaps 'notmuch-show-mode-map
    "f" 'notmuch-show-forward-message
    "r" 'notmuch-show-reply-sender
    "R" 'notmuch-show-reply)

  ;; send from multiple accounts with msmtp
  ;; https://notmuchmail.org/emacstips/#index11h2
  (setq mail-specify-envelope-from t
        message-sendmail-envelope-from 'header
        mail-envelope-from 'header)

  (setq notmuch-search-oldest-first nil)

  (add-hook
   'notmuch-message-mode-hook
   'turn-off-auto-fill))
