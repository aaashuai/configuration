;; packages


;; 括号补全
(electric-pair-mode t)

;; delete current line
(use-package crux
  :bind ("C-c k" . crux-smart-kill-line))

;; delete all space
(use-package hungry-delete
  :bind (("C-c DEL" . hungry-delete-backward)
	 ("C-c d" . hungry-delete-forward)))


;; restart emacs easily
(use-package restart-emacs)

;; move code block easily
(use-package drag-stuff
  :bind (("<M-up>" . drag-stuff-up)
	 ("<M-down>" . drag-stuff-down)))

(provide 'init-packages)
