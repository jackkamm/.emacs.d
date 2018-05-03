(setq org-confirm-babel-evaluate nil)

(use-package ob-ipython :defer t
  :config
  (with-eval-after-load 'popwin
    (push '("^\*ob-ipython-.+\*.+$"
	    :regexp t
	    :noselect t)
	  popwin:special-display-config)))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (python . t)
     (emacs-lisp . t)
     (shell . t)
     (ipython . t)))
  ;; macro for "C-c ' C-c m e b C-c '"
  ;; open block (C-c '), eval buffer (C-c m e b), close block (C-c ')
  ;; assumes convention (C-c m e b) to eval buffer across modes
  (fset 'my-babel-async-eval-session
	(lambda (&optional arg) "Keyboard macro." (interactive "p")
	  (kmacro-exec-ring-item
	   (quote ("'meb'" 0 "%d")) arg)))
  (defhydra my-babel-hydra ()
    "babel"
    ("n" org-babel-next-src-block "next")
    ("p" org-babel-previous-src-block "previous")
    ("s" my-babel-async-eval-session "send-session")
    ("x" org-babel-execute-maybe "execute")
    ("q" nil "quit"))
  (my-major-leader
    :keymaps 'org-mode-map
    "b" 'my-babel-hydra/body
    "s" 'my-babel-async-eval-session
    "x" 'org-babel-execute-maybe))
