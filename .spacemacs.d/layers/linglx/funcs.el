;; linglx layer 的一些自定义函数

(defun linglx/open-file-with-projectile-or-counsel-git ()
  (interactive)
  (if (linglx/git-project-root)
      (counsel-git)
    (if (projectile-project-p)
        (projectile-find-file)
      (ido-find-file))))

(defun linglx/git-project-root ()
  "Return the project root for current buffer."
  (let ((directory default-directory))
    (locate-dominating-file directory ".git")))
