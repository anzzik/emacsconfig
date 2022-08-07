(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)

(setq inhibit-startup-message -1)
(setq visible-bell t)
(when window-system (set-frame-size (selected-frame) 100 30))

;; (set-face-attribute 'default nil
;;   :font "DejaVu Sans Mono"
;;   :height 110
;;   :weight 'medium)

(set-face-attribute 'default nil
  :font "RobotoMono Nerd Font"
  :height 110
  :weight 'medium)

(set-face-attribute 'fixed-pitch nil
  :font "RobotoMono Nerd Font"
  :height 110
  :weight 'medium)

(set-face-attribute 'variable-pitch nil
  :font "Roboto Condensed"
  :height 110
  :weight 'medium)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-j") 'shrink-window)
(global-set-key (kbd "C-k") 'enlarge-window)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>")   'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(setq-default c-basic-offset 8
	      tab-width 8
	      indent-tabs-mode t)

(setq-default js-indent-level 8)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
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
  :config
  (evil-mode 1)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package ivy
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :config
  (counsel-mode 1))

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

(use-package magit)

(nvmap :prefix ","
  ","  '(counsel-recentf     :which-key "Recent files")
  "b"  '(bookmark-bmenu-list :which-key "Bookmark list")
  "f"  '(find-file           :which-key "Find file")
  "h"  '(evil-window-left    :which-key "Window left")
  "j"  '(evil-window-down    :which-key "Window down")
  "k"  '(evil-window-up      :which-key "Window up")
  "l"  '(evil-window-right   :which-key "Window right")
  "n"  '(next-buffer         :which-key "Next buffer")
  "p"  '(previous-buffer     :which-key "Previous buffer")
  "q"  '(evil-window-delete  :which-key "Close window")
  "s"  '(split-window-below  :which-key "Split horizontally")
  "v"  '(split-window-right  :which-key "Split vertically")
  "x"  '(counsel-M-x         :which-key "M-x")

  "g s" '(magit-status       :which-key "Show git status")
  "c c" '(comment-region     :which-key "Comment region")
  "c u" '(uncomment-region   :which-key "Uncomment region")
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit dashboard general which-key all-the-icons doom-modeline counsel ivy evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
