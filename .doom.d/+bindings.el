;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-


(map! :n "K" (kbd "%")
      :n ",h" (kbd "^")
      :n ",l" (kbd "$")
      :i "C-h" (kbd "<left>")
      :i "C-l" (kbd "<right>")
      :i "C-j" (kbd "<down>")
      :i "C-k" (kbd "<up>"))

(map! :leader
      :desc "counsel-M-x" :nmv "SPC" #'counsel-M-x
      (:prefix "c"                      ; code
        :desc "Comment or Uncomment Region" "L" #'comment-or-uncomment-region
        :desc "Comment line" "l" #'comment-line)
      (:prefix "p"
        :desc "Find file in current Git Repo" "f" #'counsel-git)
      (:prefix "s"
        :desc "Disable the active search highlightings" "c" #'evil-ex-nohighlight))
