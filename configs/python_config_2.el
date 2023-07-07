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

(use-package python
  :ensure t
  :config
  (add-hook 'python-mode-hook
            (lambda ()
              (local-set-key (kbd "M-.") 'jedi:goto-definition))))

(use-package jedi
  :ensure t
  :init
  (setq jedi:use-shortcuts t)
  :config
  (setq ac-delay 0.1) ; Configuração para auto-complete instantâneo
  (setq eldoc-idle-delay 0.1) ; Configuração para acelerar a exibição das informações
  (add-hook 'python-mode-hook 'jedi:setup)
  (eval-after-load 'jedi-core
    '(progn
       ;; (setq jedi-completion-function 'company-jedi) ; Use Company para Jedi completions
       (define-key jedi-mode-map (kbd "M-.") 'jedi:goto-definition)
       (define-key jedi-mode-map (kbd "M-,") 'jedi:goto-definition-pop-marker)
       (define-key jedi-mode-map (kbd "M-r") 'jedi:show-doc)
       (define-key jedi-mode-map (kbd "M-*") 'jedi:pop-to-definition-pop-marker))))

;; ;; Us e IPython if available
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "-i --simple-prompt"))

(use-package ein
:ensure t)
