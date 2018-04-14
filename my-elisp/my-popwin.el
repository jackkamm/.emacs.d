(use-package popwin
  :config
  (popwin-mode 1)
  (push '("*Async Shell Command*"
	  :noselect t)
	popwin:special-display-config)
  )
