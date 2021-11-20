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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FLYCHECK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! flycheck
  (setq-default flycheck-disabled-checkers
                '(javascript-jshint handlebars
                  json-jsonlist json-python-json
                  c/c++-clang c/c++-cppcheck c/c++-gcc
                  python-pylint python-flake8 python-mypy
                  python-pyright python-pycompile))
  (setq-default flycheck-flake8-maximum-line-length 100))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PYTHON
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! python
  (setq python-indent-offset 4
        flycheck-python-pylint-executable "pylint"
        flycheck-python-flake8-executable "flake8")
        
  ;; (add-hook! python-mode (setq-default flycheck-checker "python-flake8"))
  ;; Resolve pylint cannot find relative PYTHONPATH issue
  (add-hook! python-mode (setenv "PYTHONPATH" (doom-project-root))))

(after! lsp-pyls
  ;; lsp-pyls-plugins-pylint-args [ "--errors-only" ]
  ;; lsp-pyls-configuration-sources ["pycodestyle"]
  ;; lsp-pyls-plugins-pylint-enabled nil ;; disable to ensure performance
  (setq lsp-pyls-disable-warning t)
  (setq lsp-pyls-plugins-pycodestyle-enabled t
        lsp-pyls-plugins-pycodestyle-max-line-length 120
        lsp-pyls-plugins-pycodestyle-ignore ["E501" "E111" "D103" "D101" "D100"]
        lsp-pyls-plugins-flake8-enabled nil
        lsp-pyls-plugins-flake8-ignore ["E501"]
        lsp-pyls-plugins-pydocstyle-enabled nil
        lsp-pyls-plugins-pydocstyle-ignore ["D101" "D100" "D103"]
        lsp-pyls-plugins-pyflakes-enabled nil
        lsp-pyls-plugins-mccabe-enabled nil
        lsp-pyls-plugins-pylint-enabled nil
        lsp-pyls-plugins-pylint-args ["--errors-only"]))

;; (after! lsp-python-ms
;;   (setq lsp-python-ms-python-executable-cmd "python"))

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
