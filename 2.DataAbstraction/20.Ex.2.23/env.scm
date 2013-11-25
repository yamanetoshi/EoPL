(define empty-env
  (lambda ()
    '()))

(define list-find-position
  (lambda (sym env)
    (cond ((null? env) #f)
	  ((eqv? sym (car (car env))) (cdr (car env)))
	  (else
	   (list-find-position sym (cdr env))))))

(define extend-env
  (lambda (sym val env)
    (cons (cons sym val) env)))

(define apply-env
  (lambda (env sym)
    (cond ((null? env)
	   (error "No binding for " sym))
	  (else
	   (let ((val (list-find-position sym env)))
	     (if (not val)
		 (apply-env (cdr env) sym)
		 val))))))

	
