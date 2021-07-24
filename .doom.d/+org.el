;;; +org.el -*- lexical-binding: t; -*-

;; org
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'org-mode-hook (lambda () (org-content 1)))
(setq org-directory (expand-file-name "E:\\temp")
      org-agenda-files (list org-directory)
      ;; org-ellipsis " ▼ "
      org-babel-python-command "python3")

;; org-agenda
(after! org-agenda
  ;; https://old.reddit.com/r/emacs/comments/hnf3cw/my_orgmode_agenda_much_better_now_with_category/
  (setq org-agenda-category-icon-alist
        `(("work" ,(list (all-the-icons-material "work")) nil nil :ascent center)
          ("chore" ,(list (all-the-icons-material "home")) nil nil :ascent center)
          ("events" ,(list (all-the-icons-material "event")) nil nil :ascent center)
          ("todo" ,(list (all-the-icons-material "check_box")) nil nil :ascent center)
          ("solution" ,(list (all-the-icons-material "done")) nil nil :ascent center)
          ("birthday" ,(list (all-the-icons-material "cake")) nil nil :ascent center)
          ("anniversary" ,(list (all-the-icons-material "favorite")) nil nil :ascent center))))

;; org-super-agenda
(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-compact-blocks t
        org-agenda-start-day "+0d"
        org-agenda-span 1)

  (setq org-super-agenda-groups
        '((:name "Today"
           :time-grid t
           :deadline today)
          (:name "Over Due"
           :deadline past)
          (:name "Working On"
           :todo ("STRT" "LOOP"))
          (:name "Delayed"
           :todo ("WAIT" "HOLD"))
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
;; ("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
(after! org-superstar
  (setq org-superstar-headline-bullets-list '("☰" "ൠ" "❤" "◉" "○" "◆")
        org-superstar-remove-leading-stars t
        org-superstar-prettify-item-bullets t))
