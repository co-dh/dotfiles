(menu-bar-mode -1)
(show-paren-mode t)
(global-hl-line-mode t)
(column-number-mode t)
;(set-scroll-bar-mode nil)
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
(xterm-mouse-mode)
(require 'use-package)
(require 'diminish)
(setq use-package-always-ensure t)
(require 'smex)

(use-package ivy :diminish ivy-mode :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  )

(use-package counsel :config
  (global-set-key (kbd "C-s") 'swiper-isearch)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "<f2> j") 'counsel-set-variable)
  (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
  (global-set-key (kbd "C-c v") 'ivy-push-view)
  (global-set-key (kbd "C-c V") 'ivy-pop-view) 
  )

; (use-package magit)

(use-package which-key :config (which-key-mode t))
  
(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'q-mode "q-mode")
(add-to-list 'auto-mode-alist '("\\.[kq]\\'" . q-mode))

(diminish 'undo-tree-mode)
(load-theme 'leuven)

(use-package winum :config (winum-mode) :bind(
    ("M-1" . winum-select-window-1)
    ("M-2" . winum-select-window-2)
    ("M-3" . winum-select-window-3)
    ("M-4" . winum-select-window-4)
    ("M-5" . winum-select-window-5)
    ("M-6" . winum-select-window-6)
    ("M-7" . winum-select-window-7)
    ("M-8" . winum-select-window-8)
    ("M-9" . winum-select-window-9)
    ))


(global-set-key (kbd "<escape>") 'ryo-modal-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "37144b437478e4c235824f0e94afa740ee2c7d16952e69ac3c5ed4352209eefb" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(package-selected-packages
   '(visual-regexp phi-search undo-tree ivy-rich kakoune winum magit which-key use-package smex ivy-hydra doom-themes diminish counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ivy-rich-mode)

(use-package kakoune ;; Having a non-chord way to escape is important, since key-chords don't work in macros
  :bind ("C-z" . ryo-modal-mode)
  :hook (after-init . my/kakoune-setup)
  :config
  (defun ryo-enter () "Enter normal mode" (interactive) (ryo-modal-mode 1))
  (defun my/kakoune-setup ()
      "Call kakoune-setup-keybinds and then add some personal config."
      (kakoune-setup-keybinds)
      (setq ryo-modal-cursor-type 'box)
      (ryo-modal-keys
       (";"    kakoune-deactivate-mark)
       ("M-s"  mc/edit-ends-of-lines)
       ("e" forword-word :first '(kakoune-set-mark-if-inactive))
        )))

(use-package undo-tree
  :config
  (global-undo-tree-mode)
  :ryo
  ("u" undo-tree-undo)
  ("U" undo-tree-redo)
  ("SPC u" undo-tree-visualize)
  :bind (:map undo-tree-visualizer-mode-map
              ("h" . undo-tree-visualize-switch-branch-left)
              ("j" . undo-tree-visualize-redo)
              ("k" . undo-tree-visualize-undo)
              ("l" . undo-tree-visualize-switch-branch-right)))


;; This overrides the default mark-in-region with a prettier-looking one,
;; and provides a couple extra commands
(use-package visual-regexp
  :ryo
  ("s" vr/mc-mark)
  ("?" vr/replace)
  ("M-/" vr/query-replace))

;; Emacs incremental search doesn't work with multiple cursors, but this fixes that
(use-package phi-search
  :bind (("C-s" . phi-search)
         ("C-r" . phi-search-backward)))
