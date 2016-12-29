(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-complete evil-leader smex ido-ubiquitous ido-vertical-mode flx-ido w3m evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'q-mode "q-mode")
(add-to-list 'auto-mode-alist '("\\.[kq]\\'" . q-mode))

(add-hook 'w3m-mode-hook 'w3m-lnum-mode)

(ido-mode t)
(setq ido-use-virtual-buffers t)
(ido-everywhere 1)
(ido-vertical-mode t)
(ido-ubiquitous-mode t)

(flx-ido-mode t)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq make-backup-files nil)
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)
(setq column-number-mode t)
(require 'auto-complete-config)
(ac-config-default)

