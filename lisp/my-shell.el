;;; my-shell.el --- Shell config  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:



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

;; Slurm likes to add 2 carriage returns to output, which breaks
;; ansi-term directory tracking. (term.el will remove one of the
;; carriage returns, but not the second one). The following advice
;; removes these troublesome carriage returns. See also:
;;
;; https://slurm.schedmd.com/faq.html#unbuffered_cr
;;
;; TODO: File bug report to emacs for this

(defun my-term-messages-advice (orig-fun message)
  (funcall orig-fun (replace-regexp-in-string "\r+\n$" "\n" message)))

(advice-add 'term-handle-ansi-terminal-messages :around 'my-term-messages-advice)

(define-minor-mode my-ignore-term-command-hook-mode
  "Minor mode to ignore term-command-hook.

As described in term.el, there are two mechanisms for directory
tracking, `term-command-hook' which works well by default, and
`term-handle-ansi-terminal-messages', which allows for greater
customization and features like remote directory tracking. These
2 mechanisms may sometimes conflict; this minor mode disables
`term-command-hook' to prevent it from overriding
`term-handle-ansi-terminal-messages'."
  :global t
  (if my-ignore-term-command-hook-mode
      (advice-add #'term-command-hook :override
                  #'my-ignore-term-command-hook-advice)
    (advice-remove #'term-command-hook #'my-ignore-term-command-hook-advice)))

(defun my-ignore-term-command-hook-advice (string))

;; vterm

(use-package vterm
  :commands 'vterm
  :general
  (my-major-leader
    :keymaps 'vterm-mode-map
    "[" 'vterm-copy-mode
    "q" 'vterm-send-next-key)
  :config
  (evil-set-initial-state 'vterm-mode 'emacs)
  (add-hook 'vterm-mode-hook
            (lambda () (display-line-numbers-mode -1)))
  (add-hook 'vterm-copy-mode-hook
            (lambda ()
              (if vterm-copy-mode
                  (evil-normal-state)
                (evil-emacs-state))))

  ;; See also:
  ;; https://www.reddit.com/r/emacs/comments/op4fcm/comment/h63i4f3
  (defun my-vterm-eval-region (start end)
    "Insert text of current line in vterm and execute."
    (interactive "r")
    (let ((command (buffer-substring start end)))
      ;; TODO strip comments, like in `my-emamux-send-region'
      (if (get-buffer vterm-buffer-name)
          (with-current-buffer vterm-buffer-name
            (vterm--goto-line -1)
            (vterm-send-string command)
            (vterm-send-return))
        (message "%s doesn't exist!" vterm-buffer-name))))

  (defun my-vterm-eval-line ()
    (interactive)
    (my-vterm-eval-region (line-beginning-position) (line-end-position)))

  (defun my-vterm-eval-buffer ()
    (interactive)
    (my-vterm-eval-region (point-min) (point-max)))

  (my-leader
    "dv" '(:ignore t :which-key "Vterm")
    "dvl" 'my-vterm-eval-line
    "dvb" 'my-vterm-eval-buffer
    "dvr" 'my-vterm-eval-region))

;; eat

(use-package eat
  :commands 'eat
  :config
  (evil-set-initial-state 'eat-mode 'emacs)
  (defun my-eat-eval-region (start end)
    (interactive "r")
    (let ((command (buffer-substring start end)))
      (with-current-buffer eat-buffer-name
        (eat-term-send-string eat-terminal command)
        (eat-self-input 1 'return))))

  (defun my-eat-eval-line ()
    (interactive)
    (my-eat-eval-region (line-beginning-position) (line-end-position)))

  (defun my-eat-eval-buffer ()
    (interactive)
    (my-eat-eval-region (point-min) (point-max)))

  (define-minor-mode my-eat-copy-mode
    "Enable line mode and enter normal state in eat buffer."
    :global nil
    (if my-eat-copy-mode
        (progn
          (eat-semi-char-mode)
          (evil-emacs-state)
          (end-of-buffer))
      (eat-line-mode)
      (evil-normal-state)))

  (my-major-leader
    :keymaps 'eat-mode-map
    "[" 'my-eat-copy-mode)

  (my-leader
    "de" '(:ignore t :which-key "Eat")
    "del" 'my-eat-eval-line
    "deb" 'my-eat-eval-buffer
    "der" 'my-eat-eval-region))

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

(provide 'my-shell)
;;; my-shell.el ends here
