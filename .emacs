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
(modify-syntax-entry ?_ "w")
(setq-default indent-tabs-mode nil)
(setq select-enable-primary t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/dotfiles/")
(autoload 'q-mode "q-mode")
(add-to-list 'auto-mode-alist '("\\.[kq]\\'" . q-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(font-use-system-font t)
 '(org-babel-load-languages (quote ((python . t) (q . t) (emacs-lisp . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (smart-mode-line linum-relative ivy-hydra hydra use-package-chords counsel ivy org-bullets company magit key-chord spacemacs-theme evil evil-numbers window-numbering ag multi-term)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata-g for Powerline" :foundry "PfEd" :slant normal :weight normal :height 90 :width normal)))))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(global-set-key (kbd "M-b") 'switch-to-buffer)
(global-set-key (kbd "M-w") 'save-buffer)
(global-set-key (kbd "M-r") 'swiper)
(global-set-key (kbd "M-p") 'counsel-find-file)
(global-set-key (kbd "C-a") 'counsel-ag)
(global-set-key (kbd "M-t") 'counsel-git)
(global-set-key (kbd "M-l") 'counsel-locate)

(eval-when-compile (require 'use-package))
(use-package key-chord
  :config
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.03))
(use-package use-package-chords :config (key-chord-mode 1))
(use-package evil		:config (evil-mode t) (evil-set-toggle-key "C-="))
(use-package org-bullets	:config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(use-package magit		:chords (("ms" . magit-status)))
(use-package linum-mode		:chords (("nt" . linum-mode)))
(use-package linum-relative :config (linum-relative-mode)
  :chords (("cv" . customize-variable) 
           ("kw" . delete-window) 
           ("ps" . split-window-vertically) 
           ("sv" . split-window-horizontally))
   )

(use-package company
  :config
  (global-company-mode t)
  (setq company-idle-delay 0 
	company-minimum-prefix-length 2))

(use-package ivy
  :config (ivy-mode 1) (setq ivy-use-virtual-buffers t)
  :chords (
	   ("hf" . counsel-describe-function)
	   ("hv" . counsel-describe-variable)
	   ("hl" . counsel-find-library)
	   )
  )

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
  )

(defun recalc ()
  (interactive)
  (org-table-recalculate 'ALL))
(global-set-key (kbd "C-l") 'recalc)

(sml/setup)
