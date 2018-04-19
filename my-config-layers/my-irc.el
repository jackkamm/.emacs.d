(use-package erc
  :commands erc
  :general
  (my-leader
    "a i" 'my-freenode
    "a I" 'my-freenode-znc)
  :init
  (defun my-freenode () (interactive)
	 (erc :server "localhost"
	      :port "55555"
	      :nick "freenode"
	      :password nil))
  (defun my-freenode-znc () (interactive)
	 (async-shell-command "ssh -f znc sleep 60")
	 (sleep-for 2)
	 (my-freenode))
  :config
  (add-to-list 'erc-modules 'notifications))
