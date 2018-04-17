(setq org-confirm-babel-evaluate nil)

(use-package ob-ipython :defer t)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (python . t)
     (emacs-lisp . t)
     (shell . t)
     (ipython . t)))
  ;; macro for "C-c ' M-m e b C-c '"
  ;; opens block (C-c '), evals buffer (M-m e b), closes block (C-c ')
  ;; assumes convention (M-m e b) to eval buffer defined across modes
  (fset 'my-babel-async-eval-session
	(lambda (&optional arg) "Keyboard macro." (interactive "p")
	  (kmacro-exec-ring-item
	   (quote ("'\355eb'" 0 "%d")) arg)))
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
