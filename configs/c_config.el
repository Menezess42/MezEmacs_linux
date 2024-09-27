;; c-cpp-config.el
(defun setup-c-cpp-mode ()
  (interactive)
  ;; Usar LSP Mode para C/C++
  (require 'lsp-mode)
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'c++-mode-hook 'lsp)

  ;; Configurações de formatação
  (setq c-default-style "linux"
        c-basic-offset 4)

  ;; Ativar company-mode para auto-completar
  (require 'company)
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'c++-mode-hook 'company-mode)

  ;; Configuração de flycheck para verificação de código
  (require 'flycheck)
  (add-hook 'c-mode-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook 'flycheck-mode)

  ;; LSP UI para dicas de código e navegação
  (require 'lsp-ui)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)

  ;; Clangd como backend para o LSP
  (setq lsp-clients-clangd-executable "clangd"))
;; Configurações de C/C++
(defun my-c-compile-run ()
  (interactive)
  (save-buffer)
  (compile "gcc main.c -o main && ./main"))

;; Define o atalho Ctrl+c+c para compilar e rodar o código C
(define-key c-mode-map (kbd "C-c C-c") 'my-c-compile-run)
(define-key c++-mode-map (kbd "C-c C-c") 'my-c-compile-run)


(provide 'c-cpp-config)
