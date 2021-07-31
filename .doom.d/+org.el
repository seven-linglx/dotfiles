;;; +org.el -*- lexical-binding: t; -*-

;; org
(after! org
  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
  (add-hook 'org-mode-hook (lambda () (org-content 1)))
  (setq org-directory (expand-file-name "E:\\temp\\gtd")
        org-agenda-files (directory-files-recursively org-directory "\\.org$")
        org-ellipsis " ▼ "
        org-log-done 'time))

;; org capture
;; refer from https://github.com/ztlevi/doom-config
(after! org
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* TODO %U %?\n%i" :prepend t)
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
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i" :prepend t :kill-buffer t)
          ("pn" "Project notes" entry   ; {project-root}/notes.org
           (file+headline +org-capture-project-notes-file "Inbox")
           "* TODO %?\n%i" :prepend t :kill-buffer t)
          ("pc" "Project changelog" entry ; {project-root}/changelog.org
           (file+headline +org-capture-project-notes-file "Unreleased")
           "* TODO %?\n%i" :prepend t :kill-buffer t)))

  (setq org-log-into-drawer "LOGBOOK"))

;; org-agenda
(after! org-agenda
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
        org-agenda-start-day "-1d"
        ;; (setq org-agenda-start-on-weekday 1)
        org-agenda-span 'week)

  (setq org-super-agenda-groups
        '((:name "Today"
           :time-grid t
           :log t
           :deadline today)
          (:name "Over Due"
           :deadline past)
          (:name "Important"
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
  (setq org-superstar-headline-bullets-list '("☰" "ൠ" "❤" "☯" "○" "◆")
        org-superstar-remove-leading-stars t
        org-superstar-prettify-item-bullets t))

;; org fancy priorities
(use-package! org-fancy-priorities
  :after org-agenda
  :init
  (setq org-fancy-priorities-list '("☕" "⚓" "⚡" "☸"))
  :hook
  (org-mode . org-fancy-priorities-mode))
