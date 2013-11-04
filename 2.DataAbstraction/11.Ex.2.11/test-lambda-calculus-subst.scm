(use gauche.test)
(add-load-path ".")
(load "parse-expression")
(load "lambda-calculus-subst")

(test-start "lambda-calculus-subst")
(test-section "lambda-calculus-subst")
(test* "occurs-bound"
       '(lambda-exp p0 
		    (primapp-exp + 
				(var-exp p0) 
				(primapp-exp * (var-exp p) (lit-exp 3))))
       (lambda-calculus-subst (parse-expression '(lambda (p) (+ p x)))
			      (parse-expression '(* p 3))
			      'x))

(test* "occurs-free"
       '(lambda-exp q (primapp-exp + 
				     (var-exp q) 
				     (primapp-exp * (var-exp p) (lit-exp 3))))
       (lambda-calculus-subst (parse-expression '(lambda (q) (+ q x)))
			      (parse-expression '(* p 3))
			      'x))

(test-end)
