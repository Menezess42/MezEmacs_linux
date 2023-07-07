;;; package --- summary
;;; Commentary:
;;; Code:
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq python-shell-interpreter "python")
  (setq elpy-rpc-python-command "python")
  (add-hook 'python-mode-hook 'pyvenv-mode))

;; Use 'pyvenv' for virtualenv management
(use-package pyvenv
  :ensure t
  :hook (python-mode . pyvenv-mode))

;; Use 'black' for code formatting
(use-package blacken
  :ensure t
  :hook (python-mode . blacken-mode))

;; Enable 'flycheck' for syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))



;; Bind 'M-.' to 'jedi:goto-definition' for jumping to function definitions
(use-package python
  :ensure t
  :config
  (add-hook 'python-mode-hook
            (lambda ()
              (local-set-key (kbd "M-.") 'jedi:goto-definition))))

;; ;; Enable 'jedi' for autocompletion and code navigation
;; (use-package jedi
;;   :ensure t
;;   :init
;;   (setq jedi:use-shortcuts t)
;;   (add-hook 'python-mode-hook 'jedi:setup))

;; ;; Us e IPython if available
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "-i --simple-prompt"))

(use-package ein
  :ensure t)
