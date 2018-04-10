(setq org-confirm-babel-evaluate nil)

(use-package ob-ipython :defer t)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (python . t)
     (emacs-lisp . t)
     (shell . t)
     (ipython . t))))
