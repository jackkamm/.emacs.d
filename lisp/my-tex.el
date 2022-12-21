;;; my-tex.el --- TeX config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:



(use-package tex
  :ensure auctex
  :general
  (my-major-leader
    :keymaps 'LaTeX-mode-map
    "m" 'TeX-command-master
    "e" 'LaTeX-environment)
  :config
  (TeX-source-correlate-mode))

;; start helm \includegraphics in local directory
(setq LaTeX-includegraphics-read-file
      'LaTeX-includegraphics-read-file-relative)

(provide 'my-tex)
;;; my-tex.el ends here
