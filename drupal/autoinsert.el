;;; drupal/autoinsert.el --- Drupal-mode support for `auto-insert-mode'

;; Copyright (C) 2012  Arne Jørgensen

;; Author: Arne Jørgensen <arne@arnested.dk>
;; Keywords: 

;; This file is part of Drupal mode.

;; Drupal mode is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.

;; Drupal mode is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Drupal mode.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Enable drupal-mode support for `auto-insert-mode'.

;;; Code:

(define-auto-insert '("\\.info" . "Drupal info file") 'drupal/autoinsert-insert-info-skeleton)
(define-auto-insert '("\\.module" . "Drupal module file") 'drupal/autoinsert-insert-module-skeleton)

(define-skeleton drupal/autoinsert-insert-info-skeleton
  "Drupal info file skeleton."
  nil
  '(setq v1 (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))
  '(setq v2 (if (drupal-major-version) (>= (string-to-number (drupal-major-version)) 7) t))
  "name = " @ - (upcase-initials (replace-regexp-in-string "[-_\\.]+" " " v1)) \n
  "description = " @ \n
  "core = " @ (drupal-major-version) & ".x" "\n"
  (when v2 "; stylesheets[all][] = ") & @ (when v2 "css/") & v1 & ".base.css\n"
  (when v2 "; scripts[] = ") & @ (when v2 "scripts/") & v1 & ".js\n"
  (when v2 "; files[] = ") & @ (when v2 v1) & ".test\n"
  "; dependencies" (when v2 "[]") " = " @ "\n"
  "; package = " @ "\n"
  "; php = " @ "\n"
  (when v2 "; configure = ") & @ (when v2 "admin/config/something/") & v1 & "\n"
  (when v2 "; required = ") & @ (when v2 "TRUE\n")
  (when v2 "; hidden = ") & @ (when v2 "TRUE\n"))

(define-skeleton drupal/autoinsert-insert-module-skeleton
  "Drupal module file skeleton."
  nil
  "<?php\n"
  "\n"
  "/**\n"
  " * @file\n"
  " * " @ - "\n"
  " */\n"
  @ "\n")



(provide 'drupal/autoinsert)

;;; drupal/autoinsert.el ends here