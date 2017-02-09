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
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(font-use-system-font t)
 '(org-babel-load-languages (quote ((python . t) (q . t) (emacs-lisp . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (smex smart-mode-line linum-relative ivy-hydra hydra counsel ivy org-bullets company magit spacemacs-theme evil evil-numbers window-numbering ag multi-term)))
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

; (global-set-key (kbd "M-r") 'swiper)
; (global-set-key (kbd "M-p") 'counsel-find-file)
(global-set-key (kbd "C-s") 'save-buffer)

(eval-when-compile (require 'use-package))
(use-package evil		:config (evil-mode t) (evil-set-toggle-key "C-=") :diminish undo-tree-mode)
(use-package org-bullets	:config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(use-package magit	:bind ("M-s t" . magit-status))
(use-package linum-mode		)
(use-package linum-relative :config (linum-relative-mode))

(use-package company
  :diminish company-mode
  :config
  (global-company-mode t)
  (setq company-idle-delay 0 
	company-minimum-prefix-length 2))

(use-package ivy
  :diminish ivy-mode
  :config (ivy-mode 1) (setq ivy-use-virtual-buffers t)
  :bind
  ("M-x" . counsel-M-x)
  ("M-b" . ivy-switch-buffer)
  ("C-a" . counsel-ag)
  ("C-p" . counsel-git)
  )

(use-package window-numbering :config (window-numbering-mode t))
(defun recalc ()
  (interactive)
  (org-table-recalculate 'ALL))
(global-set-key (kbd "C-l") 'recalc)

(sml/setup)
(delete "/usr/share/emacs/25.1/lisp/play" load-path)
(setq company-dabbrev-downcase nil)
; 4244 M-x
