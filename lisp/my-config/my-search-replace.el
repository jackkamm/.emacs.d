(setq my-search-map (make-sparse-keymap))
(general-create-definer my-search-replace-leader :prefix-map 'my-search-map)
(my-leader "s" '(:keymap my-search-map :which-key "Search/replace"))

(my-search-replace-leader "l" 'lgrep)
(my-search-replace-leader "r" 'rgrep)

(use-package projectile
  :general (my-search-replace-leader
	     "p" 'projectile-grep))

;;; helm
(with-eval-after-load "my-helm"
  (use-package helm-ag
    :commands (helm-ag
	       helm-do-ag
	       helm-ag-buffers
	       helm-do-ag-buffers)
    :general (my-search-replace-leader
	       "g" 'helm-do-ag))

  (use-package helm-projectile
    :general (my-search-replace-leader
	       "p" 'helm-projectile-ag))

  (use-package helm-swoop
    :general (my-search-replace-leader
	       "s" 'helm-swoop)))

;; ivy
(with-eval-after-load "my-ivy"
  (use-package swiper
    :general
    (my-search-replace-leader
      "s" 'swiper
      "f" 'counsel-locate)))

;;; wgrep

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode)

;;; narrow-region

(put 'narrow-to-region 'disabled nil)
(my-search-replace-leader
  "n" '(:ignore t :which-key "narrow")
  "nr" 'narrow-to-region
  "nf" 'narrow-to-defun-include-comments
  "nF" 'narrow-to-defun
  "nw" 'widen)

;;; iedit

(use-package iedit
  :general
  (my-search-replace-leader
    "e" 'iedit-mode)
  :config
  ;; evil-define on iedit modes/maps has strange effects(?)
  ;; so create a new minor-mode instead
  (define-minor-mode my-iedit-mode nil :keymap '())
  (add-hook 'iedit-mode-hook #'evil-normalize-keymaps)
  (add-hook 'iedit-mode-hook #'my-iedit-mode)
  (add-hook 'iedit-mode-end-hook (lambda () (my-iedit-mode -1)))
  (evil-define-key 'normal 'my-iedit-mode
    (kbd "<escape>") 'iedit-quit
    "n" 'iedit-next-occurrence
    "N" 'iedit-prev-occurrence
    "D" 'iedit-delete-occurrences
    (kbd "/ f") 'iedit-restrict-function
    (kbd "/ v") 'iedit-show/hide-unmatched-lines
    (kbd "/ /") 'iedit-toggle-selection
    (kbd "RET") 'iedit-toggle-selection
    (kbd "/ n") 'iedit-expand-down-to-occurrence
    (kbd "C-j") 'iedit-expand-down-to-occurrence
    (kbd "/ N") 'iedit-expand-up-to-occurrence
    (kbd "C-k") 'iedit-expand-up-to-occurrence
    (kbd "/ l") 'iedit-restrict-current-line
    (kbd "M-l") 'iedit-restrict-current-line
    (kbd "/ j") 'iedit-expand-down-a-line
    (kbd "M-j") 'iedit-expand-down-a-line
    (kbd "/ k") 'iedit-expand-up-a-line
    (kbd "M-k") 'iedit-expand-up-a-line))

;;; evil-mc

(use-package evil-mc
  :commands my-evil-mc-hydra/evil-mc-toggle-cursor-on-click
  :bind (("S-<down-mouse-1>" . 'my-evil-mc-hydra/evil-mc-toggle-cursor-on-click))
  :general
  (my-search-replace-leader
    "m" 'my-evil-mc-hydra/body)
  :init
  (setq evil-mc-key-map nil)
  :config
  (global-evil-mc-mode)
  (require 'hydra)
  (defhydra my-evil-mc-hydra ()
    "multicursor"
    ("S-<down-mouse-1>" evil-mc-toggle-cursor-on-click)
    ("u" evil-mc-undo-all-cursors "remove-all" :exit t)
    ("m" evil-mc-make-all-cursors "make-all")
    ("p" my-paused-mc-hydra/body "pause" :exit t)
    ("J" evil-mc-make-cursor-move-next-line "next-line")
    ("K" evil-mc-make-cursor-move-prev-line "prev-line")
    ("H" evil-mc-make-and-goto-first-cursor "swap-to-first")
    ("L" evil-mc-make-and-goto-last-cursor "swap-to-last")
    ("C-j"  evil-mc-make-and-goto-next-cursor "swap-forward")
    ("C-k"  evil-mc-make-and-goto-prev-cursor "swap-backward")
    ("M-j" evil-mc-skip-and-goto-next-cursor "pop-forward")
    ("M-k" evil-mc-skip-and-goto-prev-cursor "pop-backward")
    ("C-n"  evil-mc-make-and-goto-next-match "make-next")
    ("C-p"  evil-mc-make-and-goto-prev-match "make-prev")
    ("M-n" evil-mc-skip-and-goto-next-match "pop-to-next-match")
    ("M-p" evil-mc-skip-and-goto-prev-match "pop-to-prev-match"))
  (defhydra my-paused-mc-hydra (nil nil
				    :foreign-keys run
				    :body-pre (evil-mc-pause-cursors)
				    :post (evil-mc-resume-cursors))
    "paused-multicursor"
    ("S-<down-mouse-1>" evil-mc-toggle-cursor-on-click)
    ("<RET>" evil-mc-make-cursor-here "mark-here")
    ("r" my-evil-mc-hydra/body "resume" :exit t)
    ("a" evil-append :exit t)
    ("i" evil-insert :exit t)))
