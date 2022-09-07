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

(use-package ace-window
  :general
  ("C-x O" 'other-frame)
  ([remap other-window] 'ace-window)
  :config
  (setq aw-scope 'frame)) ;; was global

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

    (use-package company
      :config
      (setq company-idle-delay 0)
      (setq company-minimum-prefix-length 3)
      (global-company-mode t))


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
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
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

(use-package forge)
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
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(setq python-shell-interpreter "python3")
;; lsp:1 ends here

;; [[file:config.org::*Clojure][Clojure:1]]
(use-package parseclj)
  (use-package cider
      :config
      (add-hook 'cider-repl-mode-hook #'company-mode)
      (add-hook 'cider-mode-hook #'company-mode)
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
  :ensure t
  :config
  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook))
;; Clojure:1 ends here

;; [[file:config.org::*Parens stuff][Parens stuff:1]]
(use-package paren
  :config
  (setq show-paren-style 'expression)
  (setq show-paren-when-point-in-periphery t)
  (setq show-paren-when-point-inside-paren nil)
  :hook (after-init-hook . show-paren-mode))
;; Parens stuff:1 ends here

;; [[file:config.org::*Parens stuff][Parens stuff:2]]
(use-package smartparens)

  (require 'smartparens-config)

  (add-hook 'minibuffer-setup-hook 'turn-on-smartparens-strict-mode)

  ;;;;;;;;;;;;;;;;;;;;;;;;
  ;; keybinding management
  (define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
  (define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)

  (define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
  (define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
  (define-key smartparens-mode-map (kbd "C-S-d") 'sp-beginning-of-sexp)
  (define-key smartparens-mode-map (kbd "C-S-a") 'sp-end-of-sexp)

  (define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
  (define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
  (define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)

  (define-key smartparens-mode-map (kbd "C-M-n") 'sp-forward-hybrid-sexp)
  (define-key smartparens-mode-map (kbd "C-M-p") 'sp-backward-hybrid-sexp)

  (define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
  (define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)

  (define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
  (define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

  (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
  (define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

  (define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
  (define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
  (define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
  (define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

  (define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
  (define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
  (define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)

  (define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
  (define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

  (define-key smartparens-mode-map (kbd "C-\"") 'sp-change-inner)
  (define-key smartparens-mode-map (kbd "M-i") 'sp-change-enclosing)

  (bind-key "C-c f" (lambda () (interactive) (sp-beginning-of-sexp 2)) smartparens-mode-map)
  (bind-key "C-c b" (lambda () (interactive) (sp-beginning-of-sexp -2)) smartparens-mode-map)

  (bind-key "C-M-s"
            (defhydra smartparens-hydra ()
              "Smartparens"
              ("d" sp-down-sexp "Down")
              ("e" sp-up-sexp "Up")
              ("u" sp-backward-up-sexp "Up")
              ("a" sp-backward-down-sexp "Down")
              ("f" sp-forward-sexp "Forward")
              ("b" sp-backward-sexp "Backward")
              ("k" sp-kill-sexp "Kill" :color blue)
              ("q" nil "Quit" :color blue))
            smartparens-mode-map)

  (bind-key "H-t" 'sp-prefix-tag-object smartparens-mode-map)
  (bind-key "H-p" 'sp-prefix-pair-object smartparens-mode-map)
  (bind-key "H-y" 'sp-prefix-symbol-object smartparens-mode-map)
  (bind-key "H-h" 'sp-highlight-current-sexp smartparens-mode-map)
  (bind-key "H-e" 'sp-prefix-save-excursion smartparens-mode-map)
  (bind-key "H-s c" 'sp-convolute-sexp smartparens-mode-map)
  (bind-key "H-s a" 'sp-absorb-sexp smartparens-mode-map)
  (bind-key "H-s e" 'sp-emit-sexp smartparens-mode-map)
  (bind-key "H-s p" 'sp-add-to-previous-sexp smartparens-mode-map)
  (bind-key "H-s n" 'sp-add-to-next-sexp smartparens-mode-map)
  (bind-key "H-s j" 'sp-join-sexp smartparens-mode-map)
  (bind-key "H-s s" 'sp-split-sexp smartparens-mode-map)
  (bind-key "H-s r" 'sp-rewrap-sexp smartparens-mode-map)
  (defvar hyp-s-x-map)
  (define-prefix-command 'hyp-s-x-map)
  (bind-key "H-s x" hyp-s-x-map smartparens-mode-map)
  (bind-key "H-s x x" 'sp-extract-before-sexp smartparens-mode-map)
  (bind-key "H-s x a" 'sp-extract-after-sexp smartparens-mode-map)
  (bind-key "H-s x s" 'sp-swap-enclosing-sexp smartparens-mode-map)

  (bind-key "C-x C-t" 'sp-transpose-hybrid-sexp smartparens-mode-map)

  (bind-key ";" 'sp-comment emacs-lisp-mode-map)

  (bind-key [remap c-electric-backspace] 'sp-backward-delete-char smartparens-strict-mode-map)

  ;;;;;;;;;;;;;;;;;;
  ;; pair management

  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
  (bind-key "C-(" 'sp---wrap-with-40 minibuffer-local-map)

  (sp-with-modes 'org-mode
    (sp-local-pair "=" "=" :wrap "C-="))

  (sp-with-modes 'textile-mode
    (sp-local-pair "*" "*")
    (sp-local-pair "_" "_")
    (sp-local-pair "@" "@"))

  (sp-with-modes 'web-mode
    (sp-local-pair "{{#if" "{{/if")
    (sp-local-pair "{{#unless" "{{/unless"))

  ;;; tex-mode latex-mode
  (sp-with-modes '(tex-mode plain-tex-mode latex-mode)
    (sp-local-tag "i" "\"<" "\">"))

  ;;; lisp modes
  (sp-with-modes sp--lisp-modes
    (sp-local-pair "(" nil
                   :wrap "C-("
                   :pre-handlers '(my-add-space-before-sexp-insertion)
                   :post-handlers '(my-add-space-after-sexp-insertion)))

  (defun my-add-space-after-sexp-insertion (id action _context)
    (when (eq action 'insert)
      (save-excursion
        (forward-char (sp-get-pair id :cl-l))
        (when (or (eq (char-syntax (following-char)) ?w)
                  (looking-at (sp--get-opening-regexp)))
          (insert " ")))))

  (defun my-add-space-before-sexp-insertion (id action _context)
    (when (eq action 'insert)
      (save-excursion
        (backward-char (length id))
        (when (or (eq (char-syntax (preceding-char)) ?w)
                  (and (looking-back (sp--get-closing-regexp))
                       (not (eq (char-syntax (preceding-char)) ?'))))
          (insert " ")))))

  ;;; C++
  (sp-with-modes '(malabar-mode c++-mode)
    (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))
  (sp-local-pair 'c++-mode "/*" "*/" :post-handlers '((" | " "SPC")
                                                      ("* ||\n[i]" "RET")))


  (sp-local-pair 'js2-mode "/**" "*/" :post-handlers '(("| " "SPC")
                                                       ("* ||\n[i]" "RET")))

  ;;; PHP
  (sp-with-modes '(php-mode)
    (sp-local-pair "/**" "*/" :post-handlers '(("| " "SPC")
                                               (my-php-handle-docstring "RET")))
    (sp-local-pair "/*." ".*/" :post-handlers '(("| " "SPC")))
    (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET") my-php-wrap-handler))
    (sp-local-pair "(" nil :prefix "\\(\\sw\\|\\s_\\)*"))

  (defun my-php-wrap-handler (&rest _ignored)
    (save-excursion
      (sp-get sp-last-wrapped-region
        (goto-char :beg-in)
        (unless (looking-at "[ \t]*$")
          (newline-and-indent))
        (goto-char :end-in)
        (beginning-of-line)
        (unless (looking-at "[ \t]*}[ \t]*$")
          (goto-char :end-in)
          (newline-and-indent))
        (indent-region :beg-prf :end-suf))))

  (defun my-php-handle-docstring (&rest _ignored)
    (-when-let (line (save-excursion
                       (forward-line)
                       (thing-at-point 'line)))
      (cond
       ;; variable
       ((string-match (rx (or "private" "protected" "public" "var") (1+ " ") (group "$" (1+ alnum))) line)
        (let ((var-name (match-string 1 line))
              (type ""))
          ;; try to guess the type from the constructor
          (-when-let (constructor-args (my-php-get-function-args "__construct" t))
            (setq type (or (cdr (assoc var-name constructor-args)) "")))
          (insert "* @var " type)
          (save-excursion
            (insert "\n"))))
       ((string-match-p "function" line)
        (save-excursion
          (let ((args (save-excursion
                        (forward-line)
                        (my-php-get-function-args nil t))))
            (--each args
              (when (my-php-should-insert-type-annotation (cdr it))
                (insert (format "* @param %s%s\n"
                                (my-php-translate-type-annotation (cdr it))
                                (car it))))))
          (let ((return-type (save-excursion
                               (forward-line)
                               (my-php-get-function-return-type))))
            (when (my-php-should-insert-type-annotation return-type)
              (insert (format "* @return %s\n" (my-php-translate-type-annotation return-type))))))
        (re-search-forward (rx "@" (or "param" "return") " ") nil t))
       ((string-match-p ".*class\\|interface" line)
        (save-excursion (insert "\n"))
        (insert "* ")))
      (let ((o (sp--get-active-overlay)))
        (indent-region (overlay-start o) (overlay-end o)))))
;; Parens stuff:2 ends here

;; [[file:config.org::*Parens stuff][Parens stuff:3]]
(add-hook 'clojure-mode-hook #'smartparens-mode)
;; Parens stuff:3 ends here

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
