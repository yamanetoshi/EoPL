(use srfi-1)

(define enum-filter-vars
  (lambda (exp)
    (delete-duplicates (flatten (enum-vars exp)))))

(define enum-vars
  (lambda (exp)
    (cond
     ((null? exp) '())
     ((symbol? exp) exp)
     ((eqv? (car exp) 'lambda)
      (enum-vars (cddr exp)))
     (else
      (cons (enum-vars (car exp))
	    (enum-vars (cdr exp)))))))

(define (flatten xs)
  (cond ((null? xs) '())
	((pair? xs) (append-map flatten xs))
	(else
	 (list xs))))
