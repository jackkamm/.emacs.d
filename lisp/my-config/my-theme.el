(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(tool-bar-mode -1)
;; disable blinking cursor:
(blink-cursor-mode -1) ;gui
(setq visible-cursor nil) ;terminal

;; pos-tip
(use-package pos-tip)

;; whitespace
(setq whitespace-style '(face trailing))
(setq whitespace-global-modes '(not erc-mode))
(global-whitespace-mode 1)

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

;; theme
(use-package material-theme)

(setq my-themes-ring '(material material-light))
(defun my-themes-cycle ()
  (interactive)
  (let ((car-theme (car my-themes-ring)))
    (mapcar 'disable-theme custom-enabled-themes)
    (load-theme car-theme t)
    (setq my-themes-ring (append (cdr my-themes-ring)
                                 (list car-theme)))))

(my-themes-cycle)

;; theme leader
(my-leader
  "t" '(:ignore t :which-key "theme")
  "tt" 'my-themes-cycle
  "tT" 'load-theme
  "tD" 'disable-theme
  "tv" 'visual-line-mode
  "tl" 'toggle-truncate-lines
  "tm" 'menu-bar-mode)

(setq-default indent-tabs-mode nil)
