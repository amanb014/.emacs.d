; ;;; Begin initialization
; ;; Turn off mouse interface early in startup to avoid momentary display
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

;; debug on error
(set 'debug-on-error t)

;; initial messages clearing
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; dont prefer outdated byte code
(setq load-prefer-newer t)

;; this line must exist; do not remove
(package-initialize)
;; configure auto file backups
;; set a variable for convenience
(defvar dir-file-backups (concat user-emacs-directory "file_backups"))

;; create directory if it doesnt exist
(unless (file-exists-p dir-file-backups) (make-directory dir-file-backups))
;; set configuration
(setq auto-save-list-file-name (concat dir-file-backups "/auto-save-list"))
(setq
 backup-directory-alist `(("." . ,dir-file-backups))
 backup-by-copying t
 delete-old-versions t
 kept-new-versions 3
 kept-old-versions 1
 version-control nil)

;; configure custom file
;; this is where emacs will place all of its auto-saved config
;; create file if it doesnt exist
(defvar custom-file-path (concat user-emacs-directory "custom.el"))
(unless (file-exists-p custom-file-path) (write-region "" nil custom-file-path))

;; use own custom file path
(setq custom-file custom-file-path)
(load custom-file)

;; stop dired creating new buffers when entering directories
(require 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
(put 'dired-find-alternate-file 'disabled nil)

;; add custom directory to load path
(add-to-list 'load-path (concat user-emacs-directory "aman"))

;; custom emacs settings called in this file
(require 'settings)

;; loading packages for init and setting configs
(require 'packages)

;; load the theme package and start the theme
(require 'theme)
