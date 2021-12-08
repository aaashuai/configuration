;; ui

(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

;; 任务栏
;; (use-package smart-mode-line
;;   :init
;;   (setq sml/no-confirm-load-theme t
;; 	sml/theme 'respectful)
;;   (sml/setup))

;; 相对行号
(use-package emacs
  :config
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t)) 

(provide 'init-ui)
