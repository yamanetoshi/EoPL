(use gauche.test)
(add-load-path ".")
(load "unparse-expression")

(test-start "unparse-expression")
(test-section "unparse-expression")
(test* "number?"
       5
       (unparse-expression '(lit-exp 5)))
(test* "free-var"
       'x
       (unparse-expression '(free-info x)))
(test* "lambda expression"
       '(lambda (x) 1)
       (unparse-expression '(lambda-exp (x) (lit-exp 1))))
(test* "if expression"
       '(if (null? l) 1 2)
       (unparse-expression '(if-exp (app-exp (free-info null?) (free-info l)) (lit-exp 1) (lit-exp 2))))
(test* "lex-info expression"
       '(lambda (x) x)
       (unparse-expression '(lambda-exp (x) (lex-info x 0 0))))
(test* "lex-info expression (2)"
       '(lambda (x) (lambda (y) (if (null? x) y 1)))
       (unparse-expression '(lambda-exp (x) 
		    (lambda-exp (y) 
				(if-exp (app-exp 
					 (free-info null?) (lex-info x 1 0)) 
					(lex-info y 0 0) 
					(lit-exp 1))))))
(test* "lex-info expression (3)"
       '(lambda (x y) (lambda (a b) 
			(if (null? y) (car x) (cdr b))))
       (unparse-expression '(lambda-exp (x y) 
		    (lambda-exp (a b) 
				(if-exp (app-exp (free-info null?) (lex-info y 1 1)) 
					(app-exp (free-info car) (lex-info x 1 0)) 
					(app-exp (free-info cdr) (lex-info b 0 1)))))))

(test-end)