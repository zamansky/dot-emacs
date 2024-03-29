;; [[file:config.org::*Path][Path:1]]
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))
;; Path:1 ends here

;; [[file:config.org::*Custom Functions][Custom Functions:1]]
(defun load-if-exists (f)
  "load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
      (load-file f)))
;; Custom Functions:1 ends here

;; [[file:config.org::*Keybindings][Keybindings:1]]
(use-package general)

(defun z/load-iorg ()
  (interactive )
  (find-file "~/Sync/orgfiles/i.org"))

(general-define-key
 :prefix-command 'z-map

 :prefix "C-z"
 "i" 'z/load-iorg
 "m" 'mu4e
 "s" 'flyspell-correct-word-before-point
 "2" 'make-frame-command
 "0" 'delete-frame
 "o" 'other-frame
 )
;; Keybindings:1 ends here

;; [[file:config.org::*Themes and interface tweaks][Themes and interface tweaks:1]]
;; (use-package modus-operandi-theme)
(use-package modus-themes)
(load-theme 'modus-operandi t)
;;(set-frame-font "Inconsolata-18")
(set-frame-font "Firacode-18")

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1) ;; you might not want this
(setq auto-revert-verbose nil) ;; or this
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package default-text-scale)

(use-package expand-region
  :general
  ("C-=" 'er/expand-region))

(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

;; (use-package aggressive-indent 
;;   :config
;;   (global-aggressive-indent-mode 1)
;;   (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
;;   )

;; (use-package ace-window
;;   :general
;;   ("C-x O" 'other-frame)
;;   ([remap other-window] 'ace-window)
;;   :config
;;   (setq aw-scope 'frame)) ;; was global

(use-package winum
  :config
  (winum-mode))

(use-package which-key
  :config
  (which-key-mode))

(use-package pcre2el
  :config 
  (pcre-mode))

(setenv "BROWSER" "firefox")
;; Themes and interface tweaks:1 ends here

;; [[file:config.org::*exec-path-from-shell][exec-path-from-shell:1]]
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))
;; exec-path-from-shell:1 ends here

;; [[file:config.org::*Completion frameworks][Completion frameworks:1]]
;; (use-package selectrum
        ;; :init
        ;; (selectrum-mode +1))

      (use-package vertico
        :init
        (vertico-mode +1))

    (use-package orderless
      :init
      (setq completion-styles '(orderless)
            completion-category-defaults nil
            completion-category-overrides '((file (styles partial-completion)))))

    ;; Persist history over Emacs restarts. Vertico sorts by history position.
    (use-package savehist
      :init
      (savehist-mode))


      (use-package marginalia
        :config (marginalia-mode))

      (use-package consult
        :general
        ("M-y" 'consult-yank-from-kill-ring
         "C-x b" 'consult-buffer))
    (recentf-mode)

      (setq completion-ignore-case t)
      (setq read-file-name-completion-ignore-case t)



      (use-package orderless
        :init
        (setq completion-styles '(orderless)))

      ;; (use-package company
      ;;   :config
      ;;   (setq company-idle-delay 0)
      ;;   (setq company-minimum-prefix-length 3)
      ;;   (global-company-mode t))


(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                 ; Allows cycling through candidates
  (corfu-auto t)                  ; Enable auto completion
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-echo-documentation 0.25) ; Enable documentation for completions
  (corfu-preview-current 'insert) ; Do not preview current candidate
  (corfu-preselect-first nil)
  (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  :bind (:map corfu-map
              ("M-SPC" . corfu-insert-separator)
              ("TAB"     . corfu-next)
              ([tab]     . corfu-next)
              ("S-TAB"   . corfu-previous)
              ([backtab] . corfu-previous)
              ("S-<return>" . corfu-insert)
              ("RET"     . nil) ;; leave my enter alone!
              )

  :init
  (global-corfu-mode)
  ;;(corfu-history-mode)

  :config
  (setq tab-always-indent 'complete)
  (add-hook 'eshell-mode-hook
            (lambda () (setq-local corfu-quit-at-boundary t
                              corfu-quit-no-match t
                              corfu-auto nil)
              (corfu-mode))))


    (use-package embark
    :ensure t

    :bind
    (("C-." . embark-act)         ;; pick some comfortable binding
     ("C-;" . embark-dwim)        ;; good alternative: M-.
     ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

     :init

     ;; Optionally replace the key help with a completing-read interface
     (setq prefix-help-command #'embark-prefix-help-command)

     :config

     ;; Hide the mode line of the Embark live/completions buffers
     (add-to-list 'display-buffer-alist
                  '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                    nil
                    (window-parameters (mode-line-format . none))))

    )

  ;; Consult users will also want the embark-consult package.
  (use-package embark-consult
    :ensure t
    :after (embark consult)
    :demand t ; only necessary if you have the hook below
    ;; if you want to have consult previews as you move around an
    ;; auto-updating embark collect buffer
    :hook
    (embark-collect-mode . consult-preview-at-point-mode))
;; Completion frameworks:1 ends here

;; [[file:config.org::*org][org:1]]
(use-package ox-reveal)

(require 'org-protocol)


(custom-set-variables
 '(org-directory "~/Sync/orgfiles")
 '(org-default-notes-file (concat org-directory "/notes.org"))
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(org-confirm-babel-evaluate nil)
 '(org-src-fontify-natively t)
 '(org-export-with-toc nil)
 )


(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


(global-set-key "\C-ca" 'org-agenda)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((agenda "")
          (alltodo "")))))

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-agenda-files (list "~/opt/gcal.org"
                             "~/opt/soe-cal.org"
                             "~/Sync/orgfiles/i.org"))
(setq org-capture-templates
      '(("l" "Link" entry (file+headline "~/Sync/orgfiles/links.org" "Links")
         "* %a %^g\n %?\n %T\n %i")
        ("b" "Blog idea" entry (file+headline "~/Sync/orgfiles/i.org" "POSTS:")
         "* %?\n%T" :prepend t)
        ("t" "To Do Item" entry (file+headline "~/Sync/orgfiles/i.org" "To Do and Notes")
         "* TODO %?\n%u" :prepend t)
        ("m" "Mail To Do" entry (file+headline "~/Sync/orgfiles/i.org" "To Do and Notes")
         "* TODO %a\n %?" :prepend t)
        ("n" "Note" entry (file+olp "~/Sync/orgfiles/i.org" "Notes")
         "* %u %? " :prepend t)
        ("r" "RSS" entry (file+headline "~/Sync/shared/elfeed.org" "Feeds misc")
         "** %A %^g\n")))



(use-package htmlize)

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

(setq org-file-apps
      (append '(
                ("\\.pdf\\'" . "evince %s")
                ("\\.x?html?\\'" . "/usr/bin/firefox %s")
                ) org-file-apps ))

;; babel stuff
(require 'ob-clojure)
(require 'ob-gnuplot)
(use-package ob-restclient :ensure t)
(require 'ob-restclient)
(setq org-babel-clojure-backend 'cider)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (restclient . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (shell . t)
   (java . t)
   (C . t)
   (clojure . t)
   (js . t)
   (ditaa . t)
   (dot . t)
   (org . t)
   (latex . t )
   ))


(setq mail-user-agent 'mu4e-user-agent)
(use-package org-msg
  :config
  (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil tex:dvipng")
  (setq org-msg-startup "hidestars indent inlineimages")
  (setq org-msg-greeting-fmt "\n%s,\n\n")
  (setq org-msg-greeting-fmt-mailto t)
  (setq org-msg-signature "
            #+begin_signature
            -- *Mike* \\\\
            #+end_signature")
  (org-msg-mode))


(require 'org-tempo)  ;; to bring back easy templates using <s or <n



(require 'ox-publish)
(setq org-publish-project-alist
      '(("home_page"
         :base-directory "~/Sync/hunter/sites/home_page/"
         :base-extension "org"
         :publishing-directory "/ssh:zamansky@info.huntercs.org:/var/www/html/home_page/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("home_static"
         :base-directory "~/Sync/hunter/sites/home_page/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "/ssh:zamansky@info.huntercs.org:/var/www/html/home_page/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("teacher_ed"
         :base-directory "~/Sync/hunter/sites/teacher_ed/"
         :base-extension "org"
         :publishing-directory "/ssh:zamansky@info.huntercs.org:/var/www/html/teacher_ed/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ))


(setq org-refile-targets '((nil :maxlevel . 2)))


(defun org-agenda-show-agenda-and-todo (&optional arg)
  (interactive "P")
  (org-agenda arg "c")
  (org-agenda-fortnight-view))
;; org:1 ends here

;; [[file:config.org::*Hydra][Hydra:1]]
(use-package hydra)
;; Hydra:1 ends here

;; [[file:config.org::*Elfeed][Elfeed:1]]
(setq elfeed-db-directory "~/Sync/shared/elfeeddb")

(defun mz/elfeed-browse-url (&optional use-generic-p)
  "Visit the current entry in your browser using `browse-url'.
  If there is a prefix argument, visit the current entry in the
  browser defined by `browse-url-generic-program'."
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (if use-generic-p
                    (browse-url-generic (elfeed-entry-link entry))
                  (browse-url (elfeed-entry-link entry))))
    (mapc #'elfeed-search-update-entry entries)
    (unless (or elfeed-search-remain-on-entry (use-region-p))
      ;;(forward-line)
      )))



(defun elfeed-mark-all-as-read ()
  (interactive)
  (mark-whole-buffer)
  (elfeed-search-untag-all-unread))


;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))




(use-package elfeed
  :bind (:map elfeed-search-mode-map
              ("q" . bjm/elfeed-save-db-and-bury)
              ("Q" . bjm/elfeed-save-db-and-bury)
              ("m" . elfeed-toggle-star)
              ("M" . elfeed-toggle-star)
              ("j" . mz/make-and-run-elfeed-hydra)
              ("J" . mz/make-and-run-elfeed-hydra)
              ("b" . mz/elfeed-browse-url)
              ("B" . elfeed-search-browse-url)
              )
  :config
  (defalias 'elfeed-toggle-star
    (elfeed-expose #'elfeed-search-toggle-all 'star))

  )

(use-package elfeed-goodies
  :config
  (elfeed-goodies/setup))


(use-package elfeed-org
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/Sync/shared/elfeed.org")))





(defun z/hasCap (s) ""
       (let ((case-fold-search nil))
         (string-match-p "[[:upper:]]" s)
         ))


(defun z/get-hydra-option-key (s)
  "returns single upper case letter (converted to lower) or first"
  (interactive)
  (let ( (loc (z/hasCap s)))
    (if loc
        (downcase (substring s loc (+ loc 1)))
      (substring s 0 1)
      )))

;;  (active blogs cs eDucation emacs local misc sports star tech unread webcomics)
(defun mz/make-elfeed-cats (tags)
  "Returns a list of lists. Each one is line for the hydra configuratio in the form
         (c function hint)"
  (interactive)
  (mapcar (lambda (tag)
            (let* (
                   (tagstring (symbol-name tag))
                   (c (z/get-hydra-option-key tagstring))
                   )
              (list c (append '(elfeed-search-set-filter) (list (format "@6-months-ago +%s" tagstring) ))tagstring  )))
          tags))





(defmacro mz/make-elfeed-hydra ()
  `(defhydra mz/hydra-elfeed ()
     "filter"
     ,@(mz/make-elfeed-cats (elfeed-db-get-all-tags))
     ("*" (elfeed-search-set-filter "@6-months-ago +star") "Starred")
     ("M" elfeed-toggle-star "Mark")
     ("A" (elfeed-search-set-filter "@6-months-ago") "All")
     ("T" (elfeed-search-set-filter "@1-day-ago") "Today")
     ("Q" bjm/elfeed-save-db-and-bury "Quit Elfeed" :color blue)
     ("q" nil "quit" :color blue)
     ))




(defun mz/make-and-run-elfeed-hydra ()
  ""
  (interactive)
  (mz/make-elfeed-hydra)
  (mz/hydra-elfeed/body))


(defun my-elfeed-tag-sort (a b)
  (let* ((a-tags (format "%s" (elfeed-entry-tags a)))
         (b-tags (format "%s" (elfeed-entry-tags b))))
    (if (string= a-tags b-tags)
        (< (elfeed-entry-date b) (elfeed-entry-date a)))
    (string< a-tags b-tags)))


(setf elfeed-search-sort-function #'my-elfeed-tag-sort)
;; Elfeed:1 ends here

;; [[file:config.org::*diredstuff][diredstuff:1]]
(use-package diredfl
:config 
(diredfl-global-mode 1))

(setq 
 dired-listing-switches "-lXGh --group-directories-first"
   dired-dwim-target t)
;;(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;; diredstuff:1 ends here

;; [[file:config.org::*floobits][floobits:1]]
(use-package floobits :ensure t)
;; floobits:1 ends here

;; [[file:config.org::*Snippets][Snippets:1]]
(use-package yasnippet
  :init
    (yas-global-mode 1))

(use-package yasnippet-snippets)
(use-package yasnippet-classic-snippets)
;; Snippets:1 ends here

;; [[file:config.org::*Proectile][Proectile:1]]
(use-package projectile)
(projectile-mode +1)
;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; Proectile:1 ends here

;; [[file:config.org::*Magit][Magit:1]]
;; some ediff settings
 (setq ediff-diff-options "")
 (setq ediff-custom-diff-options "-u")
 (setq ediff-window-setup-function 'ediff-setup-windows-plain)
 (setq ediff-split-window-function 'split-window-vertically)

 (use-package magit
         :init
     (progn
 (setq magit-section-initial-visibility-alist
       '((stashes . hide) (untracked . hide) (unpushed . hide)))


     (bind-key "C-x g" 'magit-status)
     ))

 (setq magit-status-margin
   '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))

     (use-package git-timemachine
         )

 ;; (use-package git-gutter-fringe
 ;;
 ;; :config
 ;;(global-git-gutter-mode))


 (use-package magit-delta
 :hook (magit-mode . magit-delta-mode))

;; (use-package forge)
;; Magit:1 ends here

;; [[file:config.org::*lsp][lsp:1]]
(use-package lsp-mode

  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
         (java-mode . lsp)
         (clojure-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(setq python-shell-interpreter "python3")

(use-package lsp-java)
;; lsp:1 ends here

;; [[file:config.org::*Clojure][Clojure:1]]
(use-package paredit)
(use-package multiple-cursors)
  (use-package inflections)

  (use-package parseclj)
    (use-package cider
        :config
        ;;(add-hook 'cider-repl-mode-hook #'company-mode)
        ;; (add-hook 'cider-mode-hook #'company-mode)
        (add-hook 'cider-mode-hook #'eldoc-mode)
    ;;    (add-hook 'cider-mode-hook #'cider-hydra-mode)
        (setq cider-repl-use-pretty-printing t)
        (setq cider-repl-display-help-banner nil)
        ;;    (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

        :bind (("M-r" . cider-namespace-refresh)
               ("C-c r" . cider-repl-reset)
               ("C-c ." . cider-reset-test-run-tests))
        )

      (defun my-clojure-mode-hook ()
        (clj-refactor-mode 1)
        (yas-minor-mode 1) ; for adding require/use/import statements
        ;; This choice of keybinding leaves cider-macroexpand-1 unbound
        (cljr-add-keybindings-with-prefix "C-c C-m"))
    (use-package clj-refactor
      :config
    (add-hook 'clojure-mode-hook #'my-clojure-mode-hook))
;; Clojure:1 ends here

;; [[file:config.org::*Rust][Rust:1]]
(use-package rustic)
(setq rustic-lsp-client 'lsp)
;; Rust:1 ends here

;; [[file:config.org::*Parens stuff][Parens stuff:1]]
(use-package paren
  :config
  (setq show-paren-style 'expression)
  (setq show-paren-when-point-in-periphery t)
  (setq show-paren-when-point-inside-paren nil)
  :hook (after-init-hook . show-paren-mode))
;; Parens stuff:1 ends here

;; [[file:config.org::*Parens stuff][Parens stuff:2]]
(use-package puni
  :config
  (dolist (hook '(prog-mode-hook sgml-mode-hook nxml-mode-hook tex-mode-hook eval-expression-minibuffer-setup-hook))
(add-hook hook #'puni-mode))
)
;; Parens stuff:2 ends here

;; [[file:config.org::*Parens stuff][Parens stuff:4]]
;;  (add-hook 'clojure-mode-hook #'smartparens-mode)
;; Parens stuff:4 ends here

;; [[file:config.org::*Web stuff][Web stuff:1]]
(use-package web-mode)
(add-hook 'html-mode-hook 'web-mode) ;; Auto-start on any markup modes
(use-package emmet-mode)
(add-hook 'web-mode-hook  'emmet-mode)
;; Web stuff:1 ends here

;; [[file:config.org::*mu4e][mu4e:1]]
(use-package mu4e)
;; mu4e:1 ends here

;; [[file:config.org::*dirvish][dirvish:1]]
;; (use-package dirvish
;;   :ensure t
;;   :init
;;   ;; Let Dirvish take over Dired globally
;;   (dirvish-override-dired-mode))
;; dirvish:1 ends here

;; [[file:config.org::*refile this][refile this:1]]
(setq user-full-name "Mike Zamansky"
      user-mail-address "mz631@hunter.cuny.edu")
;; (global-set-key [mouse-3] 'flyspell-correct-word-before-point)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; generic interface tweaks and variable setting




(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'mu4e-compose-mode-hook 'turn-on-flyspell)
(add-hook 'mu4e-compose-mode-hook 'turn-on-auto-fill)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load other files
(load-if-exists "~/Sync/shared/mu4econfig.el")
(load-if-exists "~/Sync/shared/not-for-github.el")


(setq dired-guess-shell-alist-user '(("" "xdg-open")))
;; refile this:1 ends here
