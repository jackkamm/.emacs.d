(if (eq system-type 'gnu/linux)
    (setq browse-url-browser-function 'browse-url-generic
	  browse-url-generic-program "xdg-open"))
;; TODO: use "open" on macOS
