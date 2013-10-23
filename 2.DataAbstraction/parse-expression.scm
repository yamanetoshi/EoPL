(add-load-path ".")
(load "lexical-address")

(define parse-expression
  (lambda (datum)
    (cond
     ((number? datum) (lit-exp datum))
     ((symbol? datum) (var-exp datum))
     ((pair? datum)
      (cond
       ((eqv? (car datum) 'if)
	(if-exp (parse-expression (cadr datum))
		(parse-expression (caddr datum))
		(parse-expression (cadddr datum))))
       ((eqv? (car datum) 'lambda)
	(lambda-exp (caadr datum)
		    (parse-expression (caddr datum))))
       (else
	(app-exp
	 (parse-expression (car datum))
	 (parse-expression (cadr datum))))))
     (else
      (eopl:error 'parse-expression
		  "Invalid concrete syntas ~s" datum)))))
