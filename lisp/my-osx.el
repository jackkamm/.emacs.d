;;; my-osx.el --- MacOS configs                      -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq ns-command-modifier 'meta)

(use-package exec-path-from-shell
  :demand t
  :config
  (exec-path-from-shell-initialize))

(provide 'my-osx)
;;; my-osx.el ends here
