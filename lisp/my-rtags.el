;; build rtags manually to avoid rebuilding whenever updating AUR/ELPA/etc
;; build instructions:
;; git clone --recursive https://github.com/Andersbakken/rtags.git
;; cd rtags; mkdir build; cd build
;; cmake -DCMAKE_INSTALL_PREFIX=~/.local ..
;; make
;; make install

;; before using rtags in a project, must index it like:
;; rc -J compile_commands.json
;; (compile_commands.json from cmake, bear, or python-scan-build)

(use-package rtags
  :commands rtags-start-process-unless-running
  :init
  (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
  :config
  (my-major-leader
    :keymaps 'c-mode-base-map
    "d" 'rtags-find-symbol
    "r" 'rtags-find-references
    "R" 'rtags-rename-symbol)

  (with-eval-after-load 'company
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t)
    (push 'company-rtags company-backends))

  (with-eval-after-load "my-helm"
    (use-package helm-rtags :config
      (setq rtags-display-result-backend 'helm)))

  ;; FIXME: flycheck-rtags not working...
  (require 'flycheck-rtags)
  (defun my-flycheck-rtags-setup ()
    (flycheck-select-checker 'rtags)
    ;; RTags creates more accurate overlays.
    (setq-local flycheck-highlighting-mode nil)
    (setq-local flycheck-check-syntax-automatically nil))
  (add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup))

(use-package flycheck-rtags :defer t)

