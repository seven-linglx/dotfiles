;;; +org.el -*- lexical-binding: t; -*-

;; org
(after! org
  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
  ;; (add-hook 'org-mode-hook (lambda () (org-content 0)))
  (add-hook 'org-mode-hook (lambda () (org-fancy-priorities-mode 1)))
  (add-hook 'org-mode-hook (lambda () (prettify-symbols-mode 1)))

  (setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . ?✎)
                                         ("#+END_SRC" . ?∷)
                                         ("#+begin_src" . ?✎)
                                         ("#+end_src" . ?∷)
                                         ("#+BEGIN_QUOTE" . ?»)
                                         ("#+END_QUOTE" . ?«)
                                         ("#+begin_quote" . ?»)
                                         ("#+end_quote" . ?«)))

  (setq org-directory (expand-file-name "E:\\temp\\gtd")
        org-agenda-files (directory-files-recursively org-directory "\\.org$")
        org-default-notes-file (concat org-directory "\\notes.org")
        org-ellipsis " ↩ " ;; ▼
        org-startup-indented t
        org-startup-folded 'show2levels
        org-image-actual-width 300
        org-log-done 'time))

;; org capture
;; refer from https://github.com/ztlevi/doom-config
(after! org
  (defvar my-org-capture-project-notes-file
    (concat org-directory "\\projects\\notes.org")
    "The customize notes file for projects")
  (defvar my-org-capture-project-todo-file
    (concat org-directory "\\projects\\todo.org")
    "The customize todo file for projects.")

  (defun +org-capture-project-heading ()
    (if-let ((project (project-root (project-current 'prompt))))
        (let ((headline (org-find-exact-headline-in-buffer project)))
          (goto-char (or headline (point-max)))
          (unless headline (insert "\n* " project))
          (org-capture-put :target-entry-p t))
      (user-error "No project selected")))

  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* TODO %U %?\n%i" :prepend t)
          ("o" "Personal todo without timestamp" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* TODO %?\n%iSCHEDULED: %T\n" :prepend t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %U %?\n%i\nSCHEDULED: %T" :prepend t :kill-buffer t)
          ("a" "Personal notes with annotation" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %U %?\n%i\n%a\nSCHEDULED: %T" :prepend t :kill-buffer t)

          ;; Will use {project-root}/{todo,notes,changelog}.org, unless a
          ;; {todo,notes,changelog}.org file is found in a parent directory.
          ("p" "Templates for projects")
          ("pt" "Project todo" entry    ; {project-root}/todo.org
           (file+function my-org-capture-project-todo-file +org-capture-project-heading)
           "* TODO %?\n%i\n%a\n" :prepend t :kill-buffer t)
          ("pn" "Project notes" entry   ; {project-root}/notes.org
           (file+function my-org-capture-project-notes-file +org-capture-project-heading)
           "* NOTE %?\n%i\n%a\n" :prepend t :kill-buffer t)
          ("pc" "Project changelog" entry ; {project-root}/changelog.org
           (file+function my-org-capture-project-notes-file +org-capture-project-heading)
           "* NOTE %?\n%i\n%a\n" :prepend t :kill-buffer t)))

  (setq org-log-into-drawer "LOGBOOK"))

;; org-agenda
(after! org-agenda
  ;; https://emacs.christianbaeuerlein.com/my-org-config.html#org968d6c8
  (setq org-super-agenda-header-separator "==============\n")  ;; 9472
  (setq org-agenda-log-mode-items '(clock closed state))
  ;; 默认显示节假日
  (setq org-agenda-include-diary nil)
  (setq org-agenda-start-day nil)

  ;; https://old.reddit.com/r/emacs/comments/hnf3cw/my_orgmode_agenda_much_better_now_with_category/
  (setq org-agenda-category-icon-alist
        `(("work" ,(list (all-the-icons-material "work")) nil nil :ascent center)
          ("chore" ,(list (all-the-icons-material "home")) nil nil :ascent center)
          ("events" ,(list (all-the-icons-material "event")) nil nil :ascent center)
          ("notes" ,(list (all-the-icons-material "book")) nil nil :ascent center)
          ("todo" ,(list (all-the-icons-material "check_box")) nil nil :ascent center)
          ("solution" ,(list (all-the-icons-material "done")) nil nil :ascent center)
          ("birthday" ,(list (all-the-icons-material "cake")) nil nil :ascent center)
          ("anniversary" ,(list (all-the-icons-material "favorite")) nil nil :ascent center)))

  ;; (setq org-agenda-use-time-grid t) ;; set in org-super-agenda
  (setq org-agenda-time-grid (quote ((daily today require-timed)
                                     (300 600 900 1200 1500 1800 2100 2400)
                                     "......"
                                     "----------------"))))

;; org-super-agenda
(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done nil
        org-agenda-skip-deadline-if-done nil
        org-agenda-compact-blocks t
        ;; org-agenda-start-on-weekday 1
        org-super-agenda-header-map nil
        org-agenda-span 'week)

  (setq org-super-agenda-groups
        '((:name " Today"
           :time-grid t
           :log t
           :deadline today)
          (:name " Over Due"
           :deadline past)
          (:name " Important"
           :priority "A"
           :order 1)
          (:name "Less Important"
           :priority "B")
          (:name "Trival"
           :priority<"B")))

  :config
  (org-super-agenda-mode))

;; org-suerstar
;; ("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶" "☰" "☷" "☯" "☭")
(after! org-superstar
  (setq org-superstar-headline-bullets-list '("☰" "☷" "◉" "☯" "○" "◆")
        org-superstar-remove-leading-stars t
        org-superstar-prettify-item-bullets t))

;; org fancy priorities
(use-package! org-fancy-priorities
  :after org-agenda
  :init
  (setq org-fancy-priorities-list '("⚡" "⚓" "☕" "☸"))
  :config
  (org-fancy-priorities-mode))
