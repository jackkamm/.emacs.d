;; Setup packages and paths
(load (concat user-emacs-directory "lisp/my-early-init.el"))

(mapc 'load
      (list
	 ;;; load first -- all modules depend on it
       "my-core" ;evil, general, which-key, hydra

         ;;; load next to ensure org-plus-contrib
       "my-org"

         ;;; completion system, only enable 1
       ;;"my-helm"
       "my-ivy"

	;;; editing
       ;;"my-evil-collection"
       "my-buffers-files" ;includes dired, diff'ing
       "my-windows-frames"
       "my-lines-regions" ;line numbers/wrapping, parens, narrowing, etc
       "my-motions-jumping" ;avy, easymotion
       "my-search-replace" ;iedit/mc,swoop/projectile,narrowing,wgrep
       "my-ide" ;completion, syntax-checking, LSP, xref
       "my-git"
       "my-snippets"
       "my-undo"

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

;; Extra gitignore'd configuration
(let ((config-el "~/.emacs.d/config.el"))
  (when (file-exists-p config-el)
    (load config-el)))
