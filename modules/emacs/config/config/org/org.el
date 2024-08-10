;;; org.el Org-Mode Configuration -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 utfeight
;;
;; Author: utfeight <utfeightt@gmail.com>
;; Maintainer: utfeight <utfeightt@gmail.com>
;; Created: Ağustos 08, 2024
;; Modified: Ağustos 08, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/nixos/org
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(doom-require 'org)
(doom-require 'doom-lib)

(load! "org-modern.el") ;; uncomment packages.el org-modern

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.Arhiv/Org/")

;; NixOS Specific TexLive
(setq org-latex-compiler "lualatex")
(setq org-preview-latex-default-process 'dvisvgm)

(setq org-hide-emphasis-markers t) ;; Hide emphasis markers like /this/ or *this*

(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-edit-src-content-indentation 0) ;; Syntax highlighting in code blocks

(setq org-src-fontify-natively t) ;; Syntax highlighting in code blocks

;; This comment
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "c(CANCELLED@/!)"))))

;; Installed with M-x package-install RET org-bullets RET
;; Conflicts with org-superstar-mode (Disable org-superstar-mode to use org-bullets
;; (use-package org-bullets
;;   :ensure t
;;   :config

;;   (setq org-bullets-mode t)
;;   ;; Tbh It's pretty random now. But I can change it later
;;   ;; This does not work for some reason ?!?! It was working before?
;;   (setq org-bullets-bullet-list '("▶" "◉" "§" "Σ" "Ψ" "Ω" ;; "β" "δ" "ᗧ" "᠉" "⋑" "✸"
;;                                   )))

;;;;
;;; Titles and Sections
;; hide #+TITLE:
(with-eval-after-load 'org-faces
  (setq org-hidden-keywords '(title))
  ;; set basic title font
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
  ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2) ;\large
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44) ;\Large
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728) ;\LARGE
  ;; Only use the first 4 styles and do not cycle.
  (setq org-cycle-level-faces nil)
  (setq org-n-level-faces 4)
  ;; Document Title, (\huge)
  (set-face-attribute 'org-document-title nil
                      :height 2.074
                      :foreground 'unspecified
                      :inherit 'org-level-8)

  ;;   ;;; Basic Setup
  ;;   ;; Auto-start Superstar with Org
  ;;   )

  (with-eval-after-load 'org-superstar
    (set-face-attribute 'org-superstar-item nil :height 1.2)
    (set-face-attribute 'org-superstar-header-bullet nil :height 1.2)
    (set-face-attribute 'org-superstar-leading nil :height 1.3))
  ;; Set different bullets, with one getting a terminal fallback.
  (setq org-superstar-headline-bullets-list '("λ" "§" "Σ" "Ψ" "Ω" "▶" "β" "δ" "᠉" "⋑" "✸"))
  ;; Stop cycling bullets to emphasize hierarchy of headlines.
  ;; (setq org-superstar-cycle-headline-bullets nil)
  ;; Hide away leading stars on terminal.
  ;; (setq org-superstar-leading-fallback ?\s)


  (add-hook 'org-mode-hook 'hl-todo-mode)

  (after! org
    (add-hook 'org-mode-hook (lambda () (org-superstar-mode t) (global-hl-todo-mode t)))
    ;; TODO Create some kind of config that will do this:

    (setq org-hide-leading-stars t) ;; Added for troubleshooting NOTE
    (setq org-ellipsis "⤸") ;; :arrow_down: ⤸ :arrow_up: ▾ :arrow_down_small: ▴
    )

  (setq org-cycle-separator-lines -1) ;; Found on the internet it debugs ellipsis error (That I don't get cuz I can'T see anyhing)

  (defun org-toggle-html-export-on-save ()
    (interactive)
    (if (memq 'org-html-export-to-html after-save-hook)
        (progn
          (remove-hook 'after-save-hook 'org-html-export-to-html t)
          (message "Disabled org html export on save for current buffer..."))
      (add-hook 'after-save-hook 'org-html-export-to-html nil t)
      (message "Enabled org html export on save for current buffer...")))

  (defun org-toggle-markdown-export-on-save ()
    (interactive)
    (if (memq 'org-md-export-to-markdown after-save-hook)
        (progn
          (remove-hook 'after-save-hook 'org-md-export-to-markdown t)
          (message "Disabled org markdown export on save for current buffer..."))
      (add-hook 'after-save-hook 'org-md-export-to-markdown nil t)
      (message "Enabled org markdown export on save for current buffer...")))

  (defun org-toggle-latex-export-on-save ()
    (interactive)
    (if (memq 'org-latex-export-to-latex after-save-hook)
        (progn
          (remove-hook 'after-save-hook 'org-pdftools-export t)
          (message "Disabled org latex export on save for current buffer..."))
      (add-hook 'after-save-hook 'org-pdftools-export nil t)
      (message "Enabled org latex export on save for current buffer...")))

  (defun org-toggle-pdf-export-on-save ()
    (interactive)
    (if (memq 'org-latex-export-to-pdf after-save-hook)
        (progn
          (remove-hook 'after-save-hook 'org-pdftools-export t)
          (message "Disabled org pdf export on save for current buffer..."))
      (add-hook 'after-save-hook 'org-pdftools-export nil t)
      (message "Enabled org pdf export on save for current buffer...")))


  (provide 'org)
;;; org.el ends here
