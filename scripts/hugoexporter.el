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
           (title (or desc (when node (org-roam-node-title node)) "Unknown")))
      (if (and file (file-exists-p file))
          (format "{{< ref \"%s\" >}}" (file-name-sans-extension (file-name-nondirectory file)))
        (format "__%s__" title))))  ; Use bold text for missing links

  (defun my/handle-org-link (link contents info)
    "Handle Org link export, converting to Hugo format when possible."
    (let ((type (org-element-property :type link))
          (path (org-element-property :path link)))
      (cond
       ((string= type "id")
        (my/org-roam-link-to-hugo-link link contents))
       (t (org-md-link link contents info)))))

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
                 (org-export-with-toc nil)
                 (org-md-headline-style 'atx)
                 (org-export-with-sub-superscripts nil)
                 (org-export-with-emphasize t)
                 (org-export-with-special-strings nil)
                 (org-export-with-fixed-width nil)
                 (org-md-link-org-files-as-md t)
                 (org-export-with-smart-quotes nil)
                 (async nil)
                 (subtreep nil)
                 (visible-only nil)
                 (body-only nil)
                 (ext-plist nil)
                 (org-export-filter-link-functions '(my/handle-org-link))
                 (output-file (org-hugo-export-to-md async subtreep visible-only body-only ext-plist)))
            (if output-file
                (message "Exported %s to %s" file output-file)
              (message "Export completed for %s, but no output file was returned" file)))
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
