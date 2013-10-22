(add-load-path ".")
(load "enum-vars")
(load "occurs-bound")

(define bound-vars
  (lambda (exp)
    (let inner ((l (enum-filter-vars exp)))
      (if (null? l)
	  '()
	  (if (occurs-bound? (car l) exp)
	      (cons (car l) (inner (cdr l)))
	      (inner (cdr l)))))))
		    