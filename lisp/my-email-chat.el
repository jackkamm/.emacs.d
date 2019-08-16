;; Chat

(use-package erc
  :commands erc
  :custom
  ;; do "ssh -NL 9000:localhost:9000 irc" to open the port
  ((erc-server "localhost")
   (erc-port "9000")
   (erc-nick "snackattack"))
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

  ;; send from multiple accounts with msmtp
  ;; https://notmuchmail.org/emacstips/#index11h2
  (setq mail-specify-envelope-from t
        message-sendmail-envelope-from 'header
        mail-envelope-from 'header)

  (setq notmuch-search-oldest-first nil)

  ;; Line-wrapping, column width, and format=flowed
  ;;
  ;; Unix email etiquette requires sent text to be no longer than 80
  ;; characters, inserting newlines as necessary, but this looks
  ;; terrible on mobile devices.
  ;;
  ;; "format=flowed" is supposed to fix this, but many readers no
  ;; longer support this. It appears that Gmail, which once displayed
  ;; this correctly, no longer does (as confirmed by the the Update in
  ;; https://cpbotha.net/2016/09/27/thunderbird-support-of-rfc-3676-formatflowed-is-half-broken/)
  ;;
  ;; My current solution is to do manual formatting based on the
  ;; expected recipients. In particular, I disable auto-fill by
  ;; default, and manually format with set-fill (M-q) as desired.
  ;;
  ;; The soft newlines and "format=flowed" can be enabled by calling
  ;; `use-hard-newlines'. However, it hardly seems worth it since
  ;; Gmail seems to ignore "format=flowed" now.

  (add-hook 'message-mode-hook 'turn-off-auto-fill)
  ;;(add-hook 'message-mode-hook 'use-hard-newlines)
  )
