;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(load! "+program")
(load! "+bindings")

;; Place your private configuration here
(setq-default fill-column 100
              delete-trailing-lines t)
(setq display-line-numbers-type 'relative)
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(add-to-list 'exec-path "/home/linglx/anaconda3/bin")

(setq lsp-ui-flycheck-enable nil)
