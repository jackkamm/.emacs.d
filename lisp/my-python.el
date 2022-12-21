;;; my-python.el --- Python config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--simple-prompt -i")

(with-eval-after-load 'python
  (add-to-list
   'python-shell-completion-native-disabled-interpreters
   "jupyter"))

(my-major-leader
  :keymaps 'python-mode-map
  "'" 'run-python
  "\"" 'my-run-jupyter-existing
  "b" 'python-shell-send-buffer
  "f" 'python-shell-send-defun
  "r" 'python-shell-send-region)

(use-package pyvenv)

(use-package cython-mode)

(use-package yapfify
  :init
  (my-major-leader
    :keymaps 'python-mode-map
    "y" 'yapfify-buffer))

(defun my-run-python-dtach ()
  (interactive)
  (let* ((socket-file (read-file-name "dtach socket file: "))
         (default-directory (file-name-directory socket-file)))
    (run-python
     (concat "dtach -A " (file-name-nondirectory socket-file)
             " ipython --simple-prompt -i")
     nil t)))

(provide 'my-python)
;;; my-python.el ends here
