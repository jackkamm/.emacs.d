(use-package ein
  :commands (ein:notebooklist-login
	     ein:notebooklist-open)
  :config
  (my-leader
    :keymaps 'ein:notebook-mode-map
    "fs" 'ein:notebook-save-notebook-command)
  )
