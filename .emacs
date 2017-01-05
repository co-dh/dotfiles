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
 '(custom-safe-themes
   (quote
    ("28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "4d0ef970adb1f147ca9aeda343f910e9ea9bac82c881abc89b3ab1998eceb12a" "5b24babd20e58465e070a8d7850ec573fe30aca66c8383a62a5e7a3588db830b" "38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" "1b386f9d14ac6e9ae88ab3993ccf4ccb67d0cb196b4279126a85bd8e03269f7d" "8dc4a35c94398efd7efee3da06a82569f660af8790285cd211be006324a4c19a" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "9d91458c4ad7c74cf946bd97ad085c0f6a40c370ac0a1cbeb2e3879f15b40553" default)))
 '(evil-toggle-key "M-,")
 '(evil-want-C-i-jump nil)
 '(ido-cr+-max-items 6000)
 '(org-babel-load-languages (quote ((python . t) (q . t) (emacs-lisp . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (moe-theme material-theme monokai-theme spacemacs-theme indent-guide linum-relative pkgbuild-mode evil evil-leader flx-ido ido-vertical-mode ido-ubiquitous smex solarized-theme dedicated evil-numbers window-numbering rainbow-delimiters elscreen ag multi-term auto-complete evil-leader w3m))))
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
      visible-bell nil)
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
  "y" '*tabel--cell-yank
  )
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(global-hl-line-mode t)
(window-numbering-mode t)
(require 'dedicated)
(modify-syntax-entry ?- "w")
