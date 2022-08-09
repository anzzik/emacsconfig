(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)
(put 'dired-find-alternate-file 'disabled nil)

(setq inhibit-startup-message -1)
(setq visible-bell t)
(when window-system (set-frame-size (selected-frame) 100 30))

(add-hook 'c-mode-common-hook
	  (lambda () (modify-syntax-entry ?_ "w")))

;; (defun prefer-horizontal-split ()
;; (set-variable 'split-height-threshold nil t)
;; (set-variable 'split-width-threshold 40 t))
;; (add-hook 'markdown-mode-hook 'prefer-horizontal-split)

(set-face-attribute 'default nil
  :font "RobotoMono Nerd Font"
  :height 110
  :weight 'medium)

(set-face-attribute 'fixed-pitch nil
  :font "RobotoMono Nerd Font"
  :height 110
  :weight 'medium)

(set-face-attribute 'variable-pitch nil
  :font "Cantarell"
  :height 110
  :weight 'medium)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-j") 'shrink-window)
(global-set-key (kbd "C-k") 'enlarge-window)
(global-set-key (kbd "C-l") 'enlarge-window-horizontally)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>")   'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(setq-default c-basic-offset 8
	      tab-width 8
	      indent-tabs-mode t)

(setq c-default-style
      '((java-mode . "java")
	(other . "linux")))

(setq-default js-indent-level 8)

(require 'package)
;; (add-to-list 'package-archives '(("melpa" . "https://melpa.org/packages/")
;; 				 ("org" . "https://orgmode.org/elpa/")))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-toggle-key "C-'")
  ;;(setq evil-symbol-word-search t) ; not needed if syntax-entry is modified
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :after all-the-icons
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package ivy
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :after ivy
  :config
  (counsel-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function 'helpful-callable)
  (counsel-describe-variable-function 'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key]      . helpful-key))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package general
  :config
  (general-evil-setup t))

(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-center-content t)

(use-package magit
  :custom
  (magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1))

(defun ak/org-mode-font-setup ()
  (dolist (face '((org-level-1 . 1.2)
		  (org-level-2 . 1.1)
		  (org-level-3 . 1.05)
		  (org-level-4 . 1.0)
		  (org-level-5 . 1.1)
		  (org-level-6 . 1.1)
		  (org-level-7 . 1.1)
		  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil
			:weight 'regular
			:height (cdr face)))

  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil   :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun ak/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
  :hook
  (org-mode . ak/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (ak/org-mode-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun ak/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . ak/org-mode-visual-fill))

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(nvmap
  "TAB" '(evil-indent         :which-key "Show git status")
  )

(nvmap
  :prefix ","
  ","   '(ibuffer              :which-key "Open buffer list")
  "f"   '(find-file            :which-key "Find file")
  "h"   '(evil-window-left     :which-key "Window left")
  "j"   '(evil-window-down     :which-key "Window down")
  "k"   '(evil-window-up       :which-key "Window up")
  "l"   '(evil-window-right    :which-key "Window right")
  "n"   '(next-buffer          :which-key "Next buffer")
  "p"   '(previous-buffer      :which-key "Previous buffer")
  "q"   '(evil-window-delete   :which-key "Close window")
  "s"   '(split-window-below   :which-key "Split horizontally")
  "v"   '(split-window-right   :which-key "Split vertically")
  "x"   '(counsel-M-x          :which-key "M-x")

  "c c" '(comment-region       :which-key "Comment region")
  "b l" '(bookmark-bmenu-list  :which-key "List bookmarks")
  "b r" '(counsel-recentf      :which-key "Open a recent file")
  "b s" '(bookmark-set         :which-key "Set bookmark")
  "c u" '(uncomment-region     :which-key "Uncomment region")
  "g s" '(magit-status         :which-key "Show git status")
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(no-littering visual-fill-column org-ac doom-themes helpful all-the-icons-dired ivy-rich magit dashboard general which-key all-the-icons doom-modeline counsel ivy evil-collection evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
