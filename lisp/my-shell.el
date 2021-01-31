;; term-mode configuration

(with-eval-after-load 'term
  (add-hook 'term-mode-hook (lambda () (display-line-numbers-mode 0)))
  (evil-set-initial-state 'term-mode 'emacs))

;; Running in screen improves term-mode performance
;; https://www.reddit.com/r/emacs/comments/88yzp4/better_way_to_run_terminals_in_emacs/
(defun my-screen-term () (interactive) (term "/bin/screen"))

(defun my-screen-yank ()
  "Yank the screen paste buffer into emacs"
  (interactive)
  (let ((tramp-prefix (file-remote-p default-directory)))
    (call-process "/bin/screen" nil nil nil "-X" "writebuf" "/tmp/screen-exchange")
    (with-temp-buffer
      (insert-file-contents (concat tramp-prefix "/tmp/screen-exchange"))
      (kill-ring-save (point-min) (point-max)))))

;; execute shell commands

(defun my-external-command (cmd)
  (interactive
   (list
    (read-shell-command "Shell command: ")))
  (call-process-shell-command cmd nil 0))

(my-leader
  "d" '(:ignore t :which-key "Command")
  "dd" 'my-external-command
  "d!" 'shell-command
  "d&" 'async-shell-command)

;; send lines from .sh files to *shell* buffer

(require 'essh)

(my-major-leader
  :keymaps 'sh-mode-map
  "b" 'pipe-buffer-to-shell
  "r" 'pipe-region-to-shell
  "l" 'pipe-line-to-shell
  "j" 'pipe-line-to-shell-and-step
  "f" 'pipe-function-to-shell
  "d" 'shell-cd-current-directory)

;; tmux

(use-package emamux
  :init
  (setq
   ;; for tmux version >= 2 (breaks emamux:yank on tmux < 2)
   emamux:show-buffers-with-index nil
   emamux:get-buffers-regexp
   "^\\(buffer[0-9]+\\): +\\([0-9]+\\) +\\(bytes\\): +[\"]\\(.*\\)[\"]")
  :general
  (my-leader
    "dx" '(:keymap emamux:keymap :which-key "tmux"))
  :config
  (defun my-emamux-send-region (start end)
    (interactive "r")
    (let ((buf-str (buffer-substring start end))
          (mode major-mode))
      (with-temp-buffer
        (funcall mode)
        (insert buf-str)
        (goto-char (point-min))
        (comment-kill (count-lines (point-min) (point-max)))
        (emamux:send-region (point-min) (point-max)))))

  (defun my-emamux-send-buffer ()
    (interactive)
    (my-emamux-send-region (point-min) (point-max)))

  (defun my-emamux-send-line ()
    (interactive)
    (my-emamux-send-region (line-beginning-position) (line-end-position)))

  (defun my-emamux-yank ()
    (interactive)
    (emamux:check-tmux-running)
    (with-temp-buffer
      (emamux:tmux-run-command t "show-buffer")
      (kill-region (point-min) (point-max))))

  (bind-keys
   :map emamux:keymap
   ("r" . my-emamux-send-region)
   ("l" . my-emamux-send-line)
   ("b" . my-emamux-send-buffer)
   ("y" . my-emamux-yank))

  (with-eval-after-load 'polymode
    (defun my-emamux-send-chunk ()
      (interactive)
      (deactivate-mark)
      (polymode-mark-or-extend-chunk)
      (emamux:send-region (region-beginning) (region-end))
      (deactivate-mark))
    (bind-keys
     :map emamux:keymap
     ("c" . my-emamux-send-chunk))))

;; keybindings in terminal frames

;; use git submodule instead?
(add-to-list 'package-archives
             '("cselpa" . "https://elpa.thecybershadow.net/packages/"))

(use-package term-keys
  :config
  (term-keys-mode t))
