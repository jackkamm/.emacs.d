(use-package ein
  :commands (ein:notebooklist-login
	     ein:notebooklist-open)
  :config
  (my-leader
    :keymaps 'ein:notebook-mode-map
    "fs" 'ein:notebook-save-notebook-command)
  (with-eval-after-load 'hydra
    (defhydra my-ein-hydra ()
      "ein"
      ("j" ein:worksheet-goto-next-input)
      ("k" ein:worksheet-goto-prev-input)
      ("<return>" ein:worksheet-execute-cell-and-goto-next)
      ("b" evil-scroll-line-to-bottom)
      ("t" evil-scroll-line-to-top)
      ("z" evil-scroll-line-to-center)
      ("O" ein:worksheet-insert-cell-above)
      ("o" ein:worksheet-insert-cell-below)
      ("q" nil "quit"))
    (my-major-leader
      :keymaps 'ein:notebook-mode-map
      "m" 'my-ein-hydra/body))
  (my-major-leader
    :keymaps 'ein:notebook-mode-map
    "d" 'ein:worksheet-delete-cell
    "o" 'ein:worksheet-insert-cell-below
    "O" 'ein:worksheet-insert-cell-above
    "j" 'ein:worksheet-goto-next-input
    "k" 'ein:worksheet-goto-prev-input
    "<return>" 'ein:worksheet-execute-cell-and-goto-next)
  (my-eval-leader
    :keymaps 'ein:notebook-mode-map
    "e" 'ein:worksheet-execute-cell-and-goto-next)
  )
