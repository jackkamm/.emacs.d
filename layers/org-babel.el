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
  (fset 'babel-async-eval-session
	(lambda (&optional arg) "Keyboard macro." (interactive "p")
	  (kmacro-exec-ring-item
	   (quote ("'\355eb'" 0 "%d")) arg)))
  (my-eval-leader
    :keymaps 'org-mode-map
    "s" 'babel-async-eval-session))
