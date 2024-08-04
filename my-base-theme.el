;;; my-base-theme.el --- Minimal base theme for overriding defaults  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Jack Kamm

;; Author: Jack Kamm <jackkamm@gmail.com>
;; Keywords: convenience, faces

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;; Code:

(deftheme my-base
  "My minimal base theme for overriding defaults.")

(custom-theme-set-faces
 'my-base
 '(org-scheduled ((t (:inherit org-default))))
 '(org-scheduled-today ((t (:inherit org-default)))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'my-base)
;;; my-base-theme.el ends here
