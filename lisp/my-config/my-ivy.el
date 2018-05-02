(use-package ivy
  :init
  (ivy-mode)
  :general
  (my-leader
    "SPC" 'counsel-M-x
    "ff" 'counsel-find-file
    "fr" 'counsel-recentf
    "bb" 'ivy-switch-buffer))

(use-package ivy-hydra)

(use-package counsel
  :init
  (counsel-mode))

(use-package swiper
  :general
  (my-leader "ss" 'swiper))

(use-package wgrep)
