(use-package erc
  :commands erc
  :general
  (my-leader "a i" 'my-znc-freenode)
  :init
  (defun my-znc-freenode (tunnelp)
    (interactive
     (list (y-or-n-p "Open tunnel?")))
    (if tunnelp
	(progn
	  (async-shell-command "ssh -f znc sleep 60")
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
