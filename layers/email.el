(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/bin/msmtp")

(use-package notmuch
  :commands notmuch
  :config
  (my-major-leader
    :keymaps 'notmuch-common-keymap
    "h" 'notmuch-help)
  ;; TODO: PR evil-collection
  (evil-define-key 'visual notmuch-search-mode-map
    "+" 'notmuch-search-add-tag
    "-" 'notmuch-search-remove-tag)
  (evil-define-key 'visual notmuch-show-mode-map
    "+" 'notmuch-show-add-tag
    "-" 'notmuch-show-remove-tag)
  (evil-define-key 'visual notmuch-tree-mode-map
    "+" 'notmuch-tree-add-tag
    "-" 'notmuch-tree-remove-tag)
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
