(use-package tex
  :defer t
  :ensure auctex
  :general
  (my-major-leader
    :keymaps 'LaTeX-mode-map
    "m" 'TeX-command-master
    "e" 'LaTeX-environment)
  (my-eval-leader
    :keymaps 'LaTeX-mode-map
    "e" 'TeX-command-master))

;; helm \includegraphics looks in local directory,
;; instead of TeX search path
(setq LaTeX-includegraphics-read-file
      'LaTeX-includegraphics-read-file-relative)

;; set okular as default pdf viewer in linux
(with-eval-after-load 'tex
  (when (eq system-type 'gnu/linux)
          (add-to-list 'TeX-view-program-selection
                       '(output-pdf "Okular"))))