;; NOTE ~/.emacs takes precedence over this file;
;; so to use a different config, copy this file to ~/.emacs and adjust it,
;; or load this file from ~/.emacs and add additional configurations.

;; Bootstrap setup and load "core" modules
(load (concat user-emacs-directory "lisp/my-init.el"))

;; load extra modules not included in my-init.el
(mapc 'load
      (list
       ;; applications
       "my-email"
       "my-irc"
       "my-tramp"
       "my-shell"
       "my-startup" ;path, keychain, profiler
       "my-docker"

       ;; theming
       "my-theme"
       "my-emoji"
       "my-osx"
       ;;"my-hidpi"

       ;; languages
       "my-python"
       ;;"my-clojure"
       "my-literate-programming"
       "my-R"
       "my-julia"
       "my-emacs-lisp"
       "my-tex"
       "my-web"
       "my-yaml"
       ;; c-c++: only enable 1 of cquery, rtags
       ;;"my-cquery"
       ;;"my-rtags"
       "my-lang-misc"
       ))

(load-theme 'moe-dark t)
