(add-load-path ".")
(load "lexical-address")

(define unparse-expression
  (lambda (exp)
    (cases lexical-address exp
	   (lit-exp (datum) datum)
	   (lex-info (id depth position) id)
	   (free-info (id) id)
	   (lambda-exp (id body)
		       (list 'lambda id
			     (unparse-expression body)))
	   (if-exp (test-exp true-exp false-exp)
		   (list 'if (unparse-expression test-exp)
			 (unparse-expression true-exp)
			 (unparse-expression false-exp)))
	   (app-exp (rator rand)
		    (list (unparse-expression rator)
			  (unparse-expression rand))))))
