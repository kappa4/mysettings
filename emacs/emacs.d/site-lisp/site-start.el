;;; site-start.el -- a startup file for the Carbon Emacs Package

;; Copyright (C) 2004-2008  Seiji Zenitani <zenitani@mac.com>

;; URL(en): http://homepage.mac.com/zenitani/emacs-e.html
;; URL(jp): http://homepage.mac.com/zenitani/emacs-j.html

;; This file is distributed under the term of the GNU General
;; Public License version 3 or later.


;;; Code:


(require 'carbon-emacs-package)

;; portable mode
(if carbon-emacs-package-portable-mode
    (setenv "HOME" (file-name-directory carbon-emacs-package-app-path)))

;; carbon-emacs-package-netinstall-on
(setq carbon-emacs-package-netinstall-on
      (and (file-exists-p "/usr/bin/make")
	   (equal carbon-emacs-package-prefix
		  (shell-quote-argument carbon-emacs-package-prefix))))

;; default settings
;; All of the below options can be configured by
;; the "Help > Carbon Emacs Package" menu in the menu bar.

;; window-system
(when (eq window-system 'mac)

  ;; inline input method
  (setq default-input-method "MacOSX")

  ;; set up an extra menu (Help > Carbon Emacs Package) in the menu bar
  (define-key menu-bar-help-menu [carbon-emacs-package-menu]
    (cons "Carbon Emacs Package" carbon-emacs-package-menu))
  (define-key-after menu-bar-help-menu [carbon-emacs-package-separater]
    '("--" . nil) 'carbon-emacs-package-menu)

  ;; mac-style key bindings
  (if (equal "YES"
             (mac-get-preference "MacKeyModeEnabled" "CarbonEmacsPackage"))
      (mac-key-mode 1))

  ;; multilingual fontsets
  (when
      (equal "YES"
             (mac-get-preference "FixedWidthFontset" "CarbonEmacsPackage"))
    (message "Loading Fixed-Width Fontsets...")
    (require 'carbon-font-lite)
    (setq carbon-emacs-package-osaka-lite-enabled t)
    (set-frame-font "fontset-osaka_lite")
    (setq default-frame-alist
          (assq-delete-all 'font default-frame-alist))
    (add-to-list 'default-frame-alist (cons 'font "fontset-osaka_lite"))
    )

  ;; print-preview extension
  (setq mac-print-coral-program
        (concat carbon-emacs-package-app-path
                "/Contents/Library/coral.app/Contents/MacOS/coral"))
  (unless
      (equal "NO"
	     (mac-get-preference "MacPrintModeEnabled" "CarbonEmacsPackage"))
    (mac-print-mode 1))

  )
;; end of window-system

;; UNIX paths (path-config.el)
(unless (equal "NO"
               (mac-get-preference "UnixPathFix" "CarbonEmacsPackage"))
  ;; path
  (carbon-emacs-package-add-to-path
   '(
     "~/bin"          ; one's own
     "/usr/texbin"    ; TeX
     "/usr/local/bin"
     "/usr/X11R6/bin" ; xdvi
     "/usr/local/teTeX/bin/i386-apple-darwin-current" ; i-Installer (intel)
     "/usr/local/teTeX/bin/powerpc-apple-darwin-current" ; i-Installer (ppc)
     "/opt/local/bin" ; MacPorts
     "/sw/bin"        ; Fink
     ))
  (message "PATH=%s" (getenv "PATH"))
  (setq carbon-emacs-package-unix-path-fixed t)
  )

;; info (ref. [macemacsjp-english 648])
(carbon-emacs-package-add-to-env
 "INFOPATH" (concat carbon-emacs-package-prefix "/info"))


;; ------------


;; load site-start.d/*.el
(let ((start-dir
       (concat carbon-emacs-package-prefix "/site-lisp/site-start.d")))
  (if (file-exists-p start-dir)
      (mapc 'load (directory-files start-dir t "\\.el\\'"))
    ))


(message
 (concat "Carbon Emacs Package ("
         (car (split-string carbon-emacs-package-version ";"))
         ")"))


;;; end
