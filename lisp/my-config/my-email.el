(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq message-make-forward-subject-function 'message-forward-subject-fwd)

(defun my-inbox (fetch-calendar-p)
  (interactive
   (list (y-or-n-p "Fetch google calendar?")))
  (if fetch-calendar-p
      (progn
	(require 'my-org-gcal)
	(org-gcal-fetch)))
  (notmuch-search "tag:unread")
  (let ((nm-window (get-buffer-window)))
    (org-agenda nil "n")
    (select-window nm-window)))

(use-package notmuch
  :commands (notmuch
	     notmuch-search)
  :general
  (my-leader
    "ai" 'my-inbox)
  :init
  ;; load config for browse-url-mail, used by x-scheme-handler/mailto
  (with-eval-after-load 'browse-url (require 'notmuch))
  :config
  (require 'org-notmuch)

  ;; bind notmuch-help to leader
  (my-major-leader
    :keymaps 'notmuch-common-keymap
    "h" 'notmuch-help)

  (my-major-leader
    :keymaps 'notmuch-show-mode-map
    "f" 'notmuch-show-forward-message
    "r" 'notmuch-show-reply-sender
    "R" 'notmuch-show-reply)

  (evil-define-key 'normal notmuch-message-mode-map
    (kbd "TAB") 'message-tab)

  ;; TODO: PR evil-collection?
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