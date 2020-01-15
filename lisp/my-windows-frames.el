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
 "d" 'delete-frame)

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
  ("w" evil-window-next)
  ("W" evil-window-prev))

(bind-keys
 :map evil-window-map
 ("m" . delete-other-windows)
 ("d" . delete-window)
 ("u" . my-winner-hydra/winner-undo)
 ("U" . my-winner-hydra/winner-redo)
 ("w" . my-winner-hydra/evil-window-next)
 ("W" . my-winner-hydra/evil-window-prev))

(use-package ace-window
  :bind
  (:map evil-window-map
   ("SPC" . ace-select-window)
   ("D" . ace-delete-window)
   ("M" . ace-swap-window))
  :config
  (set-face-attribute
     'aw-leading-char-face nil
     :weight 'bold
     :height 2.0))

(setq help-window-select t)

;; display-buffer customizations

(defun my-display-buffer (buffer alist)
  (require 'ace-window)
  (let ((aw-ignore-current (cdr (assq 'inhibit-same-window alist)))
        (aw-scope (pcase (cdr (assq 'reusable-frames alist))
                    ((pred not) 'frame)
                    ('visible 'visible)
                    ((or 0 (pred (eql t))) 'global)
                    (_ nil))))
    (unless (or (<= (length (aw-window-list)) 1)
                (not aw-scope))
      (window--display-buffer
       buffer (aw-select "my-display-buffer") 'reuse))))

(setq display-buffer-base-action '((display-buffer-reuse-window
                                    my-display-buffer))
      display-buffer-alist '(("\\*help\\[R" (display-buffer-reuse-mode-window
                                             my-display-buffer)
                              (reusable-frames . nil))
                             ("\\*R" nil (reusable-frames . nil))
                             ;;("\\*helm"
                             ;; ;; see also: `helm-split-window-default-fn'
                             ;; (display-buffer-pop-up-window))
                             ("magit-diff:" (my-display-buffer)
                              (inhibit-same-window . t))))
