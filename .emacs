; (add-to-list 'load-path "~/.emacs.d/lisp/benchmark-init-el/")
; (require 'benchmark-init-loaddefs)
; (benchmark-init/activate)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-global-modes t)
 '(company-idle-delay 0.01)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers nil)
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(echo-keystrokes 0.1)
 '(evil-mode t)
 '(evil-toggle-key "C-=")
 '(evil-want-C-i-jump nil)
 '(flx-ido-mode t)
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(ido-cr+-max-items 6000)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(ido-ubiquitous-mode t)
 '(ido-use-virtual-buffers t)
 '(ido-vertical-define-keys (quote C-n-and-C-p-only))
 '(ido-vertical-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(org-babel-load-languages (quote ((python . t) (q . t) (emacs-lisp . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (org-bullets company magit key-chord spacemacs-theme linum-relative evil flx-ido ido-vertical-mode ido-ubiquitous smex evil-numbers window-numbering ag multi-term)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(use-dialog-box nil)
 '(visible-bell nil)
 '(window-numbering-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata-g" :foundry "PfEd" :slant normal :weight normal :height 83 :width normal)))))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'q-mode "q-mode")
(add-to-list 'auto-mode-alist '("\\.[kq]\\'" . q-mode))

(defalias 'yes-or-no-p 'y-or-n-p)

(key-chord-mode t)
(setq key-chord-two-keys-delay 0.04)
(mapcar (lambda (x) (key-chord-define-global (car x) (cdr x)))
	'((" w" . save-buffer)
	  (" p" . find-file) 
	  (" b" . switch-to-buffer) 
	  (" x" . smex) 
	  (" 1" . select-window-1) 
	  (" 2" . select-window-2) 
	  (" 3" . select-window-3) 
	  (" 4" . select-window-4) 
	  (" 5" . select-window-5) 
	  ("sp" . split-window-vertically) 
	  ("vs" . split-window-horizontally) 
	  ("kw" . delete-window) 
	  ("dw" . kill-word) 
	  ))

(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(window-numbering-mode t)
(modify-syntax-entry ?- "w")

(defun select-window-by-number (i &optional arg)
  "Select window given number I by `window-numbering-mode'.
If prefix ARG is given, delete the window instead of selecting it."
  (interactive "P")
  (let ((windows (car (gethash (selected-frame) window-numbering-table)))
	window)
    (if (and (>= i 0) (< i 10)
	     (setq window (aref windows i)))
	(select-window window)
      (error "No window numbered %s" i))))

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
