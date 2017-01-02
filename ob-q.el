;;; ob-template.el --- org-babel functions for template evaluation
;; Copyright (C) Hao Deng 
;; Keywords: kdb+, q, literate programming, reproducible research

(defun ob-q-filter (proc string)
  (message string)
  (setq ob-q-output (concat ob-q-output string)))

(defun ob-q-init ()
  (let ((process-connection-type nil))
    (start-process "q" nil "q" ))
  (set-process-filter (get-process "q") 'ob-q-filter)
  )

;; This is the main function which is called to evaluate a code
(defun org-babel-execute:q (body params)
  (if (not (get-process "q")) (ob-q-init))
  (setq ob-q-output "")
  (process-send-string "q" (concat body "\n"))
  (accept-process-output (get-process "q") 0.3)
  ob-q-output)

(defun qq (string)
  (message (concat "qq[" string "]"))
  (replace-regexp-in-string "\n" " " 
			    (org-babel-execute:q string nil)))


(defun imm-step (row-number q-func-as-string)
  (concat "x" (number-to-string row-number)
	      ": 0N! "
	      q-func-as-string
	      " x" (number-to-string (- row-number 1))))

(defun step (row-number q-func-as-string)
  (if (= 1 row-number)
      (concat "x: " q-func-as-string )
    (concat "x: 0N! " q-func-as-string " x")
    ))

(defun step (row-number q-func-as-string)
    (concat "x: 0N! " q-func-as-string " x"))
