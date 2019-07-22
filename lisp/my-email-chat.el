;; Chat

(use-package erc
  :commands erc
  :general
  (my-leader "az" 'my-znc-freenode)
  :init
  (defun my-znc-freenode (tunnelp)
    (interactive
     (list (y-or-n-p "Open tunnel?")))
    (if tunnelp
	(progn
	  (async-shell-command "ssh -f znc -L 55555:localhost:55555 sleep 60")
	  (sleep-for 2)))
    (erc
     ;; forward znc to local port 55555
     :server "localhost" :port "55555"
     ;; configure SASL on 1st login (https://wiki.znc.in/Sasl)
     ;; no other configuration should be needed...
     :nick "freenode"
     ;; password has format
     ;;     <znc-user>/freenode:<znc-password>
     ;; store password in authinfo
     :password nil))
  :config
  (add-to-list 'erc-modules 'notifications))

;; Mail

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
  (with-eval-after-load 'org
    (require 'org-notmuch))

  (add-hook 'notmuch-show-mode-hook
            (lambda () (toggle-truncate-lines -1)))

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
