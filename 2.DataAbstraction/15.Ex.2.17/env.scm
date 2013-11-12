(define empty-env
  (lambda ()
    (lambda (sym search)
      (if search
	  #f
	  (eopl:error 'apply-env "No binding for ~s" sym)))))
    
(define extend-env
  (lambda (syms values env)
    (lambda (sym search)
      (let ((pos (list-find-position sym syms)))
	(if search
	    (if (number? pos)
		#t
		(env sym #t))
	    (if (number? pos)
		(list-ref values pos)
		(apply-env env sym)))))))
    
(define apply-env
  (lambda (env sym)
    (env sym #f)))

(define has-association?
  (lambda (env sym)
    (env sym #t)))

(define list-find-position
  (lambda (sym los)
    (list-index (lambda (sym1) (eqv? sym1 sym)) los)))

(define list-index
  (lambda (pred ls)
    (cond
     ((null? ls) #f)
     ((pred (car ls)) 0)
     (else
      (let ((list-index-r (list-index pred (cdr ls))))
	(if (number? list-index-r)
	    (+ list-index-r 1)
	    #f))))))
