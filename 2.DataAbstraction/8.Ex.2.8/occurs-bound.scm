(add-load-path ".")
(load "lexical-address")

(define occurs-bound?
  (lambda (var exp)
    (cases lexical-address exp
	   (lit-exp (datum) #f)
	   (lex-info (id depth position) #t)
	   (free-info (id) #f)
	   (if-exp (test-exp true-exp false-exp)
		   (or (occurs-bound? var test-exp)
		       (occurs-bound? var true-exp)
		       (occurs-bound? var false-exp)))
	   (lambda-exp (id body)
		       (or (occurs-bound? var body)
			   (and (eqv? var id)
				(occurs-free? var body))))
	   (app-exp (rator rand)
		    (or (occurs-bound? var rator)
			(occurs-bound? var rand))))))