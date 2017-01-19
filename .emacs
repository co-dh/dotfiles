; (add-to-list 'load-path "~/.emacs.d/lisp/benchmark-init-el/")
; (require 'benchmark-init-loaddefs)
; (benchmark-init/activate)
(menu-bar-mode -1)
(show-paren-mode t)
(global-hl-line-mode t)
(column-number-mode t)
(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(setq inhibit-startup-screen t
      initial-scratch-message nil
      make-backup-files nil
      use-dialog-box nil
      visible-bell nil
      echo-keystrokes 0.1)
(defalias 'yes-or-no-p 'y-or-n-p)
;(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(modify-syntax-entry ?- "w")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(require 'diminish)
(use-package use-package-chords :config (key-chord-mode 1))
(use-package evil		:config (evil-mode t) (evil-set-toggle-key "C-="))
(use-package org-bullets	:config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(use-package magit		:chords (("ms" . magit-status)))
(use-package linum-mode		:chords (("nt" . linum-mode)))
(use-package linum-relative :config (linum-relative-mode))
(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.04)
  :chords
  (" b" . switch-to-buffer) 
  (" w" . save-buffer)
  ("cv" . customize-variable) 
  ("kw" . delete-window) 
  ("ps" . split-window-vertically) 
  ("sv" . split-window-horizontally)
  )

(use-package company
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.01
	company-minimum-prefix-length 2))

(use-package ivy
  :config (ivy-mode 1) (setq ivy-use-virtual-buffers t)
  :chords ((" s" . swiper)
	   (" x" . counsel-M-x)
	   (" p" . counsel-find-file)
	   (" a" . counsel-ag)
	   ("hf" . counsel-describe-function)
	   ("hv" . counsel-describe-variable)
	   ("hl" . counsel-find-library)
	   (" g" . counsel-git)
	   (" l" . counsel-locate)
	   ))

(use-package window-numbering :config (window-numbering-mode t)
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
  :chords ((" 1" . select-window-1) 
	   (" 2" . select-window-2) 
	   (" 3" . select-window-3) 
	   (" 4" . select-window-4) 
	   (" 5" . select-window-5)
	   (" 6" . select-window-6)
	   (" 7" . select-window-7)
	   (" 8" . select-window-8)
	   (" 9" . select-window-9)
	   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(org-babel-load-languages (quote ((python . t) (q . t) (emacs-lisp . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (use-package-chords counsel ivy org-bullets company magit key-chord spacemacs-theme linum-relative evil evil-numbers window-numbering ag multi-term))))
 (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata-g" :foundry "PfEd" :slant normal :weight normal :height 83 :width normal)))))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'q-mode "q-mode")
(add-to-list 'auto-mode-alist '("\\.[kq]\\'" . q-mode))





