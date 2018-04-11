(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/bin/msmtp")

(use-package notmuch
  :commands notmuch
  :config
  (evil-set-initial-state 'notmuch-hello-mode 'motion)
  (evil-set-initial-state 'notmuch-search-mode 'motion)
  (evil-set-initial-state 'notmuch-tree-mode 'motion)
  (evil-set-initial-state 'notmuch-show-mode 'motion)
  (my-major-leader
    :keymaps 'notmuch-common-keymap
    "h" 'notmuch-help)
  (evil-define-key 'motion notmuch-common-keymap
    "J" 'notmuch-jump-search)
  (evil-define-key '(visual motion) notmuch-search-mode-map
    "*" 'notmuch-search-tag-all
    "+" 'notmuch-search-add-tag
    "-" 'notmuch-search-remove-tag)
  (evil-define-key '(visual motion) notmuch-show-mode-map
    "*" 'notmuch-show-tag-all
    "+" 'notmuch-show-add-tag
    "-" 'notmuch-show-remove-tag)
  (evil-define-key '(visual motion) notmuch-tree-mode-map
    "*" 'notmuch-tree-tag-thread
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
