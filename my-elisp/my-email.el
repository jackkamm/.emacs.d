(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/bin/msmtp")

(use-package notmuch
  :bind
  (:map my-leader-map
	("a e" . notmuch))
  :config
  (require 'org-notmuch)

  ;; bind notmuch-help to leader
  (my-major-leader
    :keymaps 'notmuch-common-keymap
    "h" 'notmuch-help)

  ;; leader keys for notmuch-show
  (defun my-notmuch-open-part ()
    "Display attachment using xdg-open"
    (interactive)
    ;; TODO use "open" on macOS
    (notmuch-show-apply-to-current-part-handle
     (lambda (handle) (mm-display-external handle "xdg-open %s"))))
  (my-major-leader
    :keymaps 'notmuch-show-mode-map
    "f" 'notmuch-show-forward-message
    "r" 'notmuch-show-reply-sender
    "R" 'notmuch-show-reply
    "o" 'my-notmuch-open-part)

  ;; TODO: PR evil-collection
  (evil-set-initial-state 'notmuch-tree-mode 'normal)
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
   'turn-off-auto-fill))
