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
      package-enable-at-startup nil 
      echo-keystrokes 0.1)
(defalias 'yes-or-no-p 'y-or-n-p)
;(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(modify-syntax-entry ?- "w")
(modify-syntax-entry ?_ "w")
(setq-default indent-tabs-mode nil)
;(setq select-enable-primary t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(require 'use-package)
(require 'diminish)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(evil-want-C-u-scroll t)
 '(package-selected-packages
   (quote
    (persp-projectile ace-link which-key helm-pydoc pydoc spaceline spacemacs-theme powerline ivy-hydra counsel smex evil-leader magit evil use-package diminish bind-key)))
 '(shell-file-name "/bin/bash")
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 90 :width normal)))))

(use-package evil-leader
  :config (global-evil-leader-mode t) (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "w" 'save-buffer
    "f" 'find-file
    "k" 'kill-this-buffer
    )
  )

;(setq evil-want-Uuu-scroll t)
;(require 'evil)

(use-package evil
  :config (evil-mode t) (evil-set-toggle-key "C-=") )

(use-package ivy :diminish ivy-mode :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (evil-leader/set-key "b" 'ivy-switch-buffer)
  )

;(use-package powerline :config (powerline-default-theme))
(use-package ivy-hydra)
(use-package winum :config (winum-mode)
  (evil-leader/set-key "1" 'winum-select-window-1
    "2" 'winum-select-window-2
    "3" 'winum-select-window-3
    "4" 'winum-select-window-4
    "5" 'winum-select-window-5
    "6" 'winum-select-window-6
    "7" 'winum-select-window-7
    "8" 'winum-select-window-8
    "9" 'winum-select-window-9
    ))

(use-package magit :config (evil-leader/set-key "gs" 'magit-status))
(use-package smex) ;   
(use-package counsel :config
  (evil-leader/set-key
    "<SPC>" 'counsel-M-x
    "gf" 'counsel-git
    "gg" 'counsel-git-grep
    "cp" 'counsel-package
    "im" 'counsel-imenu
    "/"  'counsel-ag
    ))

(use-package which-key :config (which-key-mode t))
  
(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'q-mode "q-mode")
(add-to-list 'auto-mode-alist '("\\.[kq]\\'" . q-mode))

(load-theme 'spacemacs-light) 
(diminish 'undo-tree-mode)

(require 'spaceline-config)
(spaceline-spacemacs-theme)

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol))

(use-package avy
  :config (evil-leader/set-key
            "u" 'evil-avy-goto-char-2-above
            "d" 'evil-avy-goto-char-2-below
            ))
