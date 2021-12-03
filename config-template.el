;; Install desired org-mode version before initializing other
;; packages, to avoid accidentally using the wrong version
(use-package org
  ;; Load org immediately, as an extra precaution against version
  ;; conflicts, e.g. if a new package installs a different version of
  ;; org before it's loaded. Comment/remove to improve startup time
  :demand t

  ;; use emacs built-in version
  :ensure nil

  ;;;; use melpa version
  ;;:ensure org-plus-contrib

  ;;;; use local dev version
  ;;:ensure nil
  ;;:load-path ("~/dev/org-mode/lisp"
  ;;            "~/dev/org-mode/contrib/lisp")

  :custom
  (org-agenda-files '("~/org")))

(load "my-base")
;;(load "my-config")
