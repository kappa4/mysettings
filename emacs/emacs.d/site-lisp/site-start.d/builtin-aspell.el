;; settings for built-in aspell

(require 'carbon-emacs-package)

;; explicit program name
(setq ispell-program-name
      (concat carbon-emacs-package-app-path "/Contents/MacOS/bin/aspell"))

;; path settings
;; (setenv "ASPELL_CONF" (concat "prefix " carbon-emacs-package-prefix))
(cond
 ((string-match "powerpc" system-configuration)
  (setenv "ASPELL_CONF"
          (concat "prefix " carbon-emacs-package-prefix ";"
                  "data-dir " carbon-emacs-package-prefix "/lib/aspell-powerpc;"
                  "dict-dir " carbon-emacs-package-prefix "/lib/aspell-powerpc;"
                  "conf-dir " carbon-emacs-package-prefix "/etc"
                  )))
 ((string-match "i386" system-configuration)
  (setenv "ASPELL_CONF"
          (concat "prefix " carbon-emacs-package-prefix ";"
                  "data-dir " carbon-emacs-package-prefix "/lib/aspell-i386;"
                  "dict-dir " carbon-emacs-package-prefix "/lib/aspell-i386;"
                  "conf-dir " carbon-emacs-package-prefix "/etc"
                  )))
 )
;; ;; path settings
;; (setenv "ASPELL_CONF"
;;         (concat "prefix " carbon-emacs-package-prefix ";"
;;                 "data-dir " carbon-emacs-package-prefix "/lib/aspell-0.60;"
;;                 "dict-dir " carbon-emacs-package-prefix "/lib/aspell-0.60;"
;;                 "conf-dir " carbon-emacs-package-prefix "/etc"
;;                 ))

;; end
