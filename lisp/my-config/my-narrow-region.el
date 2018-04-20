(put 'narrow-to-region 'disabled nil)
(my-leader
  "bn" '(:ignore t :which-key "narrow")
  "bnn" 'narrow-to-region
  "bnr" 'narrow-to-region
  "bnf" 'narrow-to-defun
  "bnF" 'narrow-to-defun-include-comments
  "bnw" 'widen
  "bnN" 'widen)
