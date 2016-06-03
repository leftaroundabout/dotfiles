(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elpa/evil-20160210.236")
(require 'evil)
(evil-mode 1)

; (add-to-list 'load-path "~/.emacs.d/plugins/lyro-vim-mode-20044c893d53")
; (require 'vim)
; (vim-mode 1)
; 
(global-linum-mode t)
(setq column-number-mode t)

;; UTF-8 as default encoding
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)

(global-unset-key (kbd "ESC ESC ESC"))

; (load-file (let ((coding-system-for-read 'utf-8))
;                 (shell-command-to-string "agda-mode locate")))

; (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")


(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(require 'auto-complete-config)
; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(add-to-list 'ac-modes 'haskell-mode)

(setq ac-ignore-case nil)

; (require 'haskell-ghci)
; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

(global-auto-complete-mode t)

; (add-hook 'latex-mode-hook 'auto-fill-mode)

(defun comment-auto-fill ()
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1))

(add-hook 'haskell-mode-hook 'comment-auto-fill)



(setq-default indent-tabs-mode nil)
(setq tab-width 3)
(defvaralias 'chaskell-indent-level 'tab-width)

(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "C-d") 'cd)

; (global-set-key (kbd "M-C-g") 'vim:activate-normal-mode)
; (global-set-key (kbd "ESC C-M-g") 'vim:activate-normal-mode)
; (global-set-key (kbd "ESC ESC") 'vim:activate-normal-mode)

; (defun runhaskell ()
;     (interactive)
;     (buffer-offer-save)
;     (async-shell-command "runhaskell Set.hs"))
; 

(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
    (interactive)
      (set-buffer-modified-p t)
        (save-buffer))

(global-set-key (kbd "C-x w") 'save-buffer-always)

(defun save-all-and-compile ()
  (save-some-buffers 1)
  (compile compile-command))

(global-set-key (kbd "C-x a c") 'save-all-and-compile)
(global-set-key (kbd "C-c m") 'recompile)

(setq compilation-ask-about-save nil)

(setq compile-command "runhaskell Build.hs || cabal build")


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(haskell-mode-hook (quote (turn-on-haskell-indent))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


 (defun paste-xclip ()
   "Paste text from your global X clipboard"
     (interactive)
       (insert (shell-command-to-string "xclip -o -selection clipboard")))
 
 (global-set-key (kbd "C-x p") 'paste-xclip)


(defun isearch-other-window ()
  (interactive)
  ;; thank you leo2007!
  (save-selected-window
    (other-window 1)
    (isearch-forward)))

(global-set-key (kbd "C-x /") 'isearch-other-window)

(setq desktop-file-name-format 'local)

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))



(add-hook 'find-file-hook
          (lambda ()
            (setq default-directory command-line-default-directory)))

(package-initialize)
(require 'math-symbol-lists)
(quail-define-package "math" "UTF-8" "Ω" t)
(quail-define-rules ; whatever extra rules you want to define...
 ("\\from"    #X2190)
 ("\\to"      #X2192)
 ("\\iR"      #X211D)
 ("\\iN"      #X2115)
 ("\\iC"      #X2102)
 ("\\iQ"      #X211A)
 ("\\iZ"      #X2124)
 ("\\iH"      #X210D)

 ("^{0}"      #X2070)
 ("^{1}"      #X00B9)
 ("^{2}"      #X00B2)
 ("^{3}"      #X00B3)
 ("^{4}"      #X2074)
 ("^{5}"      #X2075)
 ("^{6}"      #X2076)
 ("^{7}"      #X2077)
 ("^{8}"      #X2078)
 ("^{9}"      #X2079)
 ("^{+}"      #X207A)
 ("^{-}"      #X207B)
 ("^{(}"      #X207D)
 ("^{)}"      #X207E)

 ("^{T}"      #X2C30)
 ("\\deg"     #X00B0)
 ("\\^"       #X25DD)
 ("\\_"       #X25DE)
 ("\\="       #X2A75)
 ("\\<"       #X2AA1)
 ("\\>"       #X2AA2)
 ("\\leq"     #X2264)
 ("\\geq"     #X2265)
 ("\\int"     #X222B)
 ("\\cint"    #X222E)
 ("\\sum"     #X2211)
 ("\\in"      #X2208)
 ("\\ni"      #X220A)
 ("\\notni"   #X220C)
 ("\\subset"  #X2282)
 ("\\supset"  #X2283)
 ("\\cap"     #X2229)
 ("\\cup"     #X222A)
 ("\\::"      #X2E2A)
 ("\\,"       #X060C)
 ("\\ "       #X2423)
 ("\\Tie"     #X2040)

 ("_0"        #X2080)
 ("_1"        #X2081)
 ("_2"        #X2082)
 ("_3"        #X2083)
 ("_4"        #X2084)
 ("_5"        #X2085)
 ("_6"        #X2086)
 ("_7"        #X2087)
 ("_8"        #X2088)
 ("_9"        #X2089)
 ("_+"        #X208A)
 ("_-"        #X208B)
 ("_("        #X208D)
 ("_)"        #X208E)

 ("\\a"       #X1D44E)
 ("\\b"       #X1D44F)
 ("\\c"       #X1D450)
 ("\\d"       #X1D451)
 ("\\e"       #X1D452)
 ("\\f"       #X1D453)
 ("\\g"       #X1D454)
 ("\\h"       #X1D455)
 ("\\i"       #X1D456)
 ("\\j"       #X1D457)
 ("\\k"       #X1D458)
 ("\\l"       #X1D459)
 ("\\m"       #X1D45A)
 ("\\n"       #X1D45B)
 ("\\o"       #X1D45C)
 ("\\p"       #X1D45D)
 ("\\q"       #X1D45E)
 ("\\r"       #X1D45F)
 ("\\s"       #X1D460)
 ("\\t"       #X1D461)
 ("\\u"       #X1D462)
 ("\\v"       #X1D463)
 ("\\w"       #X1D464)
 ("\\x"       #X1D465)
 ("\\y"       #X1D466)
 ("\\z"       #X1D467)

 ("\\A"       #X1D434)
 ("\\B"       #X1D435)
 ("\\C"       #X1D436)
 ("\\D"       #X1D437)
 ("\\E"       #X1D438)
 ("\\F"       #X1D439)
 ("\\G"       #X1D43A)
 ("\\H"       #X1D43B)
 ("\\I"       #X1D43C)
 ("\\J"       #X1D43D)
 ("\\K"       #X1D43E)
 ("\\L"       #X1D43F)
 ("\\M"       #X1D440)
 ("\\N"       #X1D441)
 ("\\O"       #X1D442)
 ("\\P"       #X1D443)
 ("\\Q"       #X1D444)
 ("\\R"       #X1D445)
 ("\\S"       #X1D446)
 ("\\T"       #X1D447)
 ("\\U"       #X1D448)
 ("\\V"       #X1D449)
 ("\\W"       #X1D44A)
 ("\\X"       #X1D44B)
 ("\\Y"       #X1D44C)
 ("\\Z"       #X1D44D)

 ("\\cA"       #X1D4D0)
 ("\\cB"       #X1D4D1)
 ("\\cC"       #X1D4D2)
 ("\\cD"       #X1D4D3)
 ("\\cE"       #X1D4D4)
 ("\\cF"       #X1D4D5)
 ("\\cG"       #X1D4D6)
 ("\\cH"       #X1D4D7)
 ("\\cI"       #X1D4D8)
 ("\\cJ"       #X1D4D9)
 ("\\cK"       #X1D4DA)
 ("\\cL"       #X1D4DB)
 ("\\cM"       #X1D4DC)
 ("\\cN"       #X1D4DD)
 ("\\cO"       #X1D4DE)
 ("\\cP"       #X1D4DF)
 ("\\cQ"       #X1D450)
 ("\\cR"       #X1D451)
 ("\\cS"       #X1D452)
 ("\\cT"       #X1D453)
 ("\\cU"       #X1D454)
 ("\\cV"       #X1D455)
 ("\\cW"       #X1D456)
 ("\\cX"       #X1D457)
 ("\\cY"       #X1D458)
 ("\\cZ"       #X1D459)
 ("\\Fd"       #X1D589)

 ("\\\"a"     #X000E4)
 ("\\\"i"     #X000EF)
 ("\\\"o"     #X000F6)
 ("\\\"u"     #X000FC)
 ("\\\"A"     #X000C4)
 ("\\\"I"     #X000CF)
 ("\\\"O"     #X000D6)
 ("\\\"U"     #X000DC)
 ("\\ss"      #X000DF)
 )
(mapc (lambda (x)
        (if (cddr x)
            (quail-defrule (cadr x) (car (cddr x)))))
      (append math-symbol-list-basic math-symbol-list-extended))


;(let ((quail-current-package (assoc "TeX" quail-package-alist)))
;  (quail-define-rules ((append . t))
;                      ("^\\alpha" ?ᵅ)))
;                      ("\\ir" ?ℝ)
