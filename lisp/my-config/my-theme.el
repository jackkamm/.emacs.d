(setq my-theme-map (make-sparse-keymap))
(general-create-definer my-theme-leader :prefix-map 'my-theme-map)
(my-leader "t" '(:keymap my-theme-map :which-key "Theme"))

(my-theme-leader
  "v" 'visual-line-mode
  "l" 'toggle-truncate-lines
  "m" 'menu-bar-mode)

;; disable toolbar/scrollbar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(tool-bar-mode -1)

;; minimap
(use-package minimap
  :general
  (my-leader "tM" 'minimap-mode))

;; disable blinking cursor:
(blink-cursor-mode -1) ;gui
(setq visible-cursor nil) ;terminal

;; pos-tip
(use-package pos-tip)

;; whitespace
(setq whitespace-style '(face trailing))
(setq whitespace-global-modes '(not erc-mode))
(global-whitespace-mode 1)

(setq-default indent-tabs-mode nil)

;; higlighting
(use-package hl-todo
  :defer 5
  :config
  (global-hl-todo-mode 1))

(use-package evil-search-highlight-persist
  :config
  (global-evil-search-highlight-persist)
  (my-leader
    "sc" 'evil-search-highlight-persist-remove-all))

;; Theme

(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/eziam-theme-emacs/")
(setq my-themes-ring '(eziam-dark eziam-dusk eziam-light))
(defun my-themes-cycle ()
  (interactive)
  (let ((car-theme (car my-themes-ring)))
    (mapcar 'disable-theme custom-enabled-themes)
    (load-theme car-theme t)
    (setq my-themes-ring (append (cdr my-themes-ring)
                                 (list car-theme)))))

(my-themes-cycle)

(my-theme-leader
  "t" 'my-themes-cycle
  "T" 'load-theme
  "D" 'disable-theme)

;; Open in browser

(setq browse-url-new-window-flag t)
;; need to set this explicitly, xdg-open doesn't know about new-window-flag
(setq browse-url-browser-function 'browse-url-firefox)
