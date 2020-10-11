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
(use-package multiple-cursors :defer t)

(use-package evil-mc
  :config
  ;; add commands for hybrid-style editing
  ;; https://github.com/gabesoft/evil-mc/issues/24
  (require 'cl-lib)
  (require 'multiple-cursors)
  (customize-set-variable
   'evil-mc-custom-known-commands
   (cl-loop for cmd in mc--default-cmds-to-run-for-all
            if (not (assoc cmd evil-mc-known-commands))
            collect `(,cmd . ((:default
                               . evil-mc-execute-default-call-with-count)))))

  (define-key evil-mc-key-map (kbd "M-C-<mouse-1>")
    'evil-mc-toggle-cursor-on-click)

  (global-evil-mc-mode 1))
