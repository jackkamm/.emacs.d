;;; Completion

(use-package company
  :demand t
  :config
  (global-company-mode 1))

(use-package helm-company)

(pcase my-completing-read-style
  (`ivy
   (my-leader "C" 'counsel-company))
  ((or `helm `hybrid)
   (my-leader "C" 'helm-company))
  (_
   (my-leader "C" 'company-complete)))

(use-package company-prescient
  :after company
  :demand t
  :config
  (company-prescient-mode))
