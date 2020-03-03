;; [[file:~/.emacs.d/myinit.org::*repos][repos:1]]
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; repos:1 ends here

;; [[file:~/.emacs.d/myinit.org::*interface tweaks][interface tweaks:1]]
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
;; interface tweaks:1 ends here

;; [[file:~/.emacs.d/myinit.org::*try][try:1]]
(use-package try
	:ensure t)
;; try:1 ends here

;; [[file:~/.emacs.d/myinit.org::*posframe][posframe:1]]
(use-package posframe :ensure t)
;; posframe:1 ends here

;; [[file:~/.emacs.d/myinit.org::*which key][which key:1]]
(use-package which-key
  :ensure t 
  :config
  (which-key-mode))
;; which key:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Org mode][Org mode:1]]
(use-package org 
      :ensure t
      :pin org)

    (setenv "BROWSER" "firefox")
    (use-package org-bullets
      :ensure t
      :config
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
    (custom-set-variables
     '(org-directory "~/org/orgfiles")
     '(org-default-notes-file (concat org-directory "/notes.org"))
     '(org-export-html-postamble nil)
     '(org-hide-leading-stars t)
     '(org-startup-folded (quote overview))
     '(org-startup-indented t)
     '(org-confirm-babel-evaluate nil)
     '(org-src-fontify-natively t)
     )

    (setq org-file-apps
          (append '(
                    ("\\.pdf\\'" . "evince %s")
                    ("\\.x?html?\\'" . "/usr/bin/firefox %s")
                    ) org-file-apps ))

    (global-set-key "\C-ca" 'org-agenda)
    (setq org-agenda-start-on-weekday nil)
    (setq org-agenda-custom-commands
          '(("c" "Simple agenda view"
             ((agenda "")
              (alltodo "")))))

    (global-set-key (kbd "C-c c") 'org-capture)

    (setq org-agenda-files (list "~/org/organisation.org"))
    (setq org-capture-templates
          '(("a" "Appointment" entry (file  "~/org/orgfiles/gcal.org" )
             "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
            ("l" "Link" entry (file+headline "~/org/orgfiles/links.org" "Links")
             "* %? %^L %^g \n%T" :prepend t)
            ("b" "Blog idea" entry (file+headline "~/org/orgfiles/i.org" "Blog Topics:")
             "* %?\n%T" :prepend t)
            ("t" "To Do Item" entry (file+headline "~/org/orgfiles/i.org" "To Do and Notes")
             "* TODO %?\n%u" :prepend t)
            ("m" "Mail To Do" entry (file+headline "~/org/orgfiles/i.org" "To Do and Notes")
             "* TODO %a\n %?" :prepend t)
            ("g" "GMail To Do" entry (file+headline "~/org/orgfiles/i.org" "To Do and Notes")
             "* TODO %^L\n %?" :prepend t)
            ("n" "Note" entry (file+headline "~/org/orgfiles/i.org" "Notes")
             "* %u %? " :prepend t)
            ))
  

    (defadvice org-capture-finalize 
        (after delete-capture-frame activate)  
      "Advise capture-finalize to close the frame"  
      (if (equal "capture" (frame-parameter nil 'name))  
          (delete-frame)))

    (defadvice org-capture-destroy 
        (after delete-capture-frame activate)  
      "Advise capture-destroy to close the frame"  
      (if (equal "capture" (frame-parameter nil 'name))  
          (delete-frame)))  

    (use-package noflet
      :ensure t )
    (defun make-capture-frame ()
      "Create a new frame and run org-capture."
      (interactive)
      (make-frame '((name . "capture")))
      (select-frame-by-name "capture")
      (delete-other-windows)
      (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
        (org-capture)))
;; (require 'ox-beamer)
;; for inserting inactive dates
    (define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))

    (use-package htmlize :ensure t)

    (setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
;; Org mode:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Ace windows for easy window switching][Ace windows for easy window switching:1]]
(use-package ace-window
:ensure t
:init
(progn
(setq aw-scope 'global) ;; was frame
(global-set-key (kbd "C-x O") 'other-frame)
  (global-set-key [remap other-window] 'ace-window)
  (global-set-key (kbd "M-o") 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
  ))
;; Ace windows for easy window switching:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Swiper / Ivy / Counsel][Swiper / Ivy / Counsel:1]]
(use-package counsel
:ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))




  (use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))


  (use-package swiper
  :ensure t
  :bind (("C-s" . swiper-isearch)
	 ("C-r" . swiper-isearch)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))
;; Swiper / Ivy / Counsel:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Avy - navigate by searching for a letter on the screen and jumping to it][Avy - navigate by searching for a letter on the screen and jumping to it:1]]
(use-package avy
:ensure t
:bind ("M-s" . avy-goto-word-1)) ;; changed from char as per jcs
;; Avy - navigate by searching for a letter on the screen and jumping to it:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Python][Python:1]]
(setq py-python-command "python3")
        (setq python-shell-interpreter "python3")
 

            (use-package elpy
            :ensure t
            :custom (elpy-rpc-backend "jedi")
            :config 
            :init :init (add-hook 'python-mode-hook #'elpy-enable)


            ;;(elpy-enable)
            
)

        (use-package virtualenvwrapper
          :ensure t
          :config
          (venv-initialize-interactive-shells)
          (venv-initialize-eshell))
