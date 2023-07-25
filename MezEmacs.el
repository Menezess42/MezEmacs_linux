(setq custom-file (concat user-emacs-directory "./configs/custom_2.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq custom-config "./configs/custom_2.el")
  (setq inhibit-startup-message t)
  (setq visual-line-mode t)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (set-fringe-mode 10)
  (menu-bar-mode -1)
  (setq visible-bell 1)
  (global-display-line-numbers-mode)
  (setq display-line-numbers-type 'relative)

  (electric-pair-mode t)
  (setq-default indent-tabs-mode t)

  (defalias 'yes-or-no-p 'y-or-n-p)

  (prefer-coding-system 'utf-8)

(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 140)
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font" :height 140)
(set-face-attribute 'variable-pitch nil :font "FiraCode Nerd Font" :height 140)

(load-file "~/.emacs.d/configs/tmnt_theme_color_2.el")

;; Initialize package sources
    (require 'package)

    (setq package-archives '(("melpa" . "https://melpa.org/packages/")
			    ("org" . "https://orgmode.org/elpa/")
			    ("elpa" . "https://elpa.gnu.org/packages/")))

    (package-initialize)
    (unless package-archive-contents
    (package-refresh-contents))

(use-package general
:ensure t
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (rune/leader-keys
    "t" '(:ignore t :which-key "toggles")
    ))

(use-package evil
    :demand t
    :bind (("<escape>" . keyboard-escape-quit))
    :init
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1))

(use-package evil-collection
:after evil
:config
(setq evil-want-integration t)
(evil-collection-init))

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-selection-wrap-around t)
  (setq company-idle-delay 0.60)
  (setq company-minimum-prefix-length 1)
  (setq company-require-match nil)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (setq company-tooltip-limit 10)
  (setq company-tooltip-minimum-width 50)
  (setq company-tooltip-minimum-height 10)
  (setq company-dabbrev-downcase nil))

(defun my-company-tab-or-complete ()
  (interactive)
  (if (eq last-command 'company-complete-selection)
      (company-complete-selection)
    (if (eq company-common (car company-candidates))
        (company-complete-selection)
      (company-select-next))))

(defun my-company-backtab-or-complete ()
  (interactive)
  (if (eq last-command 'company-complete-selection)
      (company-complete-selection)
    (if (eq company-common (car (last company-candidates)))
        (company-complete-selection)
      (company-select-previous))))

(define-key company-active-map (kbd "TAB") 'my-company-tab-or-complete)
(define-key company-active-map (kbd "<tab>") 'my-company-tab-or-complete)
(define-key company-active-map (kbd "S-TAB") 'my-company-backtab-or-complete)
(define-key company-active-map (kbd "<backtab>") 'my-company-backtab-or-complete)

(use-package company-quickhelp
  :ensure t
  :after company
  :config
  (company-quickhelp-mode 1))

(defun my-disable-company-mode-in-python ()
  "Desativa o Company Mode no modo Python."
  (when (eq major-mode 'python-mode)
    (company-mode -1))
  (when (not (eq major-mode 'python-mode))
    (company-mode 1)))

(add-hook 'after-change-major-mode-hook 'my-disable-company-mode-in-python)

;; (setq gc-cons-threshold most-positive-fixnum)
;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (setq gc-cons-threshold (expt 2 23)))

(load-file "~/.emacs.d/configs/dashboard_config_2.el")

(defun kill-current-buffer ()

  "kill the current buffer."
  (interactive)
  (kill-buffer (buffer-name)))
(global-set-key [remap evil-quit] 'kill-current-buffer)

(defun my-quit-emacs ()
  "Quit Emacs, or close current frame if there are multiple frames."
  (interactive)
  (if (eq window-system 'x)
      (if (cdr (frame-list))
          (delete-frame)
        (message "Can't quit Emacs with only one graphical frame"))
    (kill-emacs)))

(global-set-key [remap evil-quit] 'kill-current-buffer)
(global-set-key [remap evil-save-and-quit] 'my-quit-emacs)

(use-package which-key
:ensure t
  :commands (which-key-mode)
  :hook ((after-init . which-key-mode)
	 (pre-command . which-key-mode))
  :config
  (setq which-key-idle-delay 1)
  :diminish which-key-mode)

(use-package ivy
:ensure t
    :diminish
    :bind (:map ivy-minibuffer-map
		("TAB" . ivy-alt-done)
		("C-l" . ivy-alt-done)
		("C-j" . ivy-next-line)
		("C-k" . ivy-previous-line)
		:map ivy-switch-buffer-map
		("C-k" . ivy-previous-line)
		("C-l" . ivy-done)
		("C-d" . ivy-switch-buffer-kill)
		:map ivy-reverse-i-search-map
		("C-k" . ivy-previous-line)
		("C-d" . ivy-reverse-i-search-kill))
    :config
    (ivy-mode 1))

(require 'ivy-rich)
(ivy-rich-mode 1)
(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)

(use-package counsel
:ensure t
  :bind (("C-x C-b" . 'counsel-switch-buffer)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))

(use-package ivy-prescient
:ensure t
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (ivy-prescient-mode 1))

(require 'ivy-posframe)
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
(set-face-attribute 'ivy-posframe nil :foreground "white" :background "#301934")
(setq ivy-posframe-hide-minibuffer t)
(ivy-posframe-mode 1)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-descbinds-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defun my-eshell-config ()
  (setq eshell_config "~/.emacs.d/configs/eshell_config.el")
  (load eshell_config))

(add-hook 'eshell-mode-hook #'my-eshell-config)

(use-package no-littering
:ensure t)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "g" 'dired-single-buffer))

(use-package dired-single)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("png" . "feh")
				("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;;;;; center ;;;;;;
(use-package centered-window
  :ensure t
  :config
  (centered-window-mode t))

(use-package centered-cursor-mode
:ensure t
  :demand
  :config
  (global-centered-cursor-mode))

(use-package rainbow-mode
:ensure t
  :hook ((prog-mode . rainbow-mode)
	 (after-init . rainbow-mode))
  :config
  (setq rainbow-identfiers-choose-face-function 'rainbow-identifers-cie-l*a*b*-choose-face
	rainbow-identifiers-cie-l*a*b*-lightness 45
	rainbow-identifiers-cie-l*a*b*-saturation 70
	rainbow-identifiers-rgb-face t))

(use-package rainbow-delimiters
:ensure t
  :hook ((prog-mode . rainbow-delimiters-mode)
	 (org-mode . rainbow-delimiters-mode))
  :custom-face
  (rainbow-delimiters-depth-1-face ((t (:foreground "#92c48f"))))
  (rainbow-delimiters-depth-2-face ((t (:foreground "#f0a000"))))
  (rainbow-delimiters-depth-3-face ((t (:foreground "#ffdf00"))))
  (rainbow-delimiters-depth-4-face ((t (:foreground "#40ff00"))))
  (rainbow-delimiters-depth-5-face ((t (:foreground "#00f0a0"))))
  (rainbow-delimiters-depth-6-face ((t (:foreground "#0080ff"))))
  (rainbow-delimiters-depth-7-face ((t (:foreground "#bf00ff"))))
  (rainbow-delimiters-depth-8-face ((t (:foreground "#ff00bf"))))
  (rainbow-delimiters-depth-9-face ((t (:foreground "#ff0080")))))

(load-file "~/.emacs.d/configs/transparency_config_2.el")

;;;;; org mode ;;;;;
(defun my-org-config ()
  (setq orgConfig-file "~/.emacs.d/configs/org_config_2.el")
  (load orgConfig-file))
(add-hook 'org-mode-hook #'my-org-config)

;; Doom modeline
(use-package all-the-icons)
(use-package nerd-icons)
(use-package doom-modeline
:init (doom-modeline-mode 1)
:custom ((doom-modeline-height 15)))

(require 'golden-ratio)
(golden-ratio-mode 1)

;;;;; treemacs
(use-package treemacs
  :ensure t
  :config
  (with-eval-after-load 'treemacs
    (treemacs-project-follow-mode t))
  (setq tree-macs-show-icons t) ; Enable icons in the tree view
  (setq tree-macs-width 30) ; Set the width of the tree view

  ;; Customize keybindings (optional)
  (global-set-key (kbd "C-c t") 'tree-macs-toggle)

  ;; Define custom file filter
  (setq tree-macs-file-filters
        '(;; Exclude some file types
          (not (name . "\\.git"))
          (not (name . "\\.DS_Store"))
          (not (name . "\\.pyc")))))

(defun my-disable-company-mode-in-python ()
  "Desativa o Company Mode no modo Python."
  (when (eq major-mode 'python-mode)
    (company-mode -1))
  (when (not (eq major-mode 'python-mode))
    (company-mode 1)))

(add-hook 'after-change-major-mode-hook 'my-disable-company-mode-in-python)

(defun my-python-config ()
  (setq pythonConfig-file "~/.emacs.d/configs/python_config.el")
  (load pythonConfig-file))
(add-hook 'python-mode-hook #'my-python-config)

(defun my-disable-line-numbers ()
  "Disable line numbers."
  (display-line-numbers-mode 0))



(add-hook 'org-mode-hook 'my-disable-line-numbers)
(add-hook 'term-mode-hook 'my-disable-line-numbers)
(add-hook 'shell-mode-hook 'my-disable-line-numbers)
(add-hook 'eshell-mode-hook 'my-disable-line-numbers)
(add-hook 'dashboard-mode-hook 'my-disable-line-numbers)

(defvar my-init-start-time (current-time) "Time when init.el was started")
(defun display-start-up-echo-area-message ()
  (message "Emacs Initialized in %.2fs: " (float-time (time-subtract (current-time) my-init-start-time))))
