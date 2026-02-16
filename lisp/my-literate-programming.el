;;; my-literate-programming.el --- Literate programming config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'my-R)
(require 'my-python)

(use-package ein
  :init
  (setq ein:output-area-inlined-images t)
  :config
  (with-eval-after-load 'hydra
    (defhydra my-ein-hydra ()
      "ein"
      ("j" ein:worksheet-goto-next-input-km)
      ("k" ein:worksheet-goto-prev-input-km)
      ("<return>" ein:worksheet-execute-cell-and-goto-next-km)
      ("b" evil-scroll-line-to-bottom)
      ("t" evil-scroll-line-to-top)
      ("z" evil-scroll-line-to-center)
      ("O" ein:worksheet-insert-cell-above-km)
      ("o" ein:worksheet-insert-cell-below-km)
      ("q" nil "quit"))
    (my-major-leader
      :keymaps 'ein:notebook-mode-map
      "h" 'my-ein-hydra/body))
  (my-major-leader
    :keymaps 'ein:notebook-mode-map
    "s" 'ein:notebook-save-notebook-command-km
    "d" 'ein:worksheet-kill-cell-km
    "o" 'ein:worksheet-insert-cell-below-km
    "O" 'ein:worksheet-insert-cell-above-km
    "j" 'ein:worksheet-goto-next-input-km
    "k" 'ein:worksheet-goto-prev-input-km
    "<return>" 'ein:worksheet-execute-cell-and-goto-next-km))

;;;; I'm not using emacs-jupyter these days, and I found it can cause
;;;; delays when starting up Org files or sometimes other issues such
;;;; as when using tramp or if jupyter binary is missing. If I decide
;;;; to uncomment this again, remember to add jupyter back to
;;;; org-babel-load-languages in my org-babel config
;;(use-package jupyter
;;  :init
;;  (add-hook 'jupyter-repl-mode-hook
;;            (lambda () (display-line-numbers-mode -1)))
;;  ;; TODO jupyter.el violates keybinding conventions; submit PR
;;  (with-eval-after-load 'jupyter-org-extensions
;;    (bind-key (kbd "C-c h") nil jupyter-org-interaction-mode-map)
;;    (my-major-leader
;;      :keymaps 'org-mode-map
;;      "h" 'jupyter-org-hydra/body))
;;  :config
;;  (setq org-babel-default-header-args:jupyter-python
;;        '((:async . "yes") (:kernel . "python3"))))
;;(with-eval-after-load 'org
;;  (require 'jupyter))

(with-eval-after-load 'org
  ;;; org-babel
  (setq org-confirm-babel-evaluate nil)
  ;; NOTE see also https://github.com/Somelauw/evil-org-mode/issues/59
  (define-key org-src-mode-map [remap evil-write] 'org-edit-src-save)

  ;; Idea to try to get PDF images to show; didn't work.
  ;;(require 'image-file)
  ;;(push "pdf" image-file-name-extensions)

  ;; set default-directory to :dir, for path completion in src buffers
  ;; TODO: submit to org-mode?
  (defun my-org-edit-src-wrapper (&rest args)
    (when org-src--babel-info
      (let ((dir (cdr (assq :dir (nth 2 org-src--babel-info)))))
        (when dir
          (setq default-directory (file-name-as-directory
                                   (expand-file-name dir)))))))
  (advice-add 'org-edit-src-code :after 'my-org-edit-src-wrapper)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (python . t)
     (sql . t)
     (sqlite . t)
     (ruby . t)
     (emacs-lisp . t)
     (shell . t)
     (screen . t)
     ;;(jupyter . t)
     (latex . t))))

(use-package ob-async
  :after org
  :load-path (lambda () (concat user-emacs-directory "lisp/ob-async"))
  :ensure nil
  :demand t
  :init
  (setq ob-async-ignore-sessions t)
  :config
  ;; https://github.com/astahlman/ob-async/issues/37
  ;; workaround for ob-julia, which breaks ob-async (even on non-julia langs)
  (add-hook 'ob-async-pre-execute-src-block-hook
            #'(lambda ()
                (setq inferior-julia-program-name "/usr/local/bin/julia"))))

(use-package ob-reticulate
  :after org
  :demand t
  :config
  (ob-reticulate-mode 1))

(use-package poly-R
  :mode ("\\.Rmd" . poly-markdown+R-mode))

(provide 'my-literate-programming)
;;; my-literate-programming.el ends here
