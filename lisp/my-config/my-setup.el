(require 'server)
(unless (server-running-p) (server-start))

(setq custom-file (concat user-emacs-directory
			  "custom.el"))
(if (file-exists-p custom-file)
    (load-file custom-file))
