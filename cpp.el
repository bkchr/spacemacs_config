;;; c++ mode settings
;;; http://stackoverflow.com/a/663636/1531656
;;; http://stackoverflow.com/a/22711444/1531656
(defun my-c++-mode-hook ()
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (c-set-offset 'innamespace [2])
  (c-set-offset 'substatement-open 0))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(defun my-c-mode-hook ()
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (c-set-offset 'substatement-open 0)
  )
(add-hook 'c-mode-hook 'my-c-mode-hook)

(add-to-list 'auto-mode-alist '("\\.cl\\'" . c-mode))

(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)

(require 'semantic/bovine/gcc)
(setq cmake-ide-flags-c++ (append '("-std=c++11")
                           (mapcar (lambda (path) (concat "-I" path)) (semantic-gcc-get-include-paths "c++"))))
(setq cmake-ide-flags-c (append (mapcar (lambda (path) (concat "-I" path)) (semantic-gcc-get-include-paths "c"))))

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'c++-mode-hook 'whitespace-mode)
(add-hook 'c-mode-hook 'whitespace-mode)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'semantic)

(dolist (mode '(c-mode-hook c++-mode-hook))
  (add-hook mode 'semantic-mode))

(dolist (mode '(c-mode-hook c++-mode-hook))
  (add-hook mode 'spacemacs/lazy-load-srefactor))

(require 'stickyfunc-enhance)
(dolist (mode '(c-mode-hook c++-mode-hook))
  (add-hook mode 'spacemacs/lazy-load-stickyfunc-enhance))
