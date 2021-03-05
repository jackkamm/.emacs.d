(mapc 'load
      (list
       "my-org"

       "my-ide" ;lsp, projectile, xref, company, flycheck
       "my-tramp"
       "my-shell"
       "my-snippets"

       "my-email-chat"

       ;; languages
       "my-python"
       ;;"my-clojure"
       "my-literate-programming"
       "my-R"
       "my-julia"
       "my-tex"
       ;; c-c++: only enable 1 of cquery, rtags
       ;;"my-cquery"
       ;;"my-rtags"

       ;; other miscellaneous settings
       "my-extra"))
