;;; ob-template.el --- org-babel functions for template evaluation
;; Copyright (C) Hao Deng 
;; Keywords: kdb+, q, literate programming, reproducible research

(defun ob-q-filter (proc string)
  (setq ob-q-output (concat ob-q-output string)))

(defun ob-q-init ()
  (let ((process-connection-type nil))
    (start-process "q" nil "q" ""))
  (set-process-filter (get-process "q") 'ob-q-filter)
  )

(defconst sep "`SeParator_for_ob_q\n")
(require 'subr-x)

(setq ob-q-i 0)

;; This is the main function which is called to evaluate a code
(defun org-babel-execute:q (body params)
  (if (not (get-process "q")) (ob-q-init))
  (setq ob-q-output "")
  (message "sending: [%s]" body)
  (process-send-string "q" (concat body "\n" sep))
  (accept-process-output (get-process "q") 5 0 1)
  (message "get out:[%s]" ob-q-output)
  (while (not (or (string-suffix-p sep ob-q-output)
                  (string-suffix-p "wsfull\n" ob-q-output)
                  (string-suffix-p "q\n" ob-q-output)
                  ))
    (accept-process-output (get-process "q") 1000 0 1)
    (message "%s get output :[%s]" ob-q-i ob-q-output)
    (setq ob-q-i (+ 1 ob-q-i)))
  (let ((out (string-remove-suffix sep ob-q-output))
        (res (split-string (alist-get :results params))))
    (if (member "value" res) 
        (mapcar (lambda (s) (split-string s "|"))
                (split-string out))
      out 
  )))

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
    (concat "=>" (qq (concat "x: 0N! " above " " 
			     (if (= 3 row-number) x " x"))))))

; (step2 3 "til" "320" "320")

(defun take-every-other (lst)
  (if (null lst)
      nil
    (cons (car lst) (take-every-other (cddr lst)))))


;; collect function every two row.
(defun qf2 (name &rest a)
  (concat name " 0N! {"
	  (mapconcat 'identity (nreverse (take-every-other a)) " ")
	  " x}")) 

(defun step3 (row-number left leftup up x)
  " deprecated"
  (if (= 0 (mod row-number 2))
      ""
    (qq(concat "showprd x: " leftup " " 
                (if (= 3 row-number) x " x")))))


(defun qq2 (string)
  (cons "2" (cons "1" nil))
  )

(provide 'ob-q)
