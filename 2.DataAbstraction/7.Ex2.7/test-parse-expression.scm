(use gauche.test)
(add-load-path ".")
(load "parse-expression")

(test-start "parse-expression")
(test-section "parse-expression")
(test* "number?"
       '(lit-exp 5)
       (parse-expression 5))
(test* "free-var"
       '(free-info x)
       (parse-expression 'x))
(test* "lambda expression"
       '(lambda-exp (x) (lit-exp 1))
       (parse-expression '(lambda (x) 1)))
(test* "if expression"
       '(if-exp (app-exp (free-info null?) (free-info l)) (lit-exp 1) (lit-exp 2))
       (parse-expression '(if (null? l) 1 2)))
(test* "lex-info expression"
       '(lambda-exp (x) (lex-info x 0 0))
       (parse-expression '(lambda (x) x)))
(test* "lex-info expression (2)"
       '(lambda-exp (x) 
		    (lambda-exp (y) 
				(if-exp (app-exp 
					 (free-info null?) (lex-info x 1 0)) 
					(lex-info y 0 0) 
					(lit-exp 1))))
       (parse-expression '(lambda (x) (lambda (y) (if (null? x) y 1)))))
(test* "lex-info expression (3)"
       '(lambda-exp (x y) 
		    (lambda-exp (a b) 
				(if-exp (app-exp (free-info null?) (lex-info y 1 1)) 
					(app-exp (free-info car) (lex-info x 1 0)) 
					(app-exp (free-info cdr) (lex-info b 0 1)))))
       (parse-expression '(lambda (x y) (lambda (a b) 
					  (if (null? y) (car x) (cdr b))))))

(test-end)