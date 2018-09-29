;; try to make tramp+git faster
(setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)"
				    vc-ignore-dir-regexp
				    tramp-file-name-regexp))

(with-eval-after-load 'tramp-sh
  ;; use correct path when executing code block in remote :dir
  ;; or using eshell
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

  ;; use ssh-agent forwarding under /scp:
  ;; this has security implications; use /ssh: to avoid forwarding
  ;; https://emacs.stackexchange.com/questions/18262/tramp-how-to-add-a-agent-forwarding-to-ssh-connections/18280
  (add-to-list 'tramp-connection-properties
               (list (regexp-quote "/scp:")
                     "login-args"
                     '(("-A") ("-l" "%u") ("-p" "%p") ("%c")
                       ("-e" "none") ("%h")))))

