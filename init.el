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
       "my-files" ;dired, find-files
       "my-buffers"
       "my-search-replace" ;iedit/mc,swoop/projectile,narrowing,wgrep
       "my-jump" ;avy, easymotion, xref
       "my-display" ;window, frame
       "my-syntax-checking" ;flycheck
       "my-git"
       "my-ediff"
       "my-snippets"
       "my-company"
       "my-undo"
       "my-parens"
       "my-region"
       "my-lines" ;linenum, visual-line-mode
       "my-lsp"

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
