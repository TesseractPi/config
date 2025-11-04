;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq doom-modeline-modal-icon nil)

(setq evil-replace-state-tag "")
(setq evil-emacs-state-tag "")
(setq evil-motion-state-tag "󰆾")
(setq evil-operator-state-tag "")
(setq evil-visual-state-tag "")
(setq evil-insert-state-tag "")
(setq evil-normal-state-tag "󰫻")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Sam Rohrbach"
      user-mail-address "sam.g.rohrbach@proton.me")

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-ir-black)
(setq fancy-splash-image (concat doom-user-dir "doom-emacs-white.svg"))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; aliases for speed
(after! evil
  (evil-ex-define-cmd "n" "new")
  (evil-ex-define-cmd "N" "new")
  (evil-ex-define-cmd "Q" "q")
  (evil-ex-define-cmd "W" "w")
  (evil-ex-define-cmd "E" "e")
  (evil-ex-define-cmd "X" "x"))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;
;; See 'C-h v doom-font' for documentation and more examples of what they accept.

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'semi-light)
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'semi-light))

(defun me/chfont ()
        (set-fontset-font "fontset-default" 'cyrillic "JetBrainsMono Nerd Font" nil 'prepend) ;; nil 'prepend means that all other chars are jb mono
        (set-fontset-font "fontset-default" 'greek "JetBrainsMono Nerd Font" nil 'prepend)
        ;;(set-fontset-font "fontset-default" 'hangul "JetBrainsMonoHangul")
        (set-fontset-font "fontset-default" 'hangul "Noto Sans CJK SC")
        (set-fontset-font "fontset-default" 'kana "Noto Sans CJK SC")
        (set-fontset-font "fontset-default" 'han "Noto Sans CJK SC")
        (set-fontset-font "fontset-default" 'bopomofo "Noto Sans CJK SC")
        ;;(set-fontset-font "fontset-default" 'arabic "Cascadia Code")
        (set-fontset-font "fontset-default" 'arabic (font-spec :family "Cascadia Code" :size 20 :weight 'light))
        (set-fontset-font "fontset-default" 'hebrew "Cousine"))

(add-hook 'after-setting-font-hook #'me/chfont)

(defun me/display-space-as-icon (orig-fun key-seq &optional prefix)
  "use cool nerd font ligatures in minibar"
  (let ((desc (funcall orig-fun key-seq prefix)))
    (setq desc (replace-regexp-in-string "\\<SPC\\>" "󱁐" desc))
    (setq desc (replace-regexp-in-string "\\<RET\\>" "󰌑" desc))
    (setq desc (replace-regexp-in-string "\\<TAB\\>" "󰌒" desc))
    (setq desc (replace-regexp-in-string "\\<DEL\\>" "󰭜" desc))
    (setq desc (replace-regexp-in-string "<deletechar>" "󰹿" desc))
    desc))

(advice-add 'key-description :around #'me/display-space-as-icon)


(after! which-key
  (defun me/which-key--show-keymap-advice (orig-fun &rest args)
    "use cool nerd font ligatures in which-key."
    (let ((inhibit-message t))
      (cl-letf* (((symbol-function 'which-key--format-and-replace)
                  (lambda (key &rest rest)
                    (let ((res (apply rest key)))
                      (setq res (replace-regexp-in-string "\\<SPC\\>" "󱁐" res))
                      (setq res (replace-regexp-in-string "\\<RET\\>" "󰌑" res))
                      (setq res (replace-regexp-in-string "\\<TAB\\>" "󰌒" res))
                      (setq res (replace-regexp-in-string "\\<DEL\\>" "󰭜" res))
                      (setq res (replace-regexp-in-string "<deletechar>" "󰹿" res))
                      res)))))
        (apply orig-fun args))))
  (advice-add 'which-key--show-keymap :around #'me/which-key--show-keymap-advice)


;;QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm
;;ΕΡΤΥΘΙΟΠΑΣΔΦΓΗΞΚΛΖΧΨΩΒΝΜςερτυθιίϊΐοπασδφγηξκλζχψωβνμ
;;ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮёйцукенгшщзхъфывапролджэячсмитьбю
;;ذضصثقفغعهخحجدشسيبلاتنمكطئءؤرلاىةوزظ دجحخهعغفقثصضذطكمنتالبيسشظزوةىلار
;;קראטוןםפשדגכעיחלךףזסבהנמצתץ
;;this is a hebrew alignment test
;;这是中文中六七和ㄅㄆㄇㄈㄪ的例句
;;this is a chinese alignment test
;;これはひらがなとカタカナを使った例文です
;;this is a kana alignment test
;;헐 이것은 히라가나와 가타카나를 사용한 예문입니다
;;this is a hangul alignment test
;;this is a hieroglyphic alignment test
;;󱁐 󰌍 󰭜 󰹿 󰌎 󰌑 󰌒 󰌥 󰘲 󰘳 󰘴 󰘵 󰘶 ⌥ ⌘ ⎋
