;; try to make tramp+git faster
(setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)"
				    vc-ignore-dir-regexp
				    tramp-file-name-regexp))

;; use correct path when executing code block in remote :dir
;; or using eshell
(with-eval-after-load 'tramp-sh
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))
