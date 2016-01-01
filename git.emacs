(put 'upcase-region 'disabled nil)
(setq inhibit-splash-screen t)
(setq line-move-visual nil)
(setq disabled-command-function nil)
(setq backup-directory-alist
'(("." . "~/.emacs_backups")))

;; Shows bom in utf8 encoded files where the bom has been improperly shown.
(setq auto-coding-regexp-alist
  (delete (rassoc 'utf-16be-with-signature auto-coding-regexp-alist)
  (delete (rassoc 'utf-16le-with-signature auto-coding-regexp-alist)
  (delete (rassoc 'utf-8-with-signature auto-coding-regexp-alist)
          auto-coding-regexp-alist))))

(custom-set-variables
 '(backup-by-copying-when-linked t)
 '(scroll-step 1)`
 '(backup-by-copying-when-mismatch t)
 '(auto-save-default t)
 '(column-number-mode t)
 '(enable-multibyte-characters t)
 )

;; Custom keymap
(global-set-key (kbd "<f4>") 'kmacro-set-format)
(global-set-key (kbd "<f5>") 'kmacro-insert-counter)
(global-set-key (kbd "<f6>") 'kmacro-set-counter)
(global-set-key (kbd "M-<f6>") 'init-macro-counter-default)
(global-set-key [insert] 'ovwrt-override)
(global-set-key [kp-insert] 'ovwrt-override)
(global-set-key "\C-x\C-a" 'single-quote-word)
(global-set-key "\C-ca" 'insert-date)
(global-set-key "\C-x\C-w" 'count-words)
(global-set-key "\C-x\C-d" 'delete-5)
(global-set-key "\C-cd" 'wrap-delete)
(global-set-key "\C-c\c" 'cust-clean)
(global-set-key "\C-cr" 'addrtimes)
(global-set-key "\C-c\C-q" 'quote-region)
(global-set-key "\C-cq" 'single-quote-region)
(global-set-key "\C-cb" 'switch-to-buffer-other-frame)
(global-set-key "\C-cc" 'kill-ring-save)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)



(defun init-macro-counter-default ()
  "Set the initial counter to 1 and reset every time it's called.
To set to a different value call `kmacro-set-counter' interactively
i.e M-x kmacro-set-counter."
  (interactive)
  (kmacro-set-counter 1))

(defvar insert-date-format "%x"
  "*Format for \\[insert-date] (c.f. 'format-time-string).")


(defun suspend-frame-q ()
  (interactive)
  (let ((tog 0) (msg "Suspend Buffer? "))
    (if (y-or-n-p msg)
	(progn(suspend-frame))
      (setq tog (1+ tog)))
    (if (> tog 0)
	(clear-echo))))

(defun ovwrt-override ()
  (interactive)
  (let ((tog 0) (msg "Enter Overwrite mode? ") (msg1 "Exit Overwrite mode? "))
    (if (overwrite-mode 1)
	(if (y-or-n-p-with-timeout msg1 3 t)
      (progn(overwrite-mode 1) (setq tog (1+ tog)))
     (progn(overwrite-mode -1)(setq tog (1+ tog))))
  (if (> tog 0)
      (clear-echo)))))

(defun clear-echo ()
  (if (current-message)
  (run-with-idle-timer 3 1 'message nil)))

(defun wrap-delete ()
(interactive)
(progn (push-mark) (forward-word 1) (backward-word 1) (delete-region (mark) (point))(insert" ")))

(defun count-words ()
  (interactive)
  (save-excursion
	(let ((count 0))
	 (goto-char (point-min))
	(while (< (point) (point-max))
	  (forward-word 1)
	  (setq count (1+ count)))
	  (message "This bugger contains %d words, mate!" count))))

(defun insert-date ()
  (interactive "*")
  (insert (format-time-string insert-date-format
			      (current-time))))
(defun  quote-region ()
(interactive)
(progn transient-mark-mode 1)
(progn (goto-char (region-beginning)))
(while (not (= (point) (region-end)))
(move-beginning-of-line 1) (insert "\"") (move-end-of-line 1) (insert "\"") (forward-line 1))
(progn (transient-mark-mode -1)))

(defun single-quote-word ()
(interactive)
(progn
(backward-word 1) (insert "\'") (forward-word 1) (insert "\'")))


(defun single-quote-region ()
(interactive)
(progn transient-mark-mode 1)
(progn (goto-char (region-beginning)))
(while (not (= (point) (region-end)))
(move-beginning-of-line 1) (insert "\'")(move-end-of-line 1)(insert "\'")(forward-line 1))(progn (transient-mark-mode -1)))


(defun buff-kill ()
  (interactive)
  (kill-region (point-min) (point-max)))

;; Helps set up for .rst docs
(defun symbolize_string  (str symbol)
  (interactive "sEnter the string to be symbolized: \nsEnter symbol")
  (insert (make-string (length str) (aref symbol 0))))

