(add-load-path "../../define-datatype")
(load "define-datatype")

(define unparse-expression
  (lambda (exp)
    (cases expression exp
	   (lit-exp (datum) datum)
	   (var-exp (id) id)
	   (if-exp (test-exp true-exp false-exp)
		   (list 'if 
			 (unparse-expression test-exp)
			 (unparse-expression true-exp)
			 (unparse-expression false-exp)))
	   (lambda-exp (id body)
		       (list 'lambda (list id)
			     (unparse-expression body)))
	   (app-exp (rator rand)
		    (list (unparse-expression rator)
			  (unparse-expression rand))))))
