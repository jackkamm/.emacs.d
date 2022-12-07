;; Lines

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(column-number-mode)

;; Parens

(use-package evil-surround
  :demand t
  :config
  (global-evil-surround-mode 1))

;;(electric-pair-mode 1)
(add-hook 'prog-mode-hook (lambda () (electric-pair-local-mode 1)))

;; electric-pair seems to have problems in inferior R, Python, but it
;; would be nice to have
;;(add-hook 'comint-mode-hook (lambda () (electric-pair-local-mode 1)))

(show-paren-mode 1)

(use-package evil-matchit
  :demand t
  :config
  (global-evil-matchit-mode 1)
  (setq evilmi-always-simple-jump t)
  ;; mhtml-mode
  (plist-put evilmi-plugins 'mhtml-mode
             '((evilmi-template-get-tag evilmi-template-jump)
               (evilmi-simple-get-tag evilmi-simple-jump)
               (evilmi-html-get-tag evilmi-html-jump))))

;;(use-package lispyville
;;  :hook
;;  ((emacs-lisp-mode . lispyville-mode)
;;   (clojure-mode . lispyville-mode))
;;  :config
;;  (lispyville-set-key-theme
;;   '(operators
;;     c-w
;;     slurp/barf-lispy
;;     additional
;;     additional-movement))
;;  ;; get rid of keys I don't like in additional-motion
;;  (evil-define-key 'motion lispyville-mode-map
;;    "H" nil
;;    "L" nil))

(use-package rainbow-delimiters
  :init
  (with-eval-after-load "my-themes-toggles"
    (my-toggle-leader "r" 'rainbow-delimiters-mode)))

;; Regions

(setq my-region-map (make-sparse-keymap))
(general-create-definer my-region-leader :prefix-map 'my-region-map)
(my-leader "v" '(:keymap my-region-map :which-key "Region"))

(put 'narrow-to-region 'disabled nil)
(setq narrow-to-defun-include-comments t)
(my-region-leader
  "TAB" 'indent-region
  "n" 'narrow-to-region
  "f" 'narrow-to-defun
  "w" 'widen)

(use-package expand-region
  :general
  (my-region-leader
    "v" 'er/expand-region)
  :config
  (setq expand-region-contract-fast-key "V"
	expand-region-reset-fast-key "r"))
