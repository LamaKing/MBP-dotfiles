;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Custom setting
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages
   (quote
    (pungi exec-path-from-shell auto-virtualenv jedi company-jedi)))
 '(show-paren-mode t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;---------------------------------------------------------------------------------------
;; ORG mode 
;;---------------------------------------------------------------------------------------
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-startup-indented t)
(setq org-todo-keywords
      '((sequence "TODO" "WAITING" "VERIFY" "|" "✔ DONE" "DELEGATED" "✘ CANCELED")
	(sequence "REPORT" "BUG" "IMPROVE" "|" "FIXED")))
(setq org-todo-keyword-faces
  '(("TODO" . org-warning)
   ("WAITING" . "yellow")
   ("VERIFY" . "orange")
   ("DONE" . "green")
   ("DELEGATED" .  "blue")
   ("CANCELED" .  "blue")))

;;---------------------------------------------------------------------------------------
;; Miscellaneous 
;;---------------------------------------------------------------------------------------
;; Highligh matching parentesis
(show-paren-mode 1)

;; no startup msg  
(setq inhibit-startup-message t)        ; Disable startup message 

;; OsX Italian keyboard: cmd, not ctrl as command and alt as modifier (brakets and hastag)
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier nil)

;; Enable CUA mode for rectangle selection
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted

;; This is not enable by default in emacs
(setq vc-follow-symlinks t)

;; Set tabs
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 4 120 4))
(setq-default tab-width 4)

;; Delete trailing whitespace automatically on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;---------------------------------------------------------------------------------------
;; Organize backups
;;---------------------------------------------------------------------------------------
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;;---------------------------------------------------------------------------------------
;; Packages manager 
;;---------------------------------------------------------------------------------------
;; MELPA setup
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; packages -> Might be obsolate after the melpa conf
;;(when (>= emacs-major-version 24)
;;  (require 'package)
;;  (package-initialize)
;;  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;  )
(add-to-list 'load-path "~/.emacs.d/pkgs")
;; Add pkg dir to path


;;---------------------------------------------------------------------------------------
;; Python syntax
;;---------------------------------------------------------------------------------------
;; set jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

;;---------------------------------------------------------------------------------------
;; SSH service config
;;---------------------------------------------------------------------------------------
;; TRAMP 
(require 'tramp)
;; (custom-set-variables '(tramp-verbose 0))
(setq tramp-debug-buffer t)
;; Escape properly: if you have custom prompt TRAMP may hang waiting for a good shell. Escape your custom shit.
(setq shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*" ) 
