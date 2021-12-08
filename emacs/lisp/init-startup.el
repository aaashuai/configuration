;; startup config


;; 关闭菜单栏
(menu-bar-mode -1)
;; 关闭工具栏
(tool-bar-mode -1)
;; 关闭滚动条
(scroll-bar-mode -1)
;; 关闭启动界面
(setq inhibit-startup-screen t)
;; 关闭tab
(setq indent-tabs-mode nil)
;; 关闭emacs临时文件
(setq auto-save-default nil)

(provide 'init-startup)
