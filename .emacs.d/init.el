(add-to-list 'load-path "~/.emacs.d/maninstalls/")

(desktop-save-mode 1) ;;Save desktop on exit
(menu-bar-mode -1)

;;http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
 
;;window size
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 200))

;;Horizontal split mode
(setq split-height-threshold nil)
(setq split-width-threshold 400) ;;Setting threshold very high to always split horizontally

(setq mac-option-modifier nil mac-command-modifier 'meta x-select-enable-clipboard t) ;Makes it possible to write curly and square braces on swedish mac keyboard

(show-paren-mode 1) ;Enables paren matching
(setq show-paren-delay 0) ;Eliminate show paren delay

(set 'indent-tabs-mode nil) ;;no tabs, just spaces

(require 'package)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) (package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t) (package-initialize)

;;make kill and yank work with X clipboard
(unless (package-installed-p 'xclip) (package-install 'xclip))
(require 'xclip)
(xclip-mode 1)
(turn-on-xclip)
(delete-selection-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;Installed according to instructions on https://github.com/technomancy/clojure-mode/blob/master/README.md (using M-x package-install)
(unless (package-installed-p 'clojure-mode) (package-install 'clojure-mode))
(require 'clojure-mode)

;Info from https://github.com/brentonashworth/one/wiki/Emacs
(add-to-list 'auto-mode-alist '("\.cljx$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\.edn$" . clojure-mode))

;cider stuff
(unless (package-installed-p 'exec-path-from-shell) (package-install 'exec-path-from-shell)) ;;or M-x package-install "exec-path-from-shell", prerequisite for cider-jack-in to work
(when (memq window-system '(mac ns)) (exec-path-from-shell-initialize))
(unless (package-installed-p 'cider) (package-install 'cider))
(require 'cider)
(setq cider-prompt-for-symbol nil)
(setq cider-popup-stacktraces nil)
(add-hook 'cider-mode-hook #'eldoc-mode)
(setq cider-hide-special-buffers t) ;;does not go through result buffers and such stuff when doing C-c b.
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;;http://blog.worldcognition.com/2012/07/setting-up-emacs-for-clojure-programming.html
;;-- also "popup" is needed, but it might have been automatically downloaded as a dependency
(unless (package-installed-p 'auto-complete) (package-install 'auto-complete))
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop) ; use M-/ to stop completion
;;M-x package-install "ac-nrepl" -- incompatible with austin and piggieback according to cemerick 14 feb 2014
;;(unless (package-installed-p 'ac-nrepl) (package-install 'ac-nrepl))
;;(require 'ac-nrepl)
;;(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
;;(add-hook 'cider-interaction-mode-hook 'ac-nrepl-setup)
;;(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'cider-repl-mode))

(defun nrepl-project-directory () (clojure-project-dir))
(defun nrepl-project-relative-to-absolute-path (relative-path) (format "%s%s" (nrepl-project-directory) relative-path))
(defun nrepl-project-name () (replace-regexp-in-string "_" "-" (file-name-nondirectory (directory-file-name (nrepl-project-directory)))))
(defvar nrepl-init-proj-name nil)
(defun nrepl-project-dev-ns-name () (format "%s.dev" (nrepl-project-name)))
(defun nrepl-eval (source-code-str)
  (nrepl-sync-request:eval source-code-str
                           (cider-default-connection)
                           (cider-current-session)))
(defun set-dev-ns ()  
  (message (format "Requiring dev ns '%s'..." nrepl-init-proj-name))
  ;(cider-load-file (nrepl-project-relative-to-absolute-path "dev/dev.clj"))
  (nrepl-eval (format "(require '%s) (in-ns '%s)" nrepl-init-proj-name nrepl-init-proj-name))
  (cider-repl-set-ns nrepl-init-proj-name))
(defun dev-reload-and-retest       () (set-dev-ns) (message "%s" (nrepl-dict-get (nrepl-eval "(reload-and-retest)")       "value")))
(defun dev-reload-retest-and-start () (set-dev-ns) (message "%s" (nrepl-dict-get (nrepl-eval "(reload-retest-and-start)") "value")))

(defun init-dev-env ()
  (paredit-mode +1)
  (set 'cider-test-show-report-on-success 1)
  ;;(set 'cider-interactive-eval-output-destination 'output-buffer) ;;no effect..
  (set 'nrepl-init-proj-name (nrepl-project-dev-ns-name)))

;Installed paredit.el via M-x package-install, paredit
(unless (package-installed-p 'paredit) (package-install 'paredit))
(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)

(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1) (local-set-key (kbd "C-c C-k") (lambda () (interactive) (eval-buffer)))))

(set 'clojure-mode-hook nil) ;;seems to have no effect
(add-hook 'clojure-mode-hook
          (lambda ()
            (paredit-mode +1)
            (set 'cider-repl-pop-to-buffer-on-connect nil)
            (local-set-key (kbd "<f3>") (lambda () (interactive) (remove-hook 'nrepl-connected-hook 'init-dev-env) (cider-restart)))
            (local-set-key (kbd "<f4>") (lambda () (interactive) (add-hook    'nrepl-connected-hook 'init-dev-env) (cider-restart)))
            (local-set-key (kbd "<f5>") (lambda () (interactive) (init-dev-env) (dev-reload-and-retest)))
	    (local-set-key (kbd "<f6>") (lambda () (interactive) (dev-reload-and-retest)))
            (local-set-key (kbd "<f7>") (lambda () (interactive) (dev-reload-retest-and-start)))))

(global-set-key (kbd "<f11>") (lambda () (interactive) (switch-to-buffer "*Messages*")))

(require 'ido)
(ido-mode t)

;;install org-mode: package-install org
;;(require 'ox-reveal)
;;(setq org-reveal-root "file:///Users/molst/dev/3rd/reveal.js/js/reveal.js")
