(setq user-full-name "bloodstiller")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(beacon-mode 1)

(when (version< "29.0.50" emacs-version)
  (pixel-scroll-precision-mode))

;;Select my preffered theme:
;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'modus-vivendi)
;;(load-theme 'tron-legacy t)
;;(setq doom-theme 'doom-nord)
(setq doom-theme 'doom-one)


(setq  doom-font (font-spec :family "Iosevka Nerd Font" :size 16)
      doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font")
      doom-unicode-font (font-spec :family "Symbols Nerd Font Mono" :size 16))

;;(custom-theme-set-faces! 'tron-legacy
  ;;`(tree-sitter-hl-face:constructor :foreground ,(doom-color 'blue))
  ;;`(tree-sitter-hl-face:number :foreground ,(doom-color 'orange))
  ;;`(tree-sitter-hl-face:attribute :foreground ,(doom-color 'magenta) :weight bold)
  ;;`(tree-sitter-hl-face:variable :foreground ,(doom-color 'base7) :weight bold)
  ;;`(tree-sitter-hl-face:variable.builtin :foreground ,(doom-color 'red))
  ;;`(tree-sitter-hl-face:constant.builtin :foreground ,(doom-color 'magenta) :weight bold)
  ;;`(tree-sitter-hl-face:constant :foreground ,(doom-color 'blue) :weight bold)
  ;;`(tree-sitter-hl-face:function.macro :foreground ,(doom-color 'teal))
  ;;`(tree-sitter-hl-face:label :foreground ,(doom-color 'magenta))
  ;;`(tree-sitter-hl-face:operator :foreground ,(doom-color 'blue))
  ;;`(tree-sitter-hl-face:variable.parameter :foreground ,(doom-color 'cyan))
  ;;`(tree-sitter-hl-face:punctuation.delimiter :foreground ,(doom-color 'cyan))
  ;;`(tree-sitter-hl-face:punctuation.bracket :foreground ,(doom-color 'cyan))
  ;;`(tree-sitter-hl-face:punctuation.special :foreground ,(doom-color 'cyan))
  ;;`(tree-sitter-hl-face:type :foreground ,(doom-color 'yellow))
  ;;`(tree-sitter-hl-face:type.builtin :foreground ,(doom-color 'blue))
  ;;`(tree-sitter-hl-face:tag :foreground ,(doom-color 'base7))
  ;;`(tree-sitter-hl-face:string :foreground ,(doom-color 'green))
  ;;`(tree-sitter-hl-face:comment :foreground ,(doom-color 'base6))
  ;;`(tree-sitter-hl-face:function :foreground ,(doom-color 'cyan))
  ;;`(tree-sitter-hl-face:method :foreground ,(doom-color 'blue))
  ;;`(tree-sitter-hl-face:function.builtin :foreground ,(doom-color 'cyan))
  ;;`(tree-sitter-hl-face:property :foreground ,(doom-color 'blue))
  ;;`(tree-sitter-hl-face:keyword :foreground ,(doom-color 'magenta))
  ;;`(corfu-default :font "Iosevka Nerd Font Mono" :background ,(doom-color 'bg-alt) :foreground ,(doom-color 'fg))
  ;;`(adoc-title-0-face :foreground ,(doom-color 'blue) :height 1.2)
  ;;`(adoc-title-1-face :foreground ,(doom-color 'magenta) :height 1.1)
  ;;`(adoc-title-2-face :foreground ,(doom-color 'violet) :height 1.05)
  ;;`(adoc-title-3-face :foreground ,(doom-lighten (doom-color 'blue) 0.25) :height 1.0)
  ;;`(adoc-title-4-face :foreground ,(doom-lighten (doom-color 'magenta) 0.25) :height 1.1)
  ;;`(adoc-verbatim-face :background nil)
  ;;`(adoc-list-face :background nil)
  ;;`(adoc-internal-reference-face :foreground ,(face-attribute 'font-lock-comment-face :foreground)))


; Set preffered fonts:
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 20)
      ;;doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 15)
      ;;doom-big-font (font-spec :family "JetBrains Mono" :size 24))
;;(after! doom-themes
  ;;(setq doom-themes-enable-bold t
        ;;doom-themes-enable-italic t))
;;(custom-set-faces!
  ;;'(font-lock-comment-face :slant italic)
  ;;'(font-lock-keyword-face :slant italic))

;;Setup Bookmarks
(setq bookmark-default-file "~/.config/doom/bookmarks/")

(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks"                          "L" #'list-bookmarks
       :desc "Set bookmark"                            "m" #'bookmark-set
       :desc "Delete bookmark"                         "M" #'bookmark-set
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(after! evil
  (evil-define-key 'normal ibuffer-mode-map
    (kbd "f c") 'ibuffer-filter-by-content
    (kbd "f d") 'ibuffer-filter-by-directory
    (kbd "f f") 'ibuffer-filter-by-filename
    (kbd "f m") 'ibuffer-filter-by-mode
    (kbd "f n") 'ibuffer-filter-by-name
    (kbd "f x") 'ibuffer-filter-disable
    (kbd "g h") 'ibuffer-do-kill-lines
    (kbd "g H") 'ibuffer-update))

;;Global Auto Revert
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(setq org-directory "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/")

(setq org-agenda-files '("/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org"
                         "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/org-gtd-tasks.org"
                         "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/gtd_archive_2023"))

;; CUSTOM org TODO states
(after! org
(setq org-todo-keywords
      '((sequence "TODO(t)"
         "NEXT(n)"
         "PLANNING(p)"
         "IN-PROGRESS(i)"
         "WEEKLY-GOAL(m)"
         "GOAL(g)"
         "WAITING(w)"
         "WORK(b)"
         "HABIT(h)"
         "PROJECT(P)"
         "CALENDAR(c)"
         "NOTE(N)"
         "AREA(a)"
         "|"
         "DONE(d!)"
         "COMPLETE(C!)"
         "HOLD(h)"
         "SOMEDAY(s)"
         "RABBITHOLE!(R)")
        )))

;; CUSTOM TODO colors
(after! org
(setq org-todo-keyword-faces
      '(
        ("TODO" . (:foreground "#ffdd83" :weight bold))
        ("NEXT" . (:foreground "light coral" :weight bold))
        ("PLANNING" . (:foreground "#bd7091" :weight bold))
        ("IN-PROGRESS" . (:foreground "#ffb86c" :weight bold))
        ("WEEKLY-GOAL" . (:foreground "light sea green" :weight bold))
        ("GOAL" . (:foreground "LimeGreen" :weight bold))
        ("WAITING" . (:foreground "LightPink1" :weight bold))
        ("WORK" . (:foreground "Cyan" :weight bold))
        ("HABIT" . (:foreground "RoyalBlue3" :weight bold))
        ("PROJECT" . (:foreground "SlateBlue1" :weight bold))
        ("CALENDAR" . (:foreground "chocolate" :weight bold))
        ("NOTE" . (:foreground "#7d9dc0" :background "#ffb86c" :weight bold))
        ("AREA" . (:foreground "#7d9dc0" :weight bold))

        ("DONE" . (:foreground "white" :weight bold))
        ("COMPLETE" . (:strikethrough t :foreground "light gray" :weight bold))
        ("HOLD" . (:foreground "Grey46" :weight bold))
        ("SOMEDAY" . (:foreground "cyan1" :weight bold))
        )))

;; Custom Tag colors
(setq org-tag-faces
      '(
        ("planning"  . (:foreground "mediumPurple1" :weight bold))
        ("@research"   . (:foreground "royalblue1"    :weight bold))
        ("QA"        . (:foreground "sienna"        :weight bold))
        ("CRITICAL"  . (:foreground "red1"          :weight bold))
        ("HABIT"  . (:foreground "pink"          :weight bold))
        )
      )

(map! :leader
      (:prefix ("=" . "open file")
       :desc "Edit TODO File" "t" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/org-gtd-tasks.org"))
       :desc "Edit Goals File"   "g" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/Goals.org"))
       :desc "Edit inbox File" "i" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org"))))

(map! :leader
      (:prefix ("= d" . "Open Doom Config")
       :desc "Edit Doom config.el"   "c" #'(lambda () (interactive) (find-file "/home/martin/.config/doom/README.org"))))

(map! :leader
      (:prefix ("= b" . "Open Blog Files")
       :desc "Open Blog Root Folder"   "r" #'(lambda () (interactive) (find-file "~/.config/hugo/bloodstiller"))
       :desc "Edit Index.org file"   "i" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/40-49_Career/44-Blog/index.org"))
       :desc "Edit Blog.org file"   "b" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/40-49_Career/44-Blog/Articles/Blog.org"))
       :desc "Edit Emacs.org file"   "e" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/40-49_Career/44-Blog/Emacs.org"))
       :desc "Edit Infosec.org file"   "I" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/40-49_Career/44-Blog/Infosec.org"))))
(map! :leader
      (:prefix ("= p" . "Open areas/Projects")
       :desc "Open Projects Folder" "p" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/00Projects"))
       :desc "Open Systems Folder" "0" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/01-09_System"))
       :desc "Open Health Folder" "1" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/10-19_Health"))
       :desc "Open Home Folder" "2" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/20-29_Home"))
       :desc "Open Relationships Folder" "3" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/30-39_Relationships"))
       :desc "Open Career Folder" "4" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/40-49_Career"))
       :desc "Open Personal Development Folder" "5" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/50-59_PersonalDevelopment"))
       :desc "Open Work Folder" "6" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/60-69_Work"))
       :desc "Open Finances Folder" "7" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/70-79_Finances"))
       :desc "Open Hobbies Folder" "8" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/80-89_Hobbies"))
       :desc "Open Repos Folder" "9" #'(lambda () (interactive) (find-file "/home/martin/Dropbox/90-99_Repos"))))

;;Org capture templates;
(after! org
  (setq org-capture-templates
        '(
;; Add to inbox
          ("i" "inbox"
        entry (file+headline "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org" "inbox")
         "* TODO %?"
         :empty-lines 0)
;; Add notes to inbox:
        ("n" "Personal Notes/Scatch Pad"
         entry (file+headline "/home/martin/Dropbox/01-09_System/01-Emacs/01.01-OrgMode/ScrathPad.org" "Personal Notes")
         "** %?"
         :empty-lines 0)
        ("w" "Work-Todo" entry (file "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org")
         "* WORK %?"
         :empty-lines 1)
;; To create work notes
        ("W" "Work-Note" entry (file "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org")
         "* NOTE %?"
         :empty-lines 0)
;; To create achievments todos
        ("a" "Achievments"
         entry (file+datetree "/home/martin/Dropbox/50-59_PersonalDevelopment/51-Diaries/51.04-Achievments_Diary/ACHIEVMENTS.org" "Achievments")
          "* %?"
          :empty-lines 0)
;; Add to Gratitude Diary
        ("g" "Gratidude Diary"
         entry (file+datetree "/home/martin/Dropbox/50-59_PersonalDevelopment/51-Diaries/51.03-Gratititude_Diary/GRATITUDE.org" "Gratitude Diary")
          "* %?"
          :empty-lines 0)
;; Add to Links Document:
        ("l" "Links" entry (file "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org")
          "* LINK %?"
         :empty-lines 0)
 ;; Weekly Reviews
        ("R" "Weekly Review"
         entry (file+datetree "/home/martin/Dropbox/50-59_PersonalDevelopment/52-Reviews/52.02 Weekly Reviews/WeeklyReviews.org" "Weekly Reviews")
         "* %?"
          :empty-lines 0)
       )))

;;;;;;;;;;;;;;;;;;;;;ORG CRYPT
;; ORG CRYPT TAG Setup for inline encryption
;; If I place "crypt" tag in any entry it will encrypt it.
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance '("crypt"))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)
;; Set shortut to decrypt easier.
(map! :leader
      :desc "Org Decrypt Entry"
      "d e" #'org-decrypt-entry)

;; Org super agenda setup:
 (use-package! org-super-agenda
   :after org-agenda
   :init
   (setq org-agenda-skip-scheduled-if-done t
       org-agenda-skip-deadline-if-done t
       org-agenda-include-deadlines t
       org-agenda-start-day nil ;; i.e. today
       org-agenda-span 1
       org-agenda-start-on-weekday nil)
   (setq org-agenda-custom-commands
         '(("c" "Super view"
                      ((agenda "" ((org-agenda-span 'day)
                       (org-super-agenda-groups
                        '((:name "⏰⏰⏰⏰⏰ --- Today --- ⏰⏰⏰⏰⏰"
                           :discard (:todo "DONE")
                           :discard (:tag "habit")
                           :time-grid t
                           :date today
                           :todo "TODAY"
                           :scheduled today
                           :discard (:anything)
                           :order 1)))))
                       (alltodo "" ((org-agenda-overriding-header "CURRENT STATUS")
                                    (org-agenda-prefix-format "  %t  %s")
                          (org-super-agenda-groups
                           '((:log t)
                             (:name " 🚧🚧🚧 --- ACTIVE PROJECT(s) --- 🚧🚧🚧 "
                              :todo "PROJECT"
                              :order 6
                              :transformer (--> it
                                   (upcase it)
                                   (propertize it 'face '(:foreground "SlateBlue1"))))
                             (:name "〰️〰️〰 --- Currently Working On --- 〰〰〰"
                                    :todo "IN-PROGRESS"
                                    :order 4)
                             (:name "❗❗❗ --- Important --- ❗❗❗"
                                    :date today
                                    :discard (:todo "DONE")
                                    :priority "A"
                                    :order 10)
                             (:name "✅✅✅ --- GOAL --- ✅✅✅"
                                    :todo "GOAL"
                                    :order 2
                                    :transformer (--> it
                                         (upcase it)
                                         (propertize it 'face '(:foreground "LimeGreen"))))
                             (:name "✅✅✅ --- WEEKLY-GOALS --- ✅✅✅"
                                    :todo "WEEKLY-GOAL"
                                    :order 3
                                    :transformer (--> it
                                         (upcase it)
                                         (propertize it 'face '(:foreground "light sea green"))))
                             (:name "❌⚠❌ --- Overdue! --- ❌⚠❌"
                                    :discard (:todo "DONE")
                                    :deadline past
                                    :scheduled past
                                    :transformer (--> it
                                         (upcase it)
                                         (propertize it 'face '(:foreground "red")))
                                    :order 5)
                             (:name "🇧🇧🇧 --- WORK --- 🇧🇧🇧"
                                    :and (:tag "WORK" :todo "WORK")
                                    :order 9)
                             (:name "✔✔✔ --- HABIT --- ✔✔✔"
                                    :and (:scheduled today :tag "habit")
                                    :transformer (--> it
                                         (upcase it)
                                         (propertize it 'face '(:foreground "royalblue1")))
                                    :order 20)
                            (:discard (:anything))))))))))
   :config
   (org-super-agenda-mode))

;; Journal Config
(setq org-journal-dir "/home/martin/Dropbox/50-59_PersonalDevelopment/51-Diaries/51.01-Daily_Diaries"
      org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %d-%m-%Y"
      org-journal-file-format "%d-%m-%Y-jrnl.org")

(map! :leader
      :desc "recenter-top-bottom"
      "s c" #'recenter-top-bottom)

;; Preview images in all org files on launch
(setq org-startup-with-inline-images t)
;;Adjust images to an actual size that doesn't take up the entire screen.
(setq org-image-actual-width 600)

(require 'org-download)
(setq-default org-download-image-dir "/home/martin/Dropbox/screenshots/")
;;Allows dropping to dir-ed
(add-hook 'dired-mode-hook 'org-download-enable)

(setq org-attach-directory "/home/martin/Dropbox/screenshots/")

;; Enables auto tangling/exporting of code blocks to a unified code file form org mode.
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(setq org-startup-folded t)

(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)
(defun my/org-add-ids-to-headlines-in-file ()
;  "Add ID properties to all headlines in the current file which
;do not already have one."
  (interactive)
  (org-map-entries 'org-id-get-create))
(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'my/org-add-ids-to-headlines-in-file nil 'local)))

;; Export using my custom smart quotes.
(setq org-export-with-smart-quotes t)

;; Hide emphasis markers in text this means that MD and org syntax icons will not show
;; effectively acts as preview.

(after! org
(setq org-hide-emphasis-markers t))

;;Customize ORG higlighting
;; this controls the color of bold, italic, underline, verbatim, strikethrough

    ;; Purple Bold & Underline Brighter purple Dracula purple "#A061F9"
    ;; Red text highligted in yellow (important)
    ;; Dracula setup ("/" (:weight black :background "#FF5555" :foreground "#F1FA8C" ))
    ;; Blue
    ;;Higlighter  brighter yellow "#F1FA8C"
    ;; Code block
    ;; Green Background Option Dracula:
    ;;("~" (:background "#6BB86B" :foreground "#575a71" ))
    ;; Red = Important red
    ;; Red for dracula theme "#FF5555"
    ;;("+" (bold :strike-through nil :foreground "#ffb86c" #cd5c5c )))))

(after! org
(setq org-emphasis-alist
  '(("*" (underline :weight black :foreground "#EB00E4" ))
   ;; ("/" (:weight black :background "#745B00" :foreground "#FF3D2B" ))
    ("_" (:weight black :foreground "#79c6ff" ))
    ("=" (underline :weight black :foreground "#b18c00" ))
    ("~" (:foreground "#6BB86B" ))
    ("+" (underline bold :weight italic :foreground "#FF3D2B" )))))

(setq org-superstar-headline-bullets-list '("› "))

(setq org-superstar-item-bullet-alist '((?* . ?⋆)
                                        (?+ . ?‣)
                                        (?- . ?•)))

(setq org-ellipsis " ⯯")

(setq-hook! org-mode
  prettify-symbols-alist '(("#+end_quote" . "”")
                           ("#+END_QUOTE" . "”")
                           ("#+begin_quote" . "“")
                           ("#+BEGIN_QUOTE" . "“")
                           ("#+end_src" . "«")
                           ("#+END_SRC" . "«")
                           ("#+begin_src" . "»")
                           ("#+BEGIN_SRC" . "»")
                           ("#+name:" . "»")
                           ("#+NAME:" . "»")))

(setq org-adapt-indentation t)

(require 'org-indent)
(setq org-startup-indented t)

(require 'org-roam)
(setq org-roam-directory "~/Dropbox")

(after! org-roam
  (setq org-roam-list-files-commands '(find fd fdfind rg)))

;Roam - Capture Templates:
(setq org-roam-capture-templates
'(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)

 ("A" "Application" plain
  (file "~/.config/orgTemplates/Application.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("a" "Attack Type" plain
  (file "~/.config/orgTemplates/AttackTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("b" "Box" plain
  (file "~/.config/orgTemplates/BoxTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("c" "CPTS Module" plain
  (file "~/.config/orgTemplates/CPTSSection.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("d" "Daily Review" plain
  (file "~/.config/orgTemplates/DailyReview.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

  ("p" "Pentest" plain
  (file "~/.config/orgTemplates/Pentest.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)


 ("n" "Start Project" plain
  (file "~/.config/orgTemplates/ProjectStartTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("N" "End Project" plain
  (file "~/.config/orgTemplates/ProjectEndTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

  ("s" "Service" plain
  (file "~/.config/orgTemplates/ServiceTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("t" "Tool" plain
  (file "~/.config/orgTemplates/ToolTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)))

(defun vr/org-roam-buffer-render-contents-advice (orig-fun &rest args)
  (let ((org-startup-indented nil))
    (apply orig-fun args)))
(advice-add 'org-roam-buffer-render-contents :around #'vr/org-roam-buffer-render-contents-advice)

(use-package ox-hugo
  :after org
  :config
  (setq org-hugo-base-dir "/home/martin/.config/hugo/bloodstiller")

  (defun my/ensure-hugo-title (file)
    "Ensure the file has a #+title: keyword, adding one based on the filename if missing."
    (with-current-buffer (find-file-noselect file)
      (goto-char (point-min))
      (unless (re-search-forward "^#\\+title:" nil t)
        (goto-char (point-min))
        (insert (format "#+title: %s\n\n"
                        (file-name-base (file-name-nondirectory file))))
        (save-buffer))
      (current-buffer)))

  (defun my/get-hugo-section (file)
    "Get the Hugo section for the file based on its front matter."
    (with-current-buffer (find-file-noselect file)
      (goto-char (point-min))
      (if (re-search-forward "^#\\+hugo_section:\\s-*\\(.*\\)$" nil t)
          (match-string-no-properties 1)
        "posts")))  ; default to "posts" if no specific section is found

  (defun my/org-roam-link-to-hugo-link (link desc)
    "Convert an Org-roam link to a Hugo internal link or plain text if file is missing."
    (let* ((id (org-element-property :path link))
           (node (org-roam-node-from-id id))
           (file (when node (org-roam-node-file node)))
      (if (and file (file-exists-p file))
          (format "{{< ref \"%s\" >}}" (file-name-sans-extension (file-name-nondirectory file)))
        (format "*%s*" (or desc (when node (org-roam-node-title node)) "Unknown")))))

  (defun my/export-org-to-hugo (file)
    "Export a single org file to Hugo markdown."
    (with-current-buffer (my/ensure-hugo-title file)
      (message "Exporting %s" file)
      (condition-case err
          (let* ((org-export-with-broken-links t)
                 (section (my/get-hugo-section file))
                 (org-hugo-section section)
                 (org-export-before-parsing-hook '(org-roam-bibtex-replace-links
                                                   org-roam-replace-roam-links))
                 (org-hugo-link-org-files-as-md t)
                 (org-link-parameters '(("id" :export my/org-roam-link-to-hugo-link))))
            (org-hugo-export-wim-to-md)
            (message "Exported %s to section: %s" file section))
        (error
         (message "Error exporting %s: %s" file (error-message-string err))))
      (kill-buffer)))

  (defun my/export-all-org-files ()
    "Export all org files in content-org/ to Hugo markdown."
    (interactive)
    (let ((org-files (directory-files-recursively
                      (expand-file-name "content-org" org-hugo-base-dir)
                      "\\.org$")))
      (dolist (file org-files)
        (my/export-org-to-hugo file))))

  (defun my/maybe-export-all-on-save ()
    (when (and (buffer-file-name)
               (string-prefix-p
                (expand-file-name "content-org" org-hugo-base-dir)
                (buffer-file-name)))
      (message "File in content-org saved, exporting all files...")
      (my/export-all-org-files)
      (message "All files exported")))

  (add-hook 'after-save-hook #'my/maybe-export-all-on-save))

;; Directory local variables for content-org/
(dir-locals-set-class-variables
 'hugo-content-org
 '((org-mode . ((eval . (org-hugo-auto-export-mode))))))

(dir-locals-set-directory-class
 (expand-file-name "content-org" org-hugo-base-dir)
 'hugo-content-org)

(message "ox-hugo configuration loaded")

;; Markdown & line settings

;;(setq display-line-numbers-type t)
;;(map! :leader
      ;;:desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      ;;(:prefix ("t" . "toggle")
       ;;:desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       ;;:desc "Toggle line highlight in frame" "h" #'hl-line-mode
       ;;:desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       ;;:desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

;Markdown: Set Custom Headers:
;;(custom-set-faces!
 ;; Headers

;;'(markdown-header-delimiter-face :foreground "#616161" :height 0.9)
;;'(markdown-header-face-1 :height 1.8 :foreground "#FF79C6" :weight extra-bold :inherit markdown-header-face)
;;'(markdown-header-face-2 :height 1.4 :foreground "#BD93F9" :weight extra-bold :inherit markdown-header-face)
;;'(markdown-header-face-3 :height 1.2 :foreground "#D4B8FB" :weight extra-bold :inherit markdown-header-face)
;;'(markdown-header-face-4 :height 1.15 :foreground "#FFA7D9" :weight bold :inherit markdown-header-face)
;;'(markdown-header-face-5 :height 1.1 :foreground "#E4D3FC" :weight bold :inherit markdown-header-face)
;;'(markdown-header-face-6 :height 1.05 :foreground "#5e81ac" :weight semi-bold :inherit markdown-header-face)

;;; Custom bold etc

;;'(markdown-code-face :background "#6BB86B" :foreground "#575a71")
;;'(markdown-line-break-face :weight extra-black :foreground "#79c6ff")
;;'(markdown-italic-face :weight black :foreground "#79c6ff")
;;'(markdown-list-face :weight black :foreground "#BD93F9")
;;'(markdown-bold-face :weight black :foreground "#A061F9"))

;; Enables markdown preview whilst creating doc.

;; (defvar nb/current-line '(0 . 0)
;;   "(start . end) of current line in current buffer")
;; (make-variable-buffer-local 'nb/current-line)
;;
;; (defun nb/unhide-current-line (limit)
;;   "Font-lock function"
;;   (let ((start (max (point) (car nb/current-line)))
;;         (end (min limit (cdr nb/current-line))))
;;     (when (< start end)
;;       (remove-text-properties start end
;;                       '(invisible t display "" composition ""))
;;       (goto-char limit)
;;       t)))
;;
;; (defun nb/refontify-on-linemove ()
;;   "Post-command-hook"
;;   (let* ((start (line-beginning-position))
;;          (end (line-beginning-position 2))
;;          (needs-update (not (equal start (car nb/current-line)))))
;;     (setq nb/current-line (cons start end))
;;     (when needs-update
;;       (font-lock-fontify-block 3))))
;;
;; (defun nb/markdown-unhighlight ()
;;   "Enable markdown concealling"
;;   (interactive)
;;   (markdown-toggle-markup-hiding 'toggle)
;;   (font-lock-add-keywords nil '((nb/unhide-current-line)) t)
;;   (add-hook 'post-command-hook #'nb/refontify-on-linemove nil t))

;; Toggles on for all MD docs. Remove to turn off.

;; (add-hook 'markdown-mode-hook #'nb/markdown-unhighlight)

;; Enable code block syntax highlight

;; (setq markdown-enable-highlighting-syntax t)

;; Enable wiki links in all md files by default:

;; (setq markdown-enable-wiki-links t)

; Make emacs auto indent when we create a new list item.
;;(setq markdown-indent-on-enter 'indent-and-new-item)

;Back to a simpler time…
(map! :g "C-s" #'save-buffer)

; Search easily
(map! :after evil :gnvi "C-f" #'consult-line)

;;(setq display-line-numbers-type nil)

;Use VIM Keybindings to move between windows:
(define-key evil-motion-state-map (kbd "C-h") #'evil-window-left)
(define-key evil-motion-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-motion-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-motion-state-map (kbd "C-l") #'evil-window-right)

; Zoom in and Out easily
(defun my/increase-text-height ()
  (interactive)
  (text-scale-increase 1))

(defun my/decrease-text-height ()
  (interactive)
  (text-scale-decrease 1))

(global-set-key (kbd "C-=") 'my/increase-text-height)
(global-set-key (kbd "C--") 'my/decrease-text-height)

;; Enables Emofis
(use-package emojify
  :hook (after-init . global-emojify-mode))

(defun dt/insert-todays-date (prefix)
  "Insert today's date based on a prefix."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%A, %B %d, %Y")
                 ((equal prefix '(4)) "%d-%m-%Y")
                 ((equal prefix '(16)) "%Y-%m-%d"))))
    (insert (format-time-string format))))

(defun dt/insert-current-time ()
  "Insert the current time in HH:MM:SS format."
  (interactive)
  (insert (format-time-string "%H:%M:%S")))

(require 'calendar)
(defun dt/insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))

(map! :leader
      (:prefix ("i d" . "Insert date/time")
        :desc "Insert any date"    "a" #'dt/insert-any-date
        :desc "Insert today's date" "t" #'dt/insert-todays-date
        :desc "Insert current time" "c" #'dt/insert-current-time))
