;;;; Install desired org-mode version before initializing other
;;;; packages, to avoid accidentally using the wrong version
;;(use-package org
;;  ;;;; Uncomment the below to load immediately, as an extra precaution
;;  ;;;; against version conflicts. For example, when a new package is
;;  ;;;; installed, it might pull org as a dependency and shadow it if
;;  ;;;; it hasn't yet been loaded
;;  ;;:demand t
;;
;;  ;;;; use local dev version
;;  ;;:ensure nil
;;  ;;:load-path ("~/Documents/org-mode/lisp"
;;  ;;            "~/Documents/org-mode/contrib/lisp")
;;
;;  ;; use melpa version
;;  :ensure org-plus-contrib)

(load "my-base")
;;(load "my-config")
