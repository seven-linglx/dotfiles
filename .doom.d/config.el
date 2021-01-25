;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(load! "+program")
(load! "+bindings")

;; Place your private configuration here
(setq-default fill-column 100
              delete-trailing-lines t)
(setq-default evil-escape-delay 0.4)
(setq doom-font (font-spec :family "Source Code Pro" :size 15 :weight 'normal))
(setq display-line-numbers-type 'relative)
(setq shell-file-name (executable-find "zsh.exe"))
(setenv "PATH" "E:/cygwin64/bin")
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(add-to-list 'exec-path "/cygdrive/c/ProgramData/Anaconda3")
(add-to-list 'exec-path "C:/ProgramData/Anaconda3")

(setq lsp-ui-flycheck-enable nil)

; org
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'org-mode-hook (lambda () (org-content 1)))

(after! org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-superstar-prettify-item-bullets t ))
