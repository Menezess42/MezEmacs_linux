;; Tema customizado baseado na sua paleta de cores
(custom-set-faces
 ;; Fundo e texto principal
 '(default ((t (:background "#0a506e" :foreground "#e5dccb"))))

 ;; Comentários
 '(font-lock-comment-face ((t (:foreground "#cc8f62"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#cc8f62"))))

 ;; Strings
 '(font-lock-string-face ((t (:foreground "#84dcd4"))))

 ;; Nome de funções
 '(font-lock-function-name-face ((t (:foreground "#d19742"))))

 ;; Variáveis
 '(font-lock-variable-name-face ((t (:foreground "#66a1b8"))))

 ;; Palavras-chave
 '(font-lock-keyword-face ((t (:foreground "#e35b22"))))

 ;; Tipos
 '(font-lock-type-face ((t (:foreground "#cc8f62"))))

 ;; Constantes e built-in
 '(font-lock-constant-face ((t (:foreground "#58c5cd"))))
 '(font-lock-builtin-face ((t (:foreground "#58c5cd"))))

 ;; Flycheck
 `(flycheck-warning ((t (:underline (:style wave :color "#FFD300")))))
 `(flycheck-error ((t (:underline (:style wave :color "#FF4500")))))

 ;; Número das linhas
 `(line-number ((t (:foreground "#cc8f62"))))
 `(line-number-current-line ((t (:foreground "#e5dccb" :background "#1d1f21"))))

 ;; Linha atual destacada
 '(hl-line ((t (:background "#301934"))))
 '(hl-line ((t (:box (:line-width 3 :color "purple")))))

 ;; Cursor
 '(cursor ((t (:background "#e5dccb"))))

 ;; Mode-line ativo e inativo
 '(mode-line ((t (:background "#301934"))))
 '(mode-line-inactive ((t (:background "#301934"))))
 '(mode-line ((t (:box (:line-width 3 :color "purple")))))
 '(mode-line-inactive ((t (:box (:line-width 3 :color "purple")))))

 ;; Borda e divisórias da janela
 '(vertical-border ((t (:foreground "purple"))))
 '(window-divider ((t (:foreground "purple" :background "purple"))))
 '(window-divider-first-pixel ((t (:foreground "purple" :background "purple"))))
 '(window-divider-last-pixel ((t (:foreground "purple" :background "purple"))))
)

;; Cursor piscando em diferentes cores
(defvar blink-cursor-colors (list  "#84dcd4" "#66a1b8" "#e35b22" "#cc8f62")
  "No piscar, o cursor irá alternar entre as cores dessa lista.")

(setq blink-cursor-count 0)
(defun blink-cursor-timer-function ()
  "Altera a cor do cursor em cada piscar, de acordo com `blink-cursor-colors`."
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count)))
  (internal-show-cursor nil (not (internal-show-cursor-p))))
