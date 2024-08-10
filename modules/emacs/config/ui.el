;;; ui.el Doom Emacs UI Module -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 utfeight
;;
;; Author: utfeight <utfeightt@gmail.com>
;; Maintainer: utfeight <utfeightt@gmail.com>
;; Created: Ağustos 08, 2024
;; Modified: Ağustos 08, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/nixos/ui
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:


(add-hook 'doom-init-ui-hook #'global-hide-mode-line-mode)
(setq-default mode-line-format nil
              confirm-kill-emacs nil)

(setq fancy-splash-image "~/.config/doom/splash/emacs-e-orange.png")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(provide 'ui)
;;; ui.el ends here
