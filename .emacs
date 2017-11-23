(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; don't use tabs for indentation
(setq-default indent-tabs-mode nil)

;; ido mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; set up org mode
(setq org-startup-indented t)
(setq org-startup-folded "showall")
;; (setq org-directory "~/org")

;; install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(eval-when-compile
  (require 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Latin-9")
 '(default-input-method "latin-9-prefix")
 '(epg-gpg-program "gpg2")
 '(global-font-lock-mode t nil (font-lock))
 '(js2-mode-show-parse-errors t)
 '(js2-mode-show-strict-warnings t)
 ;;'(package-archives
 ;  (quote
 ;   (("gnu" . "http://elpa.gnu.org/packages/")
 ;    ("melpa" . "https://melpa.org/packages/"))))
 '(show-paren-mode t nil (paren))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(add-hook 'js-mode-hook 'js2-minor-mode)
;;(add-hook 'js-mode-hook 'ac-js2-mode)
;;(setq js2-hightlight-level 3)
;;(define-key js-mode-map "{" 'paredit-open-curly)
;;(define-key js-mode-map "}" 'paredit-close-curly-and-newline)

(use-package tex :ensure auctex)
(use-package auctex
  :ensure t
  :mode ("\\.tex\\'" . latex-mode))
;;(use-package angular-mode
;;  :ensure t)
;;(use-package malabar-mode
;;  :ensure t
;;  :mode ("\\.java\\'" . malabar-mode)
;;  )
(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  )
(use-package markdown-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  :mode ("\\.md\\'" . markdown-mode))
(use-package pandoc-mode
  :ensure t)
(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" . web-mode))
(use-package atom-one-dark-theme
  :ensure t
  :load-path "themes"
  :config 
  (load-theme 'atom-one-dark t))

(use-package ace-jump-mode
  :ensure t
  :bind ("C-." . ace-jump-mode))
