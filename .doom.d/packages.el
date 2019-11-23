;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; (disable-packages! anaconda-mode
                   ;; company-anaconda
                   ;; pyimport)
(package! flycheck-mypy)
(package! lsp-python-ms)
