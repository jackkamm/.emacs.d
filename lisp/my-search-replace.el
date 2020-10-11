(setq my-search-map (make-sparse-keymap))
(general-create-definer my-search-replace-leader :prefix-map 'my-search-map)
(my-leader "s" '(:keymap my-search-map :which-key "Search/replace"))

(my-search-replace-leader
  "l" 'lgrep
  "c" 'evil-ex-nohighlight)

;; occur
(evil-define-key 'normal occur-mode-map
  "o" 'occur-mode-display-occurrence)

;; wgrep
(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :init
  (with-eval-after-load 'helm-occur
    (my-major-leader
      :mode 'helm-occur-mode
      "w" 'wgrep-change-to-wgrep-mode)))

;; projectile

(pcase my-completing-read-style
  (`helm
   (my-search-replace-leader
     "g" 'helm-do-grep-ag
     "b" 'helm-do-ag-buffers
     "s" 'helm-occur
     "p" 'helm-projectile-ag))
  (`ivy
   (my-search-replace-leader
     "s" 'swiper
     "b" 'swiper-all
     "f" 'counsel-locate
     "g" 'counsel-ag
     "p" 'counsel-projectile-grep
     "i" 'swiper-from-isearch))
  (_
   (my-search-replace-leader
     "g" 'rgrep
     "p" 'project-find-regexp
     "b" 'multi-occur-in-matching-buffers)))

;; additional keybindings for hybrid style completion
(when (equal my-completing-read-style 'hybrid)
  (my-search-replace-leader
    "O" 'helm-occur
    "G" 'helm-do-grep-ag
    "B" 'helm-do-ag-buffers
    "P" 'helm-projectile-ag))

;; visualstar
(use-package evil-visualstar
  :config
  (global-evil-visualstar-mode))

;; iedit
(use-package evil-iedit-state
  :general
  (my-search-replace-leader
    "e" 'evil-iedit-state/iedit-mode))

;; multiple-cursors
(use-package multiple-cursors
  ;; use :bind keyword b/c :general doesn't like fake commands
  :bind
  (:map evil-motion-state-map ("Q" . #'my-mc-mode))
  (:map my-search-map ("Q" . #'my-mc-mode))
  :config
  ;; switch to emacs-state when activating multiple-cursors
  (add-hook 'multiple-cursors-mode-hook
            (lambda ()
              (if multiple-cursors-mode
                  (if (not (evil-visual-state-p))
                      (evil-emacs-state)
                    ;; based on evil-execute-in-emacs-state
                    (let ((mrk (mark))
                          (pnt (point)))
                      (evil-emacs-state)
                      (set-mark mrk)
                      (goto-char pnt)) )
                (evil-exit-emacs-state))))
  ;; based on https://github.com/abo-abo/hydra/wiki/multiple-cursors,
  ;; but using hercules so we don't have to tell multiple-cursors.el
  ;; about each of the individual hydra commands.
  (setq my-mc-map (make-sparse-keymap))
  (bind-keys
   :map my-mc-map
   ("C-<backspace>" . helm-delete-minibuffer-contents)
   ("l" . mc/edit-lines)
   ("a" . mc/mark-all-dwim)
   ("n" . mc/mark-next-like-this-symbol)
   ("N" . mc/skip-to-next-like-this)
   ("M-n" . mc/unmark-next-like-this)
   ("p" . mc/mark-previous-like-this-symbol)
   ("P" . mc/skip-to-previous-like-this)
   ("M-p" . mc/unmark-previous-like-this)
   ("|" . mc/vertical-align)
   ("s" . mc/mark-all-in-region-regexp)
   ("0" . mc/insert-numbers)
   ("A" . mc/insert-letters)
   ("Q" . my-mc-mode)
   ("<mouse-1>" . mc/add-cursor-on-click)
   ("<down-mouse-1>" . ignore)
   ("<drag-mouse-1>" . ignore))
  (hercules-def
   :toggle-funs #'my-mc-mode
   :keymap 'my-mc-map
   :transient t))

