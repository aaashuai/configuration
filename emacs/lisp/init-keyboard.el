;; shortcuts

;; yes/no -> y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; macos set cmd to meta key
(when *is-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))


(provide 'init-keyboard)
