(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/bin/msmtp")

(use-package notmuch
  :commands notmuch
  :config
  (evil-set-initial-state 'notmuch-hello-mode 'motion)
  (evil-set-initial-state 'notmuch-search-mode 'motion)
  (evil-set-initial-state 'notmuch-tree-mode 'motion)
  (evil-set-initial-state 'notmuch-show-mode 'motion)
  ;; send from multiple accounts with msmtp
  ;; https://notmuchmail.org/emacstips/#index11h2
  (setq mail-specify-envelope-from t
        message-sendmail-envelope-from 'header
        mail-envelope-from 'header)

  (setq notmuch-search-oldest-first nil)

  (add-hook
   'notmuch-message-mode-hook
   'turn-off-auto-fill)
  )
