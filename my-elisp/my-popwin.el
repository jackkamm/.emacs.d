(use-package popwin
  :config
  (popwin-mode 1)
  (push '("^\*Async Shell Command\*.+$"
	  :regexp t
	  :noselect t)
	popwin:special-display-config)
  (push '("*Help*" :noselect t)
	popwin:special-display-config))
