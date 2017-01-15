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
  (replace-regexp-in-string
   "\n" " " 
   (org-babel-execute:q string nil)))

(defun qk (string)
  (replace-regexp-in-string
   "\n" " " 
   (org-babel-execute:q
    (concat "fooFoO: 0N! " string) nil)))

(defun step (row-number left above)
  (concat "x: 0N! " left " "
	  (if (= 2 row-number) above "x")))

(defun qf (name &rest a)
  (concat name " 0N! {"
	  (mapconcat 'identity (nreverse a) " ")
	  " x}")) 

;; each function every 2 step
(defun step2 (row-number this-cell above x)
  (if (= 0 (mod row-number 2))
      this-cell
    (concat "=>" (qq (concat "x: 0N! " above 
			(if (= 3 row-number) x " x"))))))

(defun take-every-other (lst)
  (if (= nil lst)
      nil
    (cons (car lst) (take-every-other (cddr lst)))))

;; collect function every two row.
(defun qf2 (name &rest a)
  (concat name " 0N! {"
	  (mapconcat 'identity (nreverse a) " ")
	  " x}")) 
(provide 'ob-q)
