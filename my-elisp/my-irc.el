(use-package erc
  :commands erc
  :bind (:map my-leader-map
	      ("a i" . my-freenode)
	      ("a I" . my-znc-freenode))
  :init
  (defun my-freenode () (interactive)
	 (erc :server "localhost"
	      :port "55555"
	      :nick "freenode"
	      :password nil))
  (defun my-znc-freenode () (interactive)
	 (async-shell-command "ssh -fNT znc")
	 (sleep-for 1)
	 (my-freenode))
  :config
  (add-to-list 'erc-modules 'notifications))
