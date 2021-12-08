;; constants

(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gun/linux))
(defconst *is-win* (or
		    (eq system-type 'ms-dos)
		    (eq system-type 'windows-nt)))

(provide 'init-const)
