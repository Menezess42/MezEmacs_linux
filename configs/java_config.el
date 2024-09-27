;; java-config.el
(defun setup-java-mode ()
  (interactive)
  ;; Usar LSP Mode para Java
  (require 'lsp-mode)
  (add-hook 'java-mode-hook 'lsp)

  ;; Configurações de formatação
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil)

  ;; Ativar company-mode para auto-completar
  (require 'company)
  (add-hook 'java-mode-hook 'company-mode)

  ;; Configuração de flycheck para verificação de código
  (require 'flycheck)
  (add-hook 'java-mode-hook 'flycheck-mode)

  ;; LSP UI para dicas de código e navegação
  (require 'lsp-ui)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)

  ;; Java LSP Server (jdtls) para LSP Mode
  (setq lsp-java-server-install-dir "/path/to/jdtls/")
  (setq lsp-java-java-path "/path/to/java"))
;; Configurações de Java
(defun my-java-compile-run ()
  (interactive)
  (save-buffer)
  (compile "javac Main.java && java Main"))

;; Define o atalho Ctrl+c+c para compilar e rodar o código Java
(define-key java-mode-map (kbd "C-c C-c") 'my-java-compile-run)


(provide 'java-config)
