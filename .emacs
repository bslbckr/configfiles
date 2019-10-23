(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(package-initialize)

;; don't use tabs for indentation
(setq-default indent-tabs-mode nil)

;; install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "latin-9-prefix")
 '(epa-pinentry-mode (quote loopback))
 '(epa-popup-info-window nil)
 '(epg-gpg-program "gpg2")
 '(global-font-lock-mode t nil (font-lock))
 '(ivy-count-format "(%d/%d) ")
 '(ivy-use-virtual-buffers t)
 '(js2-mode-show-parse-errors t)
 '(js2-mode-show-strict-warnings t)
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (diredfl dired dired-git-info projectile omnisharp csharp-mode keychain-environment zenburn-theme logview w3m counsel swiper ivy gnu-elpa-keyring-update protobuf-mode restclient web-mode use-package tide pinentry pandoc-mode org-plus-contrib org markdown-mode magit js2-mode elfeed-goodies diminish db-pg company auctex atom-one-dark-theme)))
 '(show-paren-mode t nil (paren))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key [dead-grave] "`")
;; required when using byte-compiled .emacs together with use-package
(require 'bind-key)

(use-package magit
  :ensure t
  :commands (magit-status)
  :config  (setq magit-commit-arguments (quote ("--gpg-sign=8501968486DF0281"))))

(use-package tex :ensure auctex)

(use-package auctex
  :ensure t
  :mode ("\\.tex\\'" . latex-mode))

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  )

(use-package markdown-mode
  :ensure t
;  :config
;  (add-hook 'markdown-mode-hook 'pandoc-mode)
  :mode ("\\.md\\'" . markdown-mode))

(use-package pandoc-mode
  :ensure t
  :after (markdown-mode)
  :hook (markdown-mode))

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" . web-mode))

(use-package atom-one-dark-theme
  :ensure t
  :load-path "themes"
;;  :config 
;;  (load-theme 'atom-one-dark t)
  )

(use-package zenburn-theme
  :ensure t
  :load-path "themes"
  :config (load-theme 'zenburn t))

(use-package ace-jump-mode
  :ensure t
  :bind ("C-." . ace-jump-mode))

(use-package flycheck
  :ensure t
  :init
  (setq
   flycheck-checkers
   '(typescript-tide
     javascript-tide
     css-csslint
     emacs-lisp
     javascript-eslint
     json-jsonlint
     yaml-jsyaml
     ))
  :config
  (global-flycheck-mode))

(use-package company
  :ensure t
  :init
  (setq company-tooltip-align-annotations t
        company-tooltip-minimum-width 30)
;;  :config
;;  (global-company-mode)
  :hook
  ((web-mode tide-mode typescript-mode markdown-mode protobuf-mode omnisharp-mode emacs-lisp-mode) . company-mode)
  :bind
  ("M-<tab>" . company-complete))

(defun setup-tide-mode ()
  (interactive)
  (progn 
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)))

(use-package tide
  ;;:ensure t
  :defer 1
;;  :mode (("\\.ts\\'" . typescript-mode))
  :config
  (progn
    (add-hook 'before-save-hook 'tide-format-before-save)
    (add-hook 'typescript-mode-hook #'setup-tide-mode)))

(use-package typescript
  :defer 1
  :mode ("\\.ts\\'" . typescript-mode))

(use-package db-pg
  :ensure t)

(use-package elfeed
  :defer 3
  :ensure elfeed-goodies
  :init
  (setq elfeed-feeds
   (quote
    ("http://www.frisbeesportverband.de/index.php/feed/" "https://www.tagesschau.de/xml/rss2" "https://www.fr.de/sport/eintracht/?_XML=rss" "https://www.zukunft-mobilitaet.net/feed/" "http://www.cyclingmagazine.de/feed/" "https://github.com/ultical/ultical/commits/master.atom" "https://netzpolitik.org/feed" "https://netzpolitik.org/wp-json/oembed/1.0/embed?url=https%3A%2F%2Fnetzpolitik.org%2F&format=xml" "https://www.heise.de/newsticker/heise-atom.xml" "https://taz.de/rss.xml" "https://sportschau.de/sportschauindex100.feed"))))

;; set up org mode
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :pin "org"
  :ensure t
  :init
  (setq org-startup-indented t)
  (setq org-startup-folded "showall")
  (setq org-directory "~/Dokumente/org"))

(use-package restclient
  :ensure t
  :mode ("\\.restclient\\`" . restclient-mode)
  :commands (restclient-mode))

(use-package protobuf-mode
  :ensure t
  :mode ("\\.proto\\`" . protobuf-mode))

(use-package ivy
  :ensure t
  :defer 0.1
                                        ;:diminish
  :bind (("C-x C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode 1))

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package omnisharp
  :ensure t
  :after csharp-mode
  :hook (csharp-mode . omnisharp-mode)
  :config
  (add-to-list 'company-backends 'company-omnisharp)
  :bind (:map omnisharp-mode-map ("C-c C-c" . recompile)))

(use-package csharp-mode
  :ensure t
  :mode ("\\.cs\\'" . csharp-mode))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  :init
  (setq projectile-completion-system 'ivy) )

(use-package dired-git-info
  :ensure t
  :bind (:map dired-mode-map
              (")" . 'dired-git-info-mode)))
(use-package diredfl
  :ensure t
  :config
  (diredfl-global-mode 1))
(put 'upcase-region 'disabled nil)

(setenv "GPG_AGENT_INFO" "/home/bb/.gnupg/S.gpg-agent")
(setenv "SSH_AUTH_SOCK"  "/home/bb/.gnupg/S.gpg-agent.ssh")
