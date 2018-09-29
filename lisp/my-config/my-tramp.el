;; try to make tramp+git faster
(setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)"
				    vc-ignore-dir-regexp
				    tramp-file-name-regexp))

(with-eval-after-load 'tramp-sh
  ;; use correct path when executing code block in remote :dir
  ;; or using eshell
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

  ;; use ssh-agent forwarding for /ssh: connections
  ;; this has security implications; use /scp: to avoid forwarding
  (let* ((ssh-args (assoc "ssh" tramp-methods))
	 (ssh-login-list (assoc 'tramp-login-args ssh-args))
	 (ssh-login-args (car (cdr ssh-login-list))))
    (setcdr ssh-login-list (add-to-list 'ssh-login-args '("-A")))))