;; Python:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Yasnippet][Yasnippet:1]]
(use-package yasnippet
      :ensure t
      :init
        (yas-global-mode 1))

;    (use-package yasnippet-snippets
;      :ensure t)
;; Yasnippet:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Misc packages][Misc packages:1]]
; Highlights the current cursor line
  (global-hl-line-mode t)
  
  ; flashes the cursor's line when you scroll
  (use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  ; (setq beacon-color "#666600")
  )
  
  ; deletes all the whitespace when you hit backspace or delete
  (use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))
  

  (use-package multiple-cursors
  :ensure t)

  ; expand the marked region in semantic increments (negative prefix to reduce region)
  (use-package expand-region
  :ensure t
  :config 
  (global-set-key (kbd "C-=") 'er/expand-region))

(setq save-interprogram-paste-before-kill t)


(global-auto-revert-mode 1) ;; you might not want this
(setq auto-revert-verbose nil) ;; or this
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f6>") 'revert-buffer)
;; Misc packages:1 ends here

;; [[file:~/.emacs.d/myinit.org::*iedit and narrow / widen dwim][iedit and narrow / widen dwim:1]]
; mark and edit all copies of the marked region simultaniously. 
(use-package iedit
:ensure t)

; if you're windened, narrow to the region, if you're narrowed, widen
; bound to C-x n
(defun narrow-or-widen-dwim (p)
"If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
(interactive "P")
(declare (interactive-only))
(cond ((and (buffer-narrowed-p) (not p)) (widen))
((region-active-p)
(narrow-to-region (region-beginning) (region-end)))
((derived-mode-p 'org-mode)
;; `org-edit-src-code' is not a real narrowing command.
;; Remove this first conditional if you don't want it.
(cond ((ignore-errors (org-edit-src-code))
(delete-other-windows))
((org-at-block-p)
(org-narrow-to-block))
(t (org-narrow-to-subtree))))
(t (narrow-to-defun))))

;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing keymap, that's
;; how much I like this command. Only copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)
;; iedit and narrow / widen dwim:1 ends here

;; [[file:~/.emacs.d/myinit.org::*DIRED][DIRED:1]]
; wiki melpa problem
;(use-package dired+
;  :ensure t
;  :config (require 'dired+)
;  )

(setq dired-dwim-target t)

(use-package dired-narrow
:ensure t
:config
(bind-key "C-c C-n" #'dired-narrow)
(bind-key "C-c C-f" #'dired-narrow-fuzzy)
(bind-key "C-x C-N" #'dired-narrow-regexp)
)

(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))
;; DIRED:1 ends here

;; [[file:~/.emacs.d/myinit.org::*DIRED][DIRED:2]]
;; babel stuff

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (emacs-lisp . t)
(shell . t)
       (C . t)
    (js . t)
       (ditaa . t)
       (dot . t)
       (org . t)
    (latex . t )
       ))
  ;; projectile
    (use-package projectile
      :ensure t
      :bind ("C-c p" . projectile-command-map)
      :config
      (projectile-global-mode)
    (setq projectile-completion-system 'ivy))

    ;; (use-package counsel-projectile
    ;;   :ensure t
    ;;   :config
    ;;   (counsel-projectile-on)q)

(use-package smartparens
:ensure t
  :hook (prog-mode . smartparens-mode)
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config))

(show-paren-mode t)
;; DIRED:2 ends here

;; [[file:~/.emacs.d/myinit.org::*Hydra][Hydra:1]]
(use-package hydra 
    :ensure hydra
    :init 
    (global-set-key
    (kbd "C-x t")
	    (defhydra toggle (:color blue)
	      "toggle"
	      ("a" abbrev-mode "abbrev")
	      ("s" flyspell-mode "flyspell")
	      ("d" toggle-debug-on-error "debug")
	      ("c" fci-mode "fCi")
	      ("f" auto-fill-mode "fill")
	      ("t" toggle-truncate-lines "truncate")
	      ("w" whitespace-mode "whitespace")
	      ("q" nil "cancel")))
    (global-set-key
     (kbd "C-x j")
     (defhydra gotoline 
       ( :pre (linum-mode 1)
	      :post (linum-mode -1))
       "goto"
       ("t" (lambda () (interactive)(move-to-window-line-top-bottom 0)) "top")
       ("b" (lambda () (interactive)(move-to-window-line-top-bottom -1)) "bottom")
       ("m" (lambda () (interactive)(move-to-window-line-top-bottom)) "middle")
       ("e" (lambda () (interactive)(end-of-buffer)) "end")
       ("c" recenter-top-bottom "recenter")
       ("n" next-line "down")
       ("p" (lambda () (interactive) (forward-line -1))  "up")
       ("g" goto-line "goto-line")
       ))
    (global-set-key
     (kbd "C-c t")
     (defhydra hydra-global-org (:color blue)
       "Org"
       ("t" org-timer-start "Start Timer")
       ("s" org-timer-stop "Stop Timer")
       ("r" org-timer-set-timer "Set Timer") ; This one requires you be in an orgmode doc, as it sets the timer for the header
       ("p" org-timer "Print Timer") ; output timer value to buffer
       ("w" (org-clock-in '(4)) "Clock-In") ; used with (org-clock-persistence-insinuate) (setq org-clock-persist t)
       ("o" org-clock-out "Clock-Out") ; you might also want (setq org-log-note-clock-out t)
       ("j" org-clock-goto "Clock Goto") ; global visit the clocked task
       ("c" org-capture "Capture") ; Don't forget to define the captures you want http://orgmode.org/manual/Capture.html
	     ("l" (or )rg-capture-goto-last-stored "Last Capture"))

     ))

(defhydra hydra-multiple-cursors (:hint nil)
  "
 Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search
 [Click] Cursor at point       [_q_] Quit"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("s" mc/mark-all-in-region-regexp :exit t)
  ("0" mc/insert-numbers :exit t)
  ("A" mc/insert-letters :exit t)
  ("<mouse-1>" mc/add-cursor-on-click)
  ;; Help with click recognition in this hydra
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore)
  ("q" nil)


  ("<mouse-1>" mc/add-cursor-on-click)
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore))
;; Hydra:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Dumb jump][Dumb jump:1]]
(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config 
  ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
:init
(dumb-jump-mode)
  :ensure
)
;; Dumb jump:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Origami folding][Origami folding:1]]
(use-package origami
:ensure t)
;; Origami folding:1 ends here

;; [[file:~/.emacs.d/myinit.org::*IBUFFER][IBUFFER:1]]
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("org" (name . "^.*org$"))
               ("magit" (mode . magit-mode))
               ("IRC" (or (mode . circe-channel-mode) (mode . circe-server-mode)))
               ("web" (or (mode . web-mode) (mode . js2-mode)))
               ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
               ("mu4e" (or

                        (mode . mu4e-compose-mode)
                        (name . "\*mu4e\*")
                        ))
               ("programming" (or
                               (mode . clojure-mode)
                               (mode . clojurescript-mode)
                               (mode . python-mode)
                               (mode . c++-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; don't show these
                                        ;(add-to-list 'ibuffer-never-show-predicates "zowie")
;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)
;; IBUFFER:1 ends here

;; [[file:~/.emacs.d/myinit.org::*personal keymap][personal keymap:1]]
;; set up my own map
(define-prefix-command 'z-map)
(global-set-key (kbd "C-z") 'z-map) ;; was C-1
(define-key z-map (kbd "k") 'compile)
(define-key z-map (kbd "c") 'hydra-multiple-cursors/body)
(define-key z-map (kbd "m") 'mu4e)
(define-key z-map (kbd "1") 'org-global-cycle)
(define-key z-map (kbd "a") 'org-agenda-show-agenda-and-todo)
(define-key z-map (kbd "g") 'counsel-ag)
(define-key z-map (kbd "2") 'make-frame-command)
(define-key z-map (kbd "0") 'delete-frame)
(define-key z-map (kbd "o") 'ace-window)

(define-key z-map (kbd "s") 'flyspell-correct-word-before-point)
(define-key z-map (kbd "i") 'z/load-iorg)
(define-key z-map (kbd "f") 'origami-toggle-node)
(define-key z-map (kbd "w") 'z/swap-windows)
(define-key z-map (kbd "*") 'calc)


  (setq user-full-name "Nishadh Singh"
                          user-mail-address "nishadhsingh@gmail.com")
  ;;--------------------------------------------------------------------------


  (global-set-key (kbd "\e\ei")
                  (lambda () (interactive) (find-file "~/org/orgfiles/i.org")))

  (global-set-key (kbd "\e\el")
                  (lambda () (interactive) (find-file "~/org/orgfiles/links.org")))

  (global-set-key (kbd "\e\ec")
                  (lambda () (interactive) (find-file "~/.emacs.d/myinit.org")))

(global-set-key (kbd "<end>") 'move-end-of-line)

(global-set-key [mouse-3] 'flyspell-correct-word-before-point)
;; personal keymap:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Wgrep][Wgrep:1]]
(use-package wgrep
:ensure t
)
(use-package wgrep-ag
:ensure t
)
(require 'wgrep-ag)
;; Wgrep:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Silversearcher][Silversearcher:1]]
(use-package ag
:ensure t)
;; Silversearcher:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Regex][Regex:1]]
(use-package pcre2el
:ensure t
:config 
(pcre-mode)
)
;; Regex:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Eyebrowse][Eyebrowse:2]]
(use-package pdf-tools
:ensure t)
(use-package org-pdfview
:ensure t)

(require 'pdf-tools)
(require 'org-pdfview)
;; Eyebrowse:2 ends here

;; [[file:~/.emacs.d/myinit.org::*auto-yasnippet][auto-yasnippet:1]]
(use-package auto-yasnippet
:ensure t)
;; auto-yasnippet:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Word stuff][Word stuff:1]]
(use-package dictionary
  :ensure t)

(use-package synosaurus
  :ensure t)
;; Word stuff:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Ripgrep][Ripgrep:1]]
(use-package deadgrep 
:ensure t)

(use-package rg
:ensure t
:commands rg)
;; Ripgrep:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Fzf][Fzf:1]]
(use-package fzf :ensure t)
;; Fzf:1 ends here

;; [[file:~/.emacs.d/myinit.org::*dashbord , spaceline,themes][dashbord , spaceline,themes:1]]
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
;;(setq dashboard-startup-banner 3)
(setq dashboard-startup-banner "~/khan-academy-aqualine-seed-logo.png")
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts t)

(setq dashboard-set-navigator t)
(setq dashboard-set-init-info t)
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))


(use-package solarized-theme;
  :ensure t)
(use-package nord-theme
  :ensure t)
;;(load-theme 'solarized-light t)
(load-theme 'nord t)
(require 'restart-emacs)

(require 'spaceline-config)
(spaceline-spacemacs-theme)
(spaceline-compile
  ; left side
  '(((persp-name
      workspace-number
      window-number)
     :fallback evil-state
     :face highlight-face
     :priority 100)
    (anzu :priority 95)
    auto-compile
    ((buffer-modified buffer-size buffer-id remote-host)
     :priority 98)
    (major-mode :priority 79)
    (process :when active)
    ((flycheck-error flycheck-warning flycheck-info)
     :when active
     :priority 89)
    (minor-modes :when active
                 :priority 9)
    
    (erc-track :when active)
    (version-control :when active
                     :priority 78)
    (org-pomodoro :when active)
    (org-clock :when active)
    nyan-cat)
  ; right side
  '(which-function
    (python-pyvenv :fallback python-pyenv)
    (purpose :priority 94)
    (battery :when active)
    (selection-info :priority 95)
    input-method
    ((buffer-encoding-abbrev
      point-position
      line-column)
     :separator " | "
     :priority 96)
    (global :when active)
    (buffer-position :priority 99)
    (hud :priority 99)))


(add-to-list'load-path"~/.emacs.d/lisp/dired+.el")
(add-to-list'load-path"~/.emacs.d/lisp/ fakecygpty.el")
;; dashbord , spaceline,themes:1 ends here
