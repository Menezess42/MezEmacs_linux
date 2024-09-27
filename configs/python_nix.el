;;; package --- Summary
;;; Commentary:
;;; Code:

;; Ativar Elpy para desenvolvimento Python
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  ;; O direnv já cuida de ativar o ambiente correto, então podemos manter as configurações padrão
  (setq python-shell-interpreter "python")
  (setq elpy-rpc-virtualenv-path 'current)
  (setq elpy-rpc-python-command "python"))

;; Gerenciar ambientes virtuais e direnv
(use-package direnv
  :ensure t
  :config
  (direnv-mode))  ;; Habilita o direnv no Emacs para detectar o ambiente automaticamente

(use-package pyvenv
  :ensure t
  :config
  ;; Não precisamos mais gerenciar manualmente o ambiente virtual, pois direnv faz isso por nós.
  (pyvenv-mode 1))

;; Black para formatação automática
(use-package blacken
  :ensure t
  :hook (python-mode . blacken-mode))

;; Flycheck para verificação de sintaxe
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Configurar o Jedi para auto-completar e navegação no código
(use-package jedi
  :ensure t
  :config
  (setq jedi:complete-on-dot t)
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook
            (lambda ()
              (local-set-key (kbd "M-.") 'jedi:goto-definition))))

;; Usar IPython, se disponível
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "-i --simple-prompt"))

;; EIN para integração com Jupyter notebooks, se necessário
(use-package ein
  :ensure t)
