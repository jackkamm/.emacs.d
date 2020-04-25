;; Lines

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(column-number-mode)

;; Parens

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1)
  (setq evilmi-always-simple-jump t)
  ;; mhtml-mode
  (plist-put evilmi-plugins 'mhtml-mode
             '((evilmi-template-get-tag evilmi-template-jump)
               (evilmi-simple-get-tag evilmi-simple-jump)
               (evilmi-html-get-tag evilmi-html-jump))))

(use-package lispyville
 :commands lispyville-mode
 :init
 (add-hook 'emacs-lisp-mode-hook 'lispyville-mode)
 (add-hook 'clojure-mode-hook 'lispyville-mode)
 :config
 (lispyville-set-key-theme
  '(operators
    c-w
    slurp/barf-lispy
    additional
    additional-movement))
 ;; get rid of keys I don't like in additional-motion
 (evil-define-key 'motion lispyville-mode-map
   "H" nil
   "L" nil))

(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :init
  (with-eval-after-load "my-appearance"
    (my-theme-leader "r" 'rainbow-delimiters-mode))
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (cl-loop for i from 1 to 9
           for col = (x-get-resource (concat "color" (number-to-string i))
                                     "Emacs")
           until (not col)
           do
           (custom-set-faces
            `(,(intern (format "rainbow-delimiters-depth-%d-face" i))
              ((t (:foreground ,col :bold t)))))))

;; Regions

(setq my-region-map (make-sparse-keymap))
(general-create-definer my-region-leader :prefix-map 'my-region-map)
(my-leader "r" '(:keymap my-region-map :which-key "Region"))

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
