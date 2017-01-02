;(add-to-list 'load-path "~/.emacs.d/lisp/benchmark-init-el/")
;(require 'benchmark-init-loaddefs)
;(benchmark-init/activate)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-toggle-key "M-,")
 '(evil-want-C-i-jump nil)
 '(ido-cr+-max-items 3000)
 '(org-agenda-files (quote ("~/advent/ad.org")))
 '(org-babel-load-languages (quote ((python . t) (q . t) (emacs-lisp . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (dedicated evil-numbers window-numbering rainbow-delimiters elscreen ag multi-term auto-complete evil-leader smex ido-ubiquitous ido-vertical-mode flx-ido w3m evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'q-mode "q-mode")
(add-to-list 'auto-mode-alist '("\\.[kq]\\'" . q-mode))

(add-hook 'w3m-mode-hook 'w3m-lnum-mode)

(ido-mode t)
(setq ido-use-virtual-buffers t)
(ido-everywhere 1)
(ido-vertical-mode t)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(ido-ubiquitous-mode t)
(flx-ido-mode t)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(setq inhibit-splash-screen t
      initial-scratch-message nil)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq make-backup-files nil)
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)
(setq column-number-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)

;(require 'auto-complete-config)
(ac-config-default)

(global-evil-leader-mode)
(evil-mode 1)
(evil-leader/set-leader "<SPC>") 
(evil-leader/set-key
  "w" 'save-buffer
  "p" 'find-file
  "b" 'switch-to-buffer
  "x" 'smex
  "c" 'org-cycle
  "d" 'kill-this-buffer
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "4" 'select-window-4
  "5" 'select-window-5
  "6" 'select-window-6
  "7" 'select-window-7
  )
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(global-hl-line-mode t)
(window-numbering-mode t)
(require 'dedicated)
