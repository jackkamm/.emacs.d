;; term-mode configuration

(with-eval-after-load 'term
  (add-hook 'term-mode-hook (lambda () (display-line-numbers-mode 0)))
  (evil-set-initial-state 'term-mode 'emacs)
  (advice-add 'term-line-mode :after #'evil-motion-state)
  (advice-add 'term-char-mode :after #'evil-emacs-state))

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

;; TODO is this still needed?
;; workaround for https://lists.gnu.org/archive/html/bug-gnu-emacs/2019-03/msg00326.html
(defun my-read-shell-command-advice (&rest args)
  (setq-default comint-input-autoexpand nil))
(advice-add 'read-shell-command :after 'my-read-shell-command-advice)

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

(use-package emamux
  :custom
  ;; for tmux version >= 2 (breaks emamux:yank on tmux < 2)
  (emamux:show-buffers-with-index nil)
  (emamux:get-buffers-regexp
   "^\\(buffer[0-9]+\\): +\\([0-9]+\\) +\\(bytes\\): +[\"]\\(.*\\)[\"]")
  :general
  (my-leader
    "z" '(:keymap emamux:keymap :which-key "tmux"))
  :config
  (bind-keys
   :map emamux:keymap
   ("z" . emamux:send-region)))
