;;; my-windows-frames.el --- Windows and frames  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq my-frames-map (make-sparse-keymap))
(general-create-definer my-frames-leader :prefix-map 'my-frames-map)
(my-leader "F" '(:keymap my-frames-map :which-key "Frames"))

(defun my-pop-window ()
  (interactive)
  (let ((buffer (current-buffer))
        (window (selected-window)))
    (make-frame)
    (delete-window window)))

(my-frames-leader
 "n" 'make-frame
 "p" 'my-pop-window
 "d" 'delete-frame
 "o" 'other-frame)

(my-leader
  "w" '(evil-window-map :which-key "Window"))

(bind-keys
 :map evil-window-map
 ((kbd "<down>") . evil-window-down)
 ((kbd "<up>") . evil-window-up)
 ((kbd "<right>") . evil-window-right)
 ((kbd "<left>") . evil-window-left))

(winner-mode)
(defhydra my-winner-hydra ()
  "winner"
  ("u" winner-undo)
  ("U" winner-redo)
  ("o" evil-window-next)
  ("O" evil-window-prev))

(bind-keys
 :map evil-window-map
 ("m" . delete-other-windows)
 ("d" . delete-window)
 ("u" . my-winner-hydra/winner-undo)
 ("U" . my-winner-hydra/winner-redo)
 ("o" . my-winner-hydra/evil-window-next)
 ("O" . my-winner-hydra/evil-window-prev))

(use-package ace-window
  :bind
  (:map evil-window-map
   ("w" . ace-select-window)
   ("D" . ace-delete-window)
   ("M" . ace-swap-window))
  :config
  (set-face-attribute
     'aw-leading-char-face nil
     :weight 'bold
     :height 2.0))

(setq help-window-select t)

;; display-buffer customizations

(defun my-ace-display-buffer-2 (buffer alist)
  (let ((aw-dispatch-always t))
    (ace-display-buffer buffer alist)))

(setq display-buffer-base-action '((display-buffer-reuse-window
                                    ace-display-buffer))
      display-buffer-alist `(("\\*help\\[R" (display-buffer-reuse-mode-window
                                             my-ace-display-buffer-2))
                             ;;;; Control which frame to display *R*
                             ;;;; https://ess.r-project.org/Manual/ess.html#Controlling-buffer-display
                             ;;("*R" (display-buffer-reuse-window)
                             ;; (reusable-frames . 0))
                             ("\\*Org Src" (display-buffer-reuse-window
                                            my-ace-display-buffer-2)
                              (inhibit-same-window . nil))
                             ;; TODO this doesn't work because
                             ;; org-mode sets display-buffer-alist nil
                             ;; before popping up this buffer
                             ("\\*Org Select" (display-buffer-pop-up-window))
                             ;; see also: `helm-split-window-default-fn'
                             ,(cons "\\*helm" display-buffer-fallback-action)
                             ;;("\\*helm" (display-buffer-pop-up-window))
                             ("magit-diff:" nil
                              (inhibit-same-window . t))))

;; tabs

(customize-set-variable 'tab-bar-new-tab-choice "*scratch*")

(provide 'my-windows-frames)
;;; my-windows-frames.el ends here
