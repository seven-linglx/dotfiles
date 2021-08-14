;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(load! "+program")
(load! "+bindings")
(load! "+org")

;; Place your private configuration here
(setq-default fill-column 100
              delete-trailing-lines t)
(setq-default evil-escape-delay 0.3)
;; which-key
(setq-default which-key-idle-delay 0.5)
(setq-default which-key-mode t)

;; 设置系统时间显示方式
(setq system-time-locale "C")
;; 打开文件时, 光标自动定位到上次停留的位置
(save-place-mode 1)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
;; 关闭emacs 时无需额外确认
(setq confirm-kill-emacs nil)
;; theme
(load-theme 'doom-solarized-light t)

;; all-the-icons
(setq doom-font (font-spec :family "DejaVuSansMono NF" :size 15 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Fira Mono for Powerline")
      doom-unicode-font (font-spec :family "Source Code Pro for Powerline"))

(setq line-spacing 0.3)
(setq display-line-numbers-type 'relative)
(setq shell-file-name (executable-find "zsh.exe"))
(setenv "PATH" "E:/cygwin64/bin")
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(add-to-list 'exec-path "/cygdrive/c/ProgramData/Anaconda3")
(add-to-list 'exec-path "C:/ProgramData/Anaconda3")

(setq lsp-ui-flycheck-enable nil)

;; 国内源
(setq package-archives '(("melpa-cn" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
                         ("org-cn"   . "http://mirrors.cloud.tencent.com/elpa/org/")
                         ("gnu-cn"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")))
;; 默认起始目录
(setq default-directory "E:\\Notes")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TOOLS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Doom has modified use-package :load-path to expand relative paths from. e.g. ~/.doom.d/lisp/package
(use-package protobuf-mode
  :load-path "modules/private/proto"
  :init
  (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode)))

;; Projectile
(use-package projectile
  :init
  (setq projectile-require-project-root t)
  :config
  (cond
   ((executable-find "fd")
    (setq-default projectile-generic-command "fd . -0 --type f --color=never"))
   ((executable-find "rg")
    (setq projectile-generic-command "rg -0 --files --follow --color=never --hidden"))))

;; 解决搜索里出现unicode字符,造成rg不能使用,https://github.com/raxod502/prescient.el/issues/43
(after! counsel
  ;; (setq counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s || true")
  (setf (alist-get 'counsel-rg ivy-re-builders-alist) #'ivy--regex-plus))
