(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--simple-prompt -i")

(with-eval-after-load 'python
  (add-to-list
   'python-shell-completion-native-disabled-interpreters
   "jupyter"))

(my-major-leader
  :keymaps 'python-mode-map
  "'" 'run-python
  "\"" 'my-run-jupyter-existing)

(use-package elpy
  :commands elpy-enable
  :init
  (with-eval-after-load 'python
    (elpy-enable)))

(use-package ipython-shell-send
  :commands (ipython-shell-send-region
	     ipython-shell-send-buffer
	     ipython-shell-send-defun
	     ipython-shell-send-file)
  :general
  (my-major-leader
    :keymaps 'python-mode-map
    "b" 'ipython-shell-send-buffer
    "f" 'ipython-shell-send-defun
    "r" 'ipython-shell-send-region))

(use-package pyvenv
  :commands (pyvenv-activate
	     pyvenv-workon))

(use-package cython-mode
  :mode (("\\.pyx\\'" . cython-mode)
	 ("\\.pxd\\'" . cython-mode)))

(use-package yapfify
  :commands (yapfify-buffer)
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
