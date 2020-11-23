;;; ~/.doom.d/+program.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPANY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! company
  (setq company-minimum-prefix-length 2
        company-quickhelp-delay nil
        company-idle-delay 0.1
        ;; company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)))

(def-package! company-lsp
  :after company
  :init
  ;; Language servers have better idea filtering and sorting,
  ;; don't filter results on the client side.
  (setq company-transformers nil
        company-lsp-cache-candidates nil)
  (set-company-backend! 'lsp-mode 'company-lsp))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FLYCHECK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! flycheck
  (setq-default flycheck-disabled-checkers
                '(
                  javascript-jshint handlebars
                  json-jsonlist json-python-json
                  c/c++-clang c/c++-cppcheck c/c++-gcc
                  python-pylint python-pycompile lsp-ui))
  (setq-default flycheck-flake8-maximum-line-length 100)
  ;; python-flake8
  ;; ======================== Python ========================
  (require 'flycheck-mypy))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PYTHON
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! python
  (setq python-indent-offset 4
        flycheck-python-pylint-executable "pylint"
        flycheck-python-flake8-executable "flake8")

  ;; Resolve pylint cannot find relative PYTHONPATH issue
  (add-hook! python-mode (setenv "PYTHONPATH" (doom-project-root)))

  ;; (add-hook! python-mode (setq-default flycheck-checker "python-flake8"))

  ;; lsp-pyls-plugins-pylint-args [ "--errors-only" ]
  (if (featurep! :tools lsp)
      (setq lsp-pyls-plugins-pycodestyle-ignore '("E501")
            lsp-pyls-plugins-pylint-args ["--errors-only"])))

(after! lsp-python-ms
  (setq lsp-python-ms-python-executable-cmd "python3"))

(after! conda
  (when IS-LINUX
    ;; Ubuntu anaconda
    (setq conda-anaconda-home "~/anaconda3")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! cc-mode
  (c-add-style
   "my-cc" '("user"
             (c-basic-offset . 2)
             (c-offsets-alist
              . ((innamespace . 0)
                 (access-label . -)
                 (case-label . 0)
                 (member-init-intro . +)
                 (topmost-intro . 0)
                 (arglist-cont-nonempty . +)))))
  (setq c-default-style "my-cc")

  (setq-default c-basic-offset 2)

  (add-to-list 'auto-mode-alist '("\\.inc\\'" . +cc-c-c++-objc-mode)))
