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

;; Commented out on 2023-08-14 after updating to emacs29 and getting this warning:
;; Warning (emacs): Package ‘docker-tramp’ has been obsoleted, please use integrated package ‘tramp-container’
;;(use-package docker-tramp :demand t)

(provide 'my-tramp)
;;; my-tramp.el ends here
