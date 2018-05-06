(my-leader "i" '(:ignore t :which-key "Insert"))
(general-create-definer my-insert-leader :prefix "C-c i")

;;; company

(use-package company
  :commands (company-mode company-mode-on)
  :init
  (dolist (h (list 'prog-mode-hook
		   'text-mode-hook))
    (add-hook h 'company-mode-on))
  :config
  (bind-keys :map company-active-map
	     ("<return>" . nil)))

(with-eval-after-load "my-helm"
  (use-package helm-company
    :after company
    :config
    (define-key company-mode-map (kbd "C-;") 'helm-company)
    (define-key company-active-map (kbd "C-;") 'helm-company)))

;;; yasnippet

(use-package yasnippet
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode-on)
  (add-hook 'text-mode-hook 'yas-minor-mode-on)
  :commands yas-minor-mode-on
  :config
  (yas-reload-all))

(with-eval-after-load "my-helm"
  (use-package helm-c-yasnippet
    :commands (helm-yas-complete
	       helm-yas-visit-snippet-file)
    :general
    (my-insert-leader
      "s" 'helm-yas-complete)))

(use-package yasnippet-snippets :defer t)
