;;; Completion

;; TODO Switch to corfu?

(use-package company
  :demand t
  :config
  ;; https://emacs.stackexchange.com/questions/13286/how-can-i-stop-the-enter-key-from-triggering-a-completion-in-company-mode
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "M-RET") #'company-complete-selection)

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
