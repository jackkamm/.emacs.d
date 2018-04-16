(use-package erc
  :commands erc
  :bind (:map my-leader-map
	      ("a e" . my-erc-freenode))
  :init
  (defun my-erc-freenode () (interactive)
	 (erc :server "localhost"
	      :port "55555"
	      :nick "freenode"
	      :password nil))
  :config
  (add-to-list 'erc-modules 'notifications))
