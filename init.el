(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode)

(setq inhibit-startup-message -1)
(setq visible-bell t)
(when window-system (set-frame-size (selected-frame) 100 30))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-j") 'enlarge-window)
(global-set-key (kbd "C-k") 'shrink-window)

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
  :config
  (evil-mode 1)
  ;; (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
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

(nvmap :prefix ","
  "f"  '(find-file           :which-key "Find file")
  ","  '(counsel-recentf     :which-key "Recent files")
  "x"  '(counsel-M-x         :which-key "M-x")
  "j"  '(evil-window-down    :which-key "Window down")
  "k"  '(evil-window-up      :which-key "Window up")
  "h"  '(evil-window-left    :which-key "Window left")
  "l"  '(evil-window-right   :which-key "Window right")
  "q"  '(evil-window-delete  :which-key "Close window")
  "s"  '(split-window-below  :which-key "Split horizontally")
  "v"  '(split-window-right  :which-key "Split vertically")
  "b"  '(bookmark-bmenu-list :which-key "Bookmark list")
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(general which-key all-the-icons doom-modeline counsel ivy evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
