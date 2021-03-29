;; Inserting and sending special text

(setq my-insert-map (make-sparse-keymap))
(general-create-definer my-insert-leader :prefix-map 'my-insert-map)
(my-leader "i" '(:keymap my-insert-map :which-key "Insert"))

;; Insert passwords to comint

(defun my-comint-send-invisible-advice (&rest r)
  "Advice to fix security bug in `comint-send-invisible', as of emacs27.

In particular, the help for `comint-send-invisible' says:
Security bug: your string can still be temporarily recovered with
C-h l; ‘clear-this-command-keys’ can fix that."
  (clear-this-command-keys))

(my-insert-leader "v" 'comint-send-invisible)

(advice-add #'comint-send-invisible
            :after #'my-comint-send-invisible-advice)

;; unicode

(my-insert-leader "u" (general-simulate-key "C-x 8" :which-key "Unicode"))

;; zero-width space

;; https://thewanderingcoder.com/2015/03/emacs-org-mode-styling-non-smart-quotes-zero-width-space-and-tex-input-method/

(defun my-insert-zero-width-space ()
  (interactive)
  (insert-char ?\u200B)) ;; code for ZERO WIDTH SPACE

(my-insert-leader "z" 'my-insert-zero-width-space)


