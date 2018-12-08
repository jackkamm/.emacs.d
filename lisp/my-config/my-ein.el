(use-package ein
  :commands (ein:notebooklist-login
	     ein:notebooklist-open)
  :config
  (require 'ein-notebook)
  (require 'ein-subpackages)

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
      "h" 'my-ein-hydra/body))
  (my-major-leader
    :keymaps 'ein:notebook-mode-map
    "s" 'ein:notebook-save-notebook-command
    "d" 'ein:worksheet-delete-cell
    "o" 'ein:worksheet-insert-cell-below
    "O" 'ein:worksheet-insert-cell-above
    "j" 'ein:worksheet-goto-next-input
    "k" 'ein:worksheet-goto-prev-input
    "<return>" 'ein:worksheet-execute-cell-and-goto-next))

  ;; ob-ein should be loaded by org-mode
  (with-eval-after-load 'ob-ein
    (ein:org-register-lang-mode "ein-R" 'R)))
