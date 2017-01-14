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
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
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
