(setq user-full-name "bloodstiller")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(beacon-mode 1)

(when (version< "29.0.50" emacs-version)
  (pixel-scroll-precision-mode))

;;Select my preffered theme:
(setq doom-theme 'doom-one)


(setq  doom-font (font-spec :family "Iosevka Nerd Font" :size 16)
      doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font")
      doom-unicode-font (font-spec :family "Symbols Nerd Font Mono" :size 16)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;;Setup Bookmarks
(setq bookmark-default-file "~/.config/doom/bookmarks/")

(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks"                          "L" #'list-bookmarks
       :desc "Set bookmark"                            "m" #'bookmark-set
       :desc "Delete bookmark"                         "M" #'bookmark-set
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(evil-define-key 'normal ibuffer-mode-map
  (kbd "f c") 'ibuffer-filter-by-content
  (kbd "f d") 'ibuffer-filter-by-directory
  (kbd "f f") 'ibuffer-filter-by-filename
  (kbd "f m") 'ibuffer-filter-by-mode
  (kbd "f n") 'ibuffer-filter-by-name
  (kbd "f x") 'ibuffer-filter-disable
  (kbd "g h") 'ibuffer-do-kill-lines
  (kbd "g H") 'ibuffer-update)

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

(after! org
(setq org-emphasis-alist
  ;'(("*" (underline :weight black :foreground "#ee9955"))
  '(("*" (:foreground "#c5cdd8" :height 1.1 :weight bold ))
   ;; ("/" (:weight black :background "#745B00" :foreground "#FF3D2B" ))
    ("_" (:weight black :foreground "#79c6ff" ))
    ("=" (underline :weight black :foreground "#b18c00" ))
    ;;("~" (:foreground "#6BB86B" ))
    ("~" (:foreground "#c678dd" :background "#2d333b"))
    ("+" (underline bold :weight italic :foreground "#FF6c6b" )))))

;(setq org-superstar-headline-bullets-list '("› "))

;;(setq org-superstar-item-bullet-alist '((?* . ?⋆)
                                        ;;(?+ . ?‣)
                                        ;;(?- . ?•)))

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
(setq org-roam-db-location "~/.config/emacs/org-roam/org-roam.db")

(after! org-roam
  (setq org-roam-list-files-commands '(find fd fdfind rg)))

;Roam - Capture Templates:
(setq org-roam-capture-templates
'(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)

 ("A" "Application" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/Application.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("a" "Attack Type" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/AttackTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("b" "Box" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/BoxTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("c" "CPTS Module" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/CPTSSection.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("d" "Daily Review" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/DailyReview.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

  ("p" "Pentest" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/Pentest.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)


 ("n" "Start Project" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/ProjectStartTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("N" "End Project" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/ProjectEndTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

  ("s" "Service" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/ServiceTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)

 ("t" "Tool" plain
  (file "/home/martin/.dotfiles/nix/packages/doom/orgTemplates/ToolTemplate.org")
  :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
  :unnarrowed t)))

(defun vr/org-roam-buffer-render-contents-advice (orig-fun &rest args)
  (let ((org-startup-indented nil))
    (apply orig-fun args)))
(advice-add 'org-roam-buffer-render-contents :around #'vr/org-roam-buffer-render-contents-advice)

(use-package ox-hugo
  :after org
  :config
  (setq org-hugo-base-dir "/home/martin/Dropbox/40-49_Career/44-Blog/bloodstiller")

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
           (title (or desc (when node (org-roam-node-title node)) "Unknown")))
      (if (and file (file-exists-p file))
          (format "{{< ref \"%s\" >}}" (file-name-sans-extension (file-name-nondirectory file)))
        (format "*%s*" title))))  ; Use italic text for missing links

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

(require 'json)

;; Quick and dirty - just dump what's already in the database
(defun org-roam-quick-export-for-migration ()
  "Quick export of ID->title mapping for migration (no sync)."
  (interactive)
  (let* ((query "SELECT id, title, file FROM nodes")
         (results (org-roam-db-query query))
         (output-lines (mapcar (lambda (row)
                                 (let ((id (nth 0 row))
                                       (title (nth 1 row))
                                       (filepath (nth 2 row)))
                                   (format "%s\t%s\t%s\t%s"
                                           id
                                           title
                                           filepath
                                           (file-name-base filepath))))
                               results)))
    (with-temp-file "~/org-roam-migration.tsv"
      (insert "ID\tTitle\tFilePath\tFileName\n")
      (insert (string-join output-lines "\n")))
    (message "Exported %d entries to ~/org-roam-migration.tsv" (length results))))

;; If you want JSON format instead
(defun org-roam-quick-json-export ()
  "Quick JSON export for migration."
  (interactive)
  (let* ((query "SELECT id, title, file FROM nodes")
         (results (org-roam-db-query query))
         (map (mapcar (lambda (row)
                        (let ((filepath (nth 2 row)))
                          `((id . ,(nth 0 row))
                            (title . ,(nth 1 row))
                            (filepath . ,filepath)
                            (filename . ,(file-name-base filepath))
                            (md_file . ,(concat (file-name-base filepath) ".md")))))
                      results))
         (json-output (json-encode map)))
    (with-temp-file "~/org-roam-migration.json"
      (insert json-output))
    (message "Exported %d entries to ~/org-roam-migration.json" (length results))))

;; Super simple - just get the raw data for inspection
(defun org-roam-dump-ids ()
  "Just dump all IDs and titles to messages buffer."
  (interactive)
  (let ((results (org-roam-db-query "SELECT id, title FROM nodes")))
    (dolist (row results)
      (message "ID: %s | Title: %s" (nth 0 row) (nth 1 row)))
    (message "Found %d org-roam nodes" (length results))))



;;(require 'json)
;;
;;;; Quick and dirty - just dump what's already in the database
;;(defun org-roam-quick-export-for-migration ()
  ;;"Quick export of ID->title mapping for migration (no sync)."
  ;;(interactive)
  ;;(let* ((query "SELECT id, title FROM nodes")
         ;;(results (org-roam-db-query query))
         ;;(output-lines (mapcar (lambda (row)
                                 ;;(format "%s\t%s" (nth 0 row) (nth 1 row)))
                               ;;results)))
    ;;(with-temp-file "~/org-roam-migration.tsv"
      ;;(insert "ID\tTitle\n")
      ;;(insert (string-join output-lines "\n")))
    ;;(message "Exported %d entries to ~/org-roam-migration.tsv" (length results))))
;;
;;;; If you want JSON format instead
;;(defun org-roam-quick-json-export ()
  ;;"Quick JSON export for migration."
  ;;(interactive)
  ;;(let* ((query "SELECT id, title FROM nodes")
         ;;(results (org-roam-db-query query))
         ;;(map (mapcar (lambda (row)
                        ;;`((id . ,(nth 0 row))
                          ;;(title . ,(nth 1 row))
                          ;;(md_file . ,(concat (replace-regexp-in-string "[^a-zA-Z0-9-_]" "_" (nth 1 row)) ".md"))))
                      ;;results))
         ;;(json-output (json-encode map)))
    ;;(with-temp-file "~/org-roam-migration.json"
      ;;(insert json-output))
    ;;(message "Exported %d entries to ~/org-roam-migration.json" (length results))))
;;
;;;; Super simple - just get the raw data for inspection
;;(defun org-roam-dump-ids ()
  ;;"Just dump all IDs and titles to messages buffer."
  ;;(interactive)
  ;;(let ((results (org-roam-db-query "SELECT id, title FROM nodes")))
    ;;(dolist (row results)
      ;;(message "ID: %s | Title: %s" (nth 0 row) (nth 1 row)))
    ;;(message "Found %d org-roam nodes" (length results))))

(setq org-export-with-broken-links 'mark)  ; Export and mark broken links

;;(defun org-export-folder-to-markdown (input-folder output-folder)
  ;;"Export all .org files in INPUT-FOLDER to markdown in OUTPUT-FOLDER."
  ;;(interactive "DInput folder: \nDOutput folder: ")
;;
  ;;;; Create output folder if it doesn't exist
  ;;(unless (file-exists-p output-folder)
    ;;(make-directory output-folder t))
;;
  ;;;; Get all .org files in the input folder
  ;;(let ((org-files (directory-files input-folder t "\\.org$")))
    ;;(dolist (org-file org-files)
      ;;(let* ((base-name (file-name-base org-file))
             ;;(output-file (expand-file-name
                          ;;(concat base-name ".md")
                          ;;output-folder)))
;;
        ;;;; Open the org file, export to markdown, then close
        ;;(with-current-buffer (find-file-noselect org-file)
          ;;(org-md-export-to-markdown)
          ;;;; Move the generated .md file to the output folder
          ;;(let ((generated-file (concat (file-name-sans-extension org-file) ".md")))
            ;;(when (file-exists-p generated-file)
              ;;(rename-file generated-file output-file t)))
          ;;(kill-buffer))))))
(require 'ox-gfm)

(defun org-export-folder-to-gfm-improved (input-folder output-folder &optional recursive)
  "Export all .org files in INPUT-FOLDER to GitHub Flavored Markdown in OUTPUT-FOLDER.
If RECURSIVE is non-nil, also process subdirectories."
  (interactive "DInput folder: \nDOutput folder: \nP")
  
  ;; Create output folder if it doesn't exist
  (unless (file-exists-p output-folder)
    (make-directory output-folder t))
  
  ;; Get all .org files
  (let* ((org-files (if recursive
                       (directory-files-recursively input-folder "\\.org$")
                     (directory-files input-folder t "\\.org$")))
         (total-files (length org-files))
         (processed 0)
         (failed 0)
         (failed-files '()))
    
    (message "Found %d .org files to process..." total-files)
    
    (dolist (org-file org-files)
      (condition-case err
          (let* ((base-name (file-name-base org-file))
                 (output-file (expand-file-name
                              (concat base-name ".md")
                              output-folder)))
            
            (message "Processing: %s (%d/%d)" base-name (1+ processed) total-files)
            
            ;; Check if file is readable
            (unless (file-readable-p org-file)
              (error "File not readable: %s" org-file))
            
            ;; Open the org file, export to GFM, then close
            (with-current-buffer (find-file-noselect org-file)
              (condition-case export-err
                  (progn
                    ;; Try to export
                    (org-gfm-export-to-markdown)
                    
                    ;; Move the generated .md file to the output folder
                    (let ((generated-file (concat (file-name-sans-extension org-file) ".md")))
                      (when (file-exists-p generated-file)
                        (rename-file generated-file output-file t)
                        (setq processed (1+ processed)))
                      (unless (file-exists-p generated-file)
                        (error "Export didn't generate expected file: %s" generated-file))))
                
                (error
                 (setq failed (1+ failed))
                 (push (cons org-file (error-message-string export-err)) failed-files)
                 (message "Export failed for %s: %s" base-name (error-message-string export-err))))
              
              (kill-buffer)))
        
        (error
         (setq failed (1+ failed))
         (push (cons org-file (error-message-string err)) failed-files)
         (message "Failed to process %s: %s" org-file (error-message-string err)))))
    
    ;; Summary
    (message "\nExport complete!")
    (message "Successfully processed: %d files" processed)
    (message "Failed: %d files" failed)
    
    ;; Report failed files
    (when failed-files
      (message "\nFailed files:")
      (dolist (failed-file failed-files)
        (message "  %s: %s" (car failed-file) (cdr failed-file))))
    
    ;; Return summary
    (list :processed processed :failed failed :failed-files failed-files)))

;; Helper function to diagnose issues
(defun org-export-diagnose-folder (input-folder)
  "Diagnose potential issues with org files in INPUT-FOLDER."
  (interactive "DInput folder: ")
  
  (let* ((all-files (directory-files input-folder t "\\.org$"))
         (readable-files '())
         (unreadable-files '())
         (empty-files '())
         (large-files '()))
    
    (dolist (file all-files)
      (cond
       ((not (file-readable-p file))
        (push file unreadable-files))
       ((= (nth 7 (file-attributes file)) 0)
        (push file empty-files))
       ((> (nth 7 (file-attributes file)) 1000000) ; > 1MB
        (push file large-files))
       (t
        (push file readable-files))))
    
    (message "Diagnosis for %s:" input-folder)
    (message "Total .org files: %d" (length all-files))
    (message "Readable files: %d" (length readable-files))
    (message "Unreadable files: %d" (length unreadable-files))
    (message "Empty files: %d" (length empty-files))
    (message "Large files (>1MB): %d" (length large-files))
    
    (when unreadable-files
      (message "\nUnreadable files:")
      (dolist (file unreadable-files)
        (message "  %s" file)))
    
    (when empty-files
      (message "\nEmpty files:")
      (dolist (file empty-files)
        (message "  %s" file)))
    
    (when large-files
      (message "\nLarge files:")
      (dolist (file large-files)
        (message "  %s (%d bytes)" file (nth 7 (file-attributes file)))))))

;; Quick function to check what files are being found
(defun org-list-files-in-folder (input-folder)
  "List all .org files found in INPUT-FOLDER."
  (interactive "DInput folder: ")
  (let ((org-files (directory-files input-folder t "\\.org$")))
    (message "Found %d .org files:" (length org-files))
    (dolist (file org-files)
      (message "  %s" (file-name-nondirectory file)))
    org-files))

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

;; 📚 Customize Org Roam buffer window behavior

;(after! org-roam
  ;(setq org-roam-buffer-window-parameters '((no-delete-other-windows . t)))
  ;(add-to-list 'display-buffer-alist
               ;'("\\*org-roam\\*"
                 ;(display-buffer-in-side-window)
                 ;(side . right)
                 ;(window-width . 0.4)
                 ;(window-parameters . ((no-other-window . t)
                                       ;(no-delete-other-windows . t))))))

;; Floating minibuffer popup with Vertico

;(use-package! vertico-posframe
  ;:after vertico
  ;:config
  ;(vertico-posframe-mode 1)
  ;(setq vertico-posframe-poshandler 'posframe-poshandler-frame-center
        ;vertico-posframe-border-width 8
        ;vertico-posframe-parameters
        ;'((left-fringe . 10)
          ;(right-fringe . 10)
          ;(internal-border-width . 10)
          ;(undecorated . t)
          ;(no-accept-focus . t)
          ;(no-focus-on-map . t)
          ;(min-width . t)
          ;(min-height . t)
          ;(border-width . 10)
          ;(child-frame-border-width . 10)
          ;(background-color . "#1e1e2e") ; or any dark theme color
          ;(internal-border-color . "#585b70") ; slight contrast
          ;(alpha . (95 . 95))))) ; slight transparency for soft edge
