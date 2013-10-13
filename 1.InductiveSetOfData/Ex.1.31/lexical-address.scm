(define get-position
  (lambda (sym l)
    (let inner ((sym sym) (l l) (p 0))
      (cond
       ((null? l) #f)
       ((eqv? sym (car l)) p)
       (else
	(inner sym (cdr l) (+ 1 p)))))))

(define get-lexical-address
  (lambda (symbol dict)
    (let inner ((symbol symbol) (dict dict) (d 0) (p 0))
      (if (null? dict)
	  (list symbol 'free)
	  (let ((pos (get-position symbol (car dict))))
	    (if (eqv? pos #f)
		(inner symbol (cdr dict) (+ 1 d) 0)
		(list symbol ': d pos)))))))

(define lexical-address
  (lambda (l)
    (let inner ((l l) (dict '()))
      (cond
       ((null? l) '())
       ((symbol? l) (get-lexical-address l dict))
       ((eqv? (car l) 'lambda)
	(list (car l) (cadr l) (inner (caddr l) (cons (cadr l) dict))))
       ((eqv? (car l) 'if)
	(cons (car l) (cons (inner (cadr l) dict) (inner (cddr l) dict))))
       (else
	(cons (inner (car l) dict) (inner  (cdr l) dict)))))))

	      