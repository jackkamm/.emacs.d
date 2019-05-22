(use-package emojify
  :commands (emojify-mode
	     global-emojify-mode)
  :init
    (dolist (h (list 'notmuch-show-hook
		     'notmuch-search-hook
		     'notmuch-tree-mode-hook))
      (add-hook h 'emojify-mode)))
