(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--simple-prompt -i")

(with-eval-after-load 'python
  (add-to-list
   'python-shell-completion-native-disabled-interpreters
   "jupyter"))

(defun my-run-jupyter-existing (cmd dedicated)
  (interactive
   (list
    (read-shell-command
     "Run Python: "
     "jupyter console --simple-prompt --existing")
    (y-or-n-p "Make dedicated process? ")))
  (run-python cmd dedicated t))

(my-major-leader
  :keymaps 'python-mode-map
  "'" 'run-python
  "\"" 'my-run-jupyter-existing)

(use-package anaconda-mode
  :defer t
  :init
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  :config
  (evil-set-initial-state 'anaconda-view-mode 'motion))

(use-package ipython-shell-send
  :commands (ipython-shell-send-region
	     ipython-shell-send-buffer
	     ipython-shell-send-defun
	     ipython-shell-send-file)
  :general
  (my-eval-leader
    :keymaps 'python-mode-map
    "b" 'ipython-shell-send-buffer
    "f" 'ipython-shell-send-defun
    "r" 'ipython-shell-send-region
    "e" 'ipython-shell-send-region))

(use-package pyvenv
  :commands (pyvenv-activate
	     pyvenv-workon))

(use-package pipenv
  :commands (pipenv-activate
	     pipenv-deactivate
	     pipenv-shell
	     pipenv-open
	     pipenv-install
	     pipenv-uninstall))

(use-package cython-mode
  :mode (("\\.pyx\\'" . cython-mode)
	 ("\\.pxd\\'" . cython-mode)))
