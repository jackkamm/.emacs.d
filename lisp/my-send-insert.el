;; Inserting and sending special text

(setq my-insert-map (make-sparse-keymap))
(general-create-definer my-insert-leader :prefix-map 'my-insert-map)
(my-leader "i" '(:keymap my-insert-map :which-key "Insert"))

;; Reverse yanking
;; https://www.emacswiki.org/emacs/KillingAndYanking

(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))

(global-set-key "\M-Y" 'yank-pop-forwards) ; M-Y (Meta-Shift-Y)

;; from `konix/kill-ring-insert' in
;; https://www.emacswiki.org/emacs/BrowseKillRing

(defun my-kill-ring-insert ()
  (interactive)
  (let ((to_insert (completing-read "Yank : " kill-ring)))
    (when (and to_insert (region-active-p))
      ;; the currently highlighted section is to be replaced by the yank
      (delete-region (region-beginning) (region-end)))
    (insert to_insert)))

(my-insert-leader "y" 'my-kill-ring-insert)

;; Insert passwords to comint

(my-insert-leader "v" 'comint-send-invisible)

;; unicode

(my-insert-leader "u" (general-simulate-key "C-x 8" :which-key "Unicode"))

;; zero-width space

;; https://thewanderingcoder.com/2015/03/emacs-org-mode-styling-non-smart-quotes-zero-width-space-and-tex-input-method/

(defun my-insert-zero-width-space ()
  (interactive)
  (insert-char ?\u200B)) ;; code for ZERO WIDTH SPACE

(my-insert-leader "z" 'my-insert-zero-width-space)


