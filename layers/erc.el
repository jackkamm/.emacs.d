(use-package erc
  :commands erc
  :bind (:map my-leader-map
	      ("a e" . my-erc-freenode))
  :init
  (defun my-erc-freenode () (interactive)
	 (erc :server "irc.freenode.net"
	      :port "6667"
	      :nick "snackattack"
	      :password nil))
  :config
  (add-to-list 'erc-modules 'notifications))
