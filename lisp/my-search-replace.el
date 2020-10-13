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
(use-package iedit
  :general
  (my-search-replace-leader
    "e" 'iedit-mode))

;; multiple-cursors
(use-package multiple-cursors
  :general
  (my-search-replace-leader "m" 'my-mc-hydra/body)
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
                (evil-normal-state))))
  ;; https://github.com/abo-abo/hydra/wiki/multiple-cursors
  (defhydra my-mc-hydra (:hint nil)
    "
 Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search      [_q_] Quit
 [_|_] Align with input CHAR       [Click] Cursor at point"
    ("l" mc/edit-lines :exit t)
    ("a" mc/mark-all-dwim)
    ("n" mc/mark-next-like-this-symbol)
    ("N" mc/skip-to-next-like-this)
    ("M-n" mc/unmark-next-like-this)
    ("p" mc/mark-previous-like-this-symbol)
    ("P" mc/skip-to-previous-like-this)
    ("M-p" mc/unmark-previous-like-this)
    ("|" mc/vertical-align)
    ("s" mc/mark-all-in-region-regexp :exit t)
    ("0" mc/insert-numbers :exit t)
    ("A" mc/insert-letters :exit t)
    ("<mouse-1>" mc/add-cursor-on-click)
    ;; Help with click recognition in this hydra
    ("<down-mouse-1>" ignore)
    ("<drag-mouse-1>" ignore)
    ("q" nil))
  ;; add hydra heads to 'mc/cmds-to-run-once`.
  (require 'cl-lib)
  (cl-loop for head in my-mc-hydra/heads
           do (add-to-list
               'mc/cmds-to-run-once
               (intern (concat "my-mc-hydra/"
                               (symbol-name (cadr head))
                               (when (and (cadr head)
                                          (plist-get (cl-cdddr head) :exit))
                                 "-and-exit"))))))
