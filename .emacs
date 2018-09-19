;;; Add this at the top of the init.el file:
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Org mode
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp" t)
;; (add-to-list 'load-path "~/.emacs.d/eclim/emacs-eclim")

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"))
 '(custom-safe-themes
   (quote
    ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(fci-rule-color "#073642")
 '(global-semantic-idle-completions-mode t nil (semantic/idle))
 '(helm-mode t)
 '(jdee-server-dir "~/jdee-libs")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (solarized-theme color-theme-solarized color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow ag ac-helm ace-jump-helm-line all-ext f3 helm helm-R helm-ack helm-ad helm-addressbook helm-ag helm-ag-r helm-anything helm-aws helm-backup helm-bbdb helm-bibtex helm-bibtexkey helm-bind-key helm-bm helm-c-moccur helm-c-yasnippet helm-charinfo helm-chronos helm-cider helm-cider-history helm-circe helm-clojuredocs helm-cmd-t helm-codesearch helm-commandlinefu helm-company helm-core helm-cscope helm-css-scss helm-dash helm-descbinds helm-describe-modes helm-dictionary helm-dirset helm-ebdb helm-elscreen helm-emmet helm-emms helm-etags-plus helm-ext helm-filesets helm-firefox helm-flx helm-flycheck helm-flymake helm-flyspell helm-frame helm-ghc helm-ghq helm-ghs helm-go-package helm-grepint helm-growthforecast helm-gtags helm-hatena-bookmark helm-hayoo helm-hunks helm-idris helm-img helm-img-tiqav helm-ispell helm-itunes helm-j-cheatsheet helm-jstack helm-kythe helm-lastpass helm-lobsters helm-ls-git helm-ls-hg helm-ls-svn helm-make helm-migemo helm-mode-manager helm-mt helm-mu helm-navi helm-nixos-options helm-notmuch helm-open-github helm-org-rifle helm-orgcard helm-package helm-pages helm-pass helm-perldoc helm-perspeen helm-phpunit helm-proc helm-project-persist helm-projectile helm-prosjekt helm-pt helm-purpose helm-pydoc helm-qiita helm-rage helm-rails helm-rb helm-rdefs helm-recoll helm-rhythmbox helm-robe helm-ros helm-rtags helm-rubygems-local helm-rubygems-org helm-safari helm-sage helm-sheet helm-smex helm-spaces helm-spotify helm-spotify-plus helm-sql-connect helm-swoop helm-systemd helm-themes helm-tramp helm-unicode helm-w32-launcher helm-w3m helm-wordnet helm-xcdoc helm-xref helm-zhihu-daily ac-emacs-eclim company-emacs-eclim eclim helm-books helm-bundle-show helm-chrome helm-directory helm-dired-history helm-dired-recent-dirs helm-fuzzier helm-fuzzy-find helm-git helm-git-files helm-git-grep helm-github-stars helm-gitignore helm-gitlab helm-google helm-helm-commands helm-hoogle helm-youtube powerline powerline-evil smart-mode-line fiplr evil-anzu evil-args evil-avy evil-cleverparens evil-colemak-basics evil-colemak-minimal evil-commentary evil-easymotion evil-ediff evil-embrace evil-escape evil-exchange evil-extra-operator evil-find-char-pinyin evil-god-state evil-iedit-state evil-indent-plus evil-indent-textobject evil-leader evil-ledger evil-lion evil-lisp-state evil-lispy evil-magit evil-mark-replace evil-matchit evil-mc evil-mc-extras evil-mu4e evil-multiedit evil-nerd-commenter evil-numbers evil-opener evil-org evil-paredit evil-quickscope evil-rails evil-replace-with-register evil-rsi evil-search-highlight-persist evil-smartparens evil-snipe evil-space evil-surround evil-swap-keys evil-terminal-cursor-changer evil-test-helpers evil-text-object-python evil-textobj-anyblock evil-textobj-column evil-tutor-ja evil-vimish-fold evil-visual-mark-mode evil-visual-replace evil-visualstar ## evil-goggles evil-tutor evil-tabs evil-dvorak evil fuzzy elf-mode dirtree jdee dired+ diffview)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq evil-want-C-u-scroll t)
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(load-theme 'zenburn t)
(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq sml/theme 'respectful)


(require 'linum)
(set-face-attribute 'linum nil
                    :background (face-attribute 'default :background)
                    :foreground (face-attribute 'font-lock-comment-face :foreground))
(defface linum-current-line-face
  `((t :background "gray30" :foreground "gold"))
  "Face for the currently active Line number")
(defvar my-linum-current-line-number 0)
(defun get-linum-format-string ()
  (setq-local my-linum-format-string
              (let ((w (length (number-to-string
                                (count-lines (point-min) (point-max))))))
                (concat " %" (number-to-string w) "d "))))
(add-hook 'linum-before-numbering-hook 'get-linum-format-string)
(defun my-linum-format (line-number)
  (propertize (format my-linum-format-string line-number) 'face
              (if (eq line-number my-linum-current-line-number)
                  'linum-current-line-face
                'linum)))
(setq linum-format 'my-linum-format)
(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)


(defun num ()
  (interactive)
  (if (bound-and-true-p relative-line-numbers-mode)
      (relative-line-numbers-mode 'toggle))
  (linum-mode 'toggle))
(defun rnum ()
  (interactive)
  (if (bound-and-true-p linum-mode)
      (linum-mode 'toggle))
  (relative-line-numbers-mode 'toggle))

(fringe-mode '(4 . 4))

(column-number-mode 1)
(require 'powerline)
(if (display-graphic-p)
    (progn
      (setq powerline-default-separator 'wave)
      (setq powerline-height 25)))
(setq powerline-default-separator-dir '(right . left))

(require 'linum)
(global-linum-mode 1)

(recentf-mode 1)
(setq recentf-max-menu-items 50)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(require 'auto-complete-config)
(ac-config-default)

; (global-set-key "\C-x\ g" 'fiplr-find-file)
; (global-set-key "\C-x\ \C-g" 'helm-grep)
(global-set-key "\C-x\ e" 'helm-find-files)
(global-set-key "\C-x\ g" 'helm-semantic-or-imenu)


(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; backup dir
;; (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; time
(display-time-mode 1)


;; org mode config
(setq org-log-done t
      org-todo-keywords '((sequence "TODO" "INPROGRESS" "DONE"))
      org-todo-keyword-faces '(("INPROGRESS" . (:foreground "blue" :weight bold))))
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-show-log t
      org-agenda-todo-ignore-scheduled t
      org-agenda-todo-ignore-deadlines t)
(setq org-agenda-files (list "~/.emacs.d/agenda/personal.org"
                             "~/.emacs.d/agenda/groupon.org"))

(require 'org)
(require 'org-install)
(require 'org-habit)
(add-to-list 'org-modules "org-habit")
(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)

(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

(setq column-number-mode t)


;; eclim
;; add the emacs-eclim source
;; (require 'eclim)
;; (setq eclimd-autostart t)

;; (defun my-java-mode-hook ()
;;    (eclim-mode t))

;; (add-hook 'java-mode-hook 'my-java-mode-hook)

;(require 'ac-emacs-eclim-source)
;(ac-emacs-eclim-config)

;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)


;; (custom-set-variables
;;  '(eclim-eclipse-dirs '("/opt/eclim/eclipse-4.7.0/eclipse"))
;;  '(eclim-executable "/opt/eclim/eclipse-4.7.0/eclipse/eclim"))

(setq jdee-maven-disabled-p t)
