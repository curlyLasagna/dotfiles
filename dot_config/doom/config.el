;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq! user-full-name "Luis Dale Gascon"
       user-mail-address "luis.gcodes@gmail.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'light)
      doom-variable-pitch-font (font-spec :family "SF Mono" :size 18)
      doom-symbol-font (font-spec :family "Hack Nerd Font Mono")
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 30)
      line-spacing 0.10)

(setq! undo-limit 80000000)
(setq! frame-title-format '("%b"))
(setq! scroll-preserve-screen-position 'always)
(setq! confirm-kill-emacs nil)

(setq! org-directory "~/Documents/org")
(setq! display-line-numbers-type 'relative)
(setq! truncate-string-ellipsis "…")
(global-visual-fill-column-mode -1)
(global-visual-line-mode +1)
(global-goto-address-mode +1)
(delete-selection-mode +1)
(global-subword-mode +1)
(column-number-mode +1)

;; Enable horizontal scrolling
;; (setq! mouse-wheel-tilt-scroll 't)
;; (setq! mouse-wheel-flip-direction 't)

(when (modulep! :ui modeline +light)
  (setq! +modeline-height 27)
  (setq! size-indication-mode -1))

;; MacOS options
(cond (IS-MAC
       ;; Transparent titlebar.
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       ;; Prevents some cases of Emacs flickering.
       (add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
       (setq! mac-right-option-modifier 'meta)
       (setq! ns-use-proxy-icon 'nil)
       (setq! ns-pop-up-frames 'fresh)
       (add-hook 'ns-system-appearance-change-functions #'user/apply-theme)))

(setq! doom-fallback-buffer-name "Doom")
(setq! +doom-dashboard-name "😈 Doom")
                                        ;(setq! +doom-dashboard-banner-dir doom-user-dir)
                                        ;(setq! fancy-splash-image (concat doom-user-dir "dashBanners/pusheen-drunk.png"))

(remove-hook! 'doom-first-buffer-hook
  #'global-hl-line-mode)

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

;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,

;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (setq! fancy-splash-image (concat doom-user-dir "emacs.svg"))
(after! dired
  (setf dired-kill-when-opening-new-dired-buffer t))

(after! modus-themes
  (setq! modus-themes-fringes 'nil))

(after! lsp-mode
  (setq! lsp-ui-sideline-show-diagnostics nil
         lsp-enable-symbol-highlighting nil
         ;; Dsiable lsp install suggestion
         lsp-enable-suggest-server-download nil
         lsp-eldoc-enable-hover nil
         lsp-lens-enable t))

(after! which-key
  (setq! which-key-idle-delay 0.5)
  ;; Allow which key to show everything
  ;; https://github.com/doomemacs/doomemacs/issues/6580
  (setq! which-key-allow-imprecise-window-fit nil))

(after! company
  (setq! company-ispell-available nil))

(after! web-mode
  (setq! web-mode-indent-style 4))

(after! org-download
  (setq org-download-method 'directory))

(use-package! mixed-pitch
  :defer t
  :config
  (setq mixed-pitch-set-height 't)
  (map!
   :leader
   :desc "Toggle mixed-pitch-mode"
   "t m" #'mixed-pitch-mode)
  :hook
  (text-mode . mixed-pitch-mode))

(use-package! avy
  :defer t
  :config
  (setq! avy-all-windows 't)
  (map!
   :desc "jump to 1 character"
   "C-." #'avy-goto-char
   )

  (map!
   :desc "jump to 2 characters"
   "C-\"" #'avy-goto-char-2
   )

  (map!
   :desc "jump to line"
   "M-g f" #'avy-goto-line
   )

  (map!
   :desc "jump to word at point"
   "M-g w" #'avy-goto-word-0
   ))

(after! yasnippet
  (setq! yas-triggers-in-field 't))
;; yas-snippet-dirs 'doom-user-dir))

(after! doom-modeline
  (setq! find-file-visit-truename t
         doom-modeline-gnus nil
         doom-modeline-bar-width 3
         doom-modeline-persp-name t
         ;; Prevent mode-line aligning with fill column
         mode-line-right-align-edge 'right-fringe
         doom-modeline-buffer-file-name-style 'truncate-upto-root
         all-the-icons-scale-factor 1.1)
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode))

(after! writeroom-mode
  (setq! writeroom-mode-line nil
         +zen-text-scale 0))

(use-package! org-journal
  :defer t
  :config
  (defun close-other-journal-entries ()
    "Kill org-journal buffers when navigating or creating a new entry."
    (let ((current-buffer (current-buffer)))
      (dolist (buffer (buffer-list))
        (with-current-buffer buffer
          (when (derived-mode-p 'org-journal-mode)
            (unless (eq buffer current-buffer)
              (kill-buffer buffer)))))))

  (add-hook 'org-journal-after-entry-create-hook #'close-other-journal-entries)
  (add-hook 'org-journal-after-entry-view-hook #'close-other-journal-entries)
  (map!
   :desc "Next journal entry"
   :mode org-journal-mode-map
   :leader
   "C-f" #'org-journal-next-entry
   ))

(after! vertico
  (map!
   :map vertico-map
   :desc "Preview file"
   "C-S-SPC" #'+vertico/enter-or-preview))

(after! eglot
  (setq eldoc-echo-area-use-multiline-p nil))

;;(use-package! terminal-here
;;  :config
;;  (setq! terminal-here-mac-terminal-command 'kitty)
;;  (map!
;;   :desc "Open 'terminal-here-mac-terminal-command'"
;;   :leader
;;   "o i" #'terminal-here
;;   ))

(after! marginalia
  (setq marginalia-censor-variables nil)

  (defadvice! +marginalia--anotate-local-file-colorful (cand)
    "Just a more colourful version of `marginalia--anotate-local-file'."
    :override #'marginalia--annotate-local-file
    (when-let (attrs (file-attributes (substitute-in-file-name
                                       (marginalia--full-candidate cand))
                                      'integer))
      (marginalia--fields
       ((marginalia--file-owner attrs)
        :width 12 :face 'marginalia-file-owner)
       ((marginalia--file-modes attrs))
       ((+marginalia-file-size-colorful (file-attribute-size attrs))
        :width 7)
       ((+marginalia--time-colorful (file-attribute-modification-time attrs))
        :width 12))))

  (defun +marginalia--time-colorful (time)
    (let* ((seconds (float-time (time-subtract (current-time) time)))
           (color (doom-blend
                   (face-attribute 'marginalia-date :foreground nil t)
                   (face-attribute 'marginalia-documentation :foreground nil t)
                   (/ 1.0 (log (+ 3 (/ (+ 1 seconds) 345600.0)))))))
      ;; 1 - log(3 + 1/(days + 1)) % grey
      (propertize (marginalia--time time) 'face (list :foreground color))))

  (defun +marginalia-file-size-colorful (size)
    (let* ((size-index (/ (log10 (+ 1 size)) 7.0))
           (color (if (< size-index 10000000) ; 10m
                      (doom-blend 'orange 'green size-index)
                    (doom-blend 'red 'orange (- size-index 1)))))
      (propertize (file-size-human-readable size) 'face (list :foreground color)))))

(map!
 :leader
 :desc "Dashboard"
 "d" #'+doom-dashboard/open)

(map!
 :desc "Next buffer"
 "C-<tab>" #'next-buffer)

(map!
 :desc "Previous buffer"
 "C-S-<tab>" #'previous-buffer)

(map!
 :desc "Insert quotes around region"
 "M-\"" #'insert-pair)

(defun toggle-window-split ()
  "Toggles horizontal or vertical splits. Only works for 2 windows"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(map!
 :desc "Toggle horizontal and vertical split"
 "C-x |" #'toggle-window-split)

(when (file-exists-p custom-file)
  (load custom-file))
