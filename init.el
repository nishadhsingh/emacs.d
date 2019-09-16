;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(ansi-term-color-vector
   [unspecified "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#c5c8c6"] t)
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "a7051d761a713aaf5b893c90eaba27463c791cd75d7257d3a8e66b0c8c346e77" "1dd7b369ab51f00e91b6a990634017916e7bdeb64002b4dda0d7a618785725ac" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "b27f552ea7340acc20b5caf506ee9b25e24f9427ef39a47e6b1b6f6b115f1f2b" "7bef2d39bac784626f1635bd83693fae091f04ccac6b362e0405abf16a32230c" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" "abdb1863bc138f43c29ddb84f614b14e3819982936c43b974224641b0b6b8ba4" default)))
 '(display-time-mode t)
 '(fci-rule-color "#14151E")
 '(fringe-mode (quote (0)) nil (fringe))
 '(global-display-line-numbers-mode t)
 '(inhibit-default-init t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (spacemacs-theme ergoemacs-mode ergoemacs-status underwater-theme ace-window jdee xkcd graphene-meta-theme circadian interleave iedit expand-region beacon avy md4rd solarized-theme base16-theme org-pretty-tags org-dashboard paper-theme afternoon-theme org-bullets which-key try use-package)))
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))
 (require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)


;; this is org mode setup stuff

;; time logging 
(setq org-log-done t)

;; org -todo closing note
(setq org-log-done 'note)

;; org-agenda files list 
(setq org-agenda-files (list 
			     "~/org/organisation.org"))


;;(load-theme 'nord t)


;;avy setup for quick navigation in text

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))
;-;global highlight mode highlights the current line
(global-hl-line-mode t)


;;expand-region Increase selected region by semantic units.
(use-package expand-region
  :ensure t)

(global-set-key (kbd "C-=") 'er/expand-region)

;; Beacon :highlight cursor on scrolling windows
(use-package beacon
  :ensure t)


;;iedit :-Edit multiple regions in the same way simultaneously.

(use-package iedit
  :ensure t)


;; which key :gives helpful tooltip suffixes

(use-package which-key
  :ensure t
  :config ( which-key-mode))


;; ace-window setup for quick window navigation
;;setup M-o for ace-window call 
(global-set-key (kbd "M-o") 'ace-window)
;; for home row navigation keys
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))








