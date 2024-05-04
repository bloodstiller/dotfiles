;;; .dire-locals.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 MDBDEVIO
;;
;; Author: MDBDEVIO <martin@Lok>
;; Maintainer: MDBDEVIO <martin@Lok>
;; Created: May 31, 2023
;; Modified: May 31, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/martin/.dire-locals
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:



((nil
  .
  ((eval
    .
    (progn

      ;; make drag-and-drop image save in the same name folder as org file
      ;; ex: `aa-bb-cc.org' then save image test.png to `aa-bb-cc/test.png'
      (defun my-org-download-method (link)
        (let ((filename
               (file-name-nondirectory
                (car (url-path-and-query
                      (url-generic-parse-url link)))))
              (dirname (file-name-sans-extension (buffer-name)) ))
          ;; if directory not exist, create it
          (unless (file-exists-p dirname)
            (make-directory dirname))
          ;; return the path to save the download files
          (expand-file-name filename dirname)))

      ;; only modify `org-download-method' in this project
      (setq-local org-download-method 'my-org-download-method)

      )))))
