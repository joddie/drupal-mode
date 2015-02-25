;;; drupal-tests.el --- ert tests for drupal-mode

;; Copyright (C) 2012 Arne Jørgensen

;; Author: Arne Jørgensen <arne@arnested.dk>

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

;; Drupal mode is an advanced minor mode for developing in Drupal.

;;; Code:

(require 'drupal-mode)
(require 'ert)



(defun drupal-tests ()
  "Run drupal-mode ERT test cases."
  (interactive)
  (ert "drupal-.*"))



(ert-deftest drupal-major-version-test ()
  "Test `drupal-major-version'."
  (should (equal (drupal-major-version "7.12") "7"))
  (should (equal (drupal-major-version "6.1") "6"))
  (should (equal (drupal-major-version "4.5.2") "4.5")))



(ert-deftest drupal--hook-base-name ()
  "Test `drupal--hook-base-name'."
  (should
   (string=
    (drupal--hook-base-name "hook_foo")
    "foo"))

  (let ((drupal-symbol-collection nil))
    (should
     (string=
      (drupal--hook-base-name "somemodule_foo_bar_baz")
      "foo_bar_baz")))

  (let ((drupal-module "my_custom_module"))
    (should
     (string=
      (drupal--hook-base-name "my_custom_module_menu_alter")
      "menu_alter")))

  (let ((drupal-symbol-collection
         '("hook_something" "hook_something_else" "hook_thing_alter")))
    (should
     (string=
      (drupal--hook-base-name "my_module_something_else")
      "something_else"))

    (should
     (string=
      (drupal--hook-base-name "my_long_module2_thing_alter")
      "thing_alter"))

    (should
     (string=
      (drupal--hook-base-name "mymodule_undocumented_hook")
      "undocumented_hook"))))


(provide 'drupal-tests)

;; Local Variables:
;; coding: utf-8
;; End:

;;; drupal-tests.el ends here
