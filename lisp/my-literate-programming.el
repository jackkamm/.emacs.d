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

(use-package jupyter
  :commands (jupyter-run-repl jupyter-connect-repl)
  :init
  (add-hook 'jupyter-repl-mode-hook
            (lambda () (display-line-numbers-mode -1)))
  ;; TODO jupyter.el violates keybinding conventions; submit PR
  (with-eval-after-load 'jupyter-org-extensions
    (bind-key (kbd "C-c h") nil jupyter-org-interaction-mode-map)
    (my-major-leader
      :keymaps 'org-mode-map
      "h" 'jupyter-org-hydra/body))
  :config
  (setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                       (:kernel . "python3"))))

(with-eval-after-load 'org
  ;;; org-babel
  (setq org-confirm-babel-evaluate nil)
  ;; NOTE see also https://github.com/Somelauw/evil-org-mode/issues/59
  (define-key org-src-mode-map [remap evil-write] 'org-edit-src-save)

  ;; set default-directory to :dir, for path completion in src buffers
  ;; TODO: submit to org-mode?
  (defun my-org-edit-src-wrapper (&rest args)
    (when org-src--babel-info
      (let ((dir (cdr (assq :dir (nth 2 org-src--babel-info)))))
        (when dir
          (setq default-directory (file-name-as-directory
                                   (expand-file-name dir)))))))
  (advice-add 'org-edit-src-code :after 'my-org-edit-src-wrapper)

  (require 'jupyter)
  ;; FIXME below breaks if ess not yet installed
  (require 'ess) ; needed for inferior-julia-program-name
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (python . t)
     (julia . t)
     (sql . t)
     (sqlite . t)
     (ruby . t)
     ;;(emamux . t)
     (emacs-lisp . t)
     (shell . t)
     (jupyter . t))))

(use-package ob-async
  :after org
  :init
  (setq ob-async-no-async-languages-alist
        '("jupyter-python" "jupyter-R" "jupyter-julia"))
  :config
  ;; https://github.com/astahlman/ob-async/issues/37
  ;; workaround for ob-julia, which breaks ob-async (even on non-julia langs)
  (add-hook 'ob-async-pre-execute-src-block-hook
            '(lambda ()
               (setq inferior-julia-program-name "/usr/local/bin/julia"))))

(use-package ob-session-async-R
  :ensure nil
  :after org)

(use-package polymode
  :mode (("\\.[rR]nw\\'" . poly-noweb+r-mode)
	 ("\\.Rmd" . poly-markdown+r-mode))
  :config
  (use-package poly-R)
  (use-package poly-noweb)
  (use-package poly-markdown)
  (setq polymode-weave-output-file-format "%s")
  (setq polymode-exporter-output-file-format "%s")
  (setq polymode-display-process-buffers nil)
  (setq polymode-display-output-file nil)
  ;; AUCTeX integration
  (with-eval-after-load 'tex
    (add-to-list 'TeX-command-list
  		 '("polymode-export" "(polymode-export)"
  		   TeX-run-function nil (latex-mode) :help) t)
    (mapc (lambda (suffix)
	    (add-to-list 'TeX-file-extensions suffix))
	  '("nw" "Snw" "Rnw"))
    (add-hook 'poly-noweb+r-mode-hook
	      (lambda ()
		(setq TeX-command-default "polymode-export")))))
