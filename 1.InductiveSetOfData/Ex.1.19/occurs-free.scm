(define occurs-free?
  (lambda (var exp)
    (cond
     ((symbol? exp) (eqv? exp var))
     ((eqv? (car exp) 'lambda)
      (and (not (eqv? (caadr exp) var))
	   (occurs-free? var (caddr exp))))
     (else (or (occurs-free? var (car exp))
	       (occurs-free? var (cadr exp)))))))
