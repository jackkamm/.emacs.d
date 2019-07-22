;; set $PATH, e.g. when starting from OSX or systemd
;; For systemd, it's preferred to set variables in ~/.config/environment.d/,
;; but this doesn't work for $PATH in Ubuntu 18.04
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package keychain-environment
  :config
  (keychain-refresh-environment))

;; For profiling startup times
;; NOTE broken: https://github.com/jschaf/esup/issues/53
;;(use-package esup :commands esup)
