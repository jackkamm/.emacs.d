;;; my-tramp.el --- Remote editing  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; try to make tramp+git faster
(setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)"
				    vc-ignore-dir-regexp
				    tramp-file-name-regexp))

(with-eval-after-load 'tramp-sh
  ;; use correct path when executing code block in remote :dir
  ;; or using eshell
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; Docker
(use-package docker-tramp :demand t)

(provide 'my-tramp)
;;; my-tramp.el ends here
