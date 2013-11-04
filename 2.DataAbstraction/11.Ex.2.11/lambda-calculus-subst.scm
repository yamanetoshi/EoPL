(add-load-path ".")
(load "fresh-id")
(load "occurs-free")

(define shouldBeReplaced?
  (lambda (id list)
    (cond ((null? list) #f)
	  ((eqv? id (car list)) #t)
	  (else
	   (shouldBeReplaced? id (cdr list))))))

(define lambda-calculus-subst
  (lambda (exp subst-exp subst-id)
    (letrec
	((subst
	  (lambda (exp)
	    (cases expression exp
		   (var-exp (id)
			    (if (eqv? id subst-id) subst-exp exp))
		   (lambda-exp (id body)
                               (if (shouldBeReplaced? id (all-ids subst-exp))
                                   (let ((newid (fresh-id body (symbol->string id))))
                                     (lambda-exp newid
                                                 (subst 
                                                   (lambda-calculus-subst 
                                                     body 
						     (parse-expression newid) 
						     id))))
                                   (lambda-exp id (subst body))))
		   (app-exp (rator rand)
			    (app-exp (subst rator) subst rand))
		   (lit-exp (datum)
			    (lit-exp datum))
		   (if-exp (test-exp true-exp false-exp)
			   (if-exp (subst test-exp)
				   (subst true-exp)
				   (subst false-exp)))
		   (primapp-exp (prim rand1 rand2)
				(primapp-exp prim (subst rand1) (subst rand2)))))))
      (subst exp))))
