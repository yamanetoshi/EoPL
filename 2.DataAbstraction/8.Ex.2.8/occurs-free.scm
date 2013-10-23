(add-load-path ".")
(load "lexical-address")

(define occurs-free?
  (lambda (var exp)
    (cases lexical-address exp
	   (lit-exp (datum) #t)
	   (lex-info (id depth position) #f)
	   (free-info (id) #t)
	   (if-exp (test-exp true-exp false-exp)
		   (or (occurs-free? var test-exp)
		       (occurs-free? var true-exp)
		       (occurs-free? var false-exp)))
	   (lambda-exp (id body)
		       (and (not (eqv? id var))
			    (occurs-free? var body)))
	   (app-exp (rator rand)
		    (or (occurs-free? var rator)
			(occurs-free? var rand))))))
