(add-load-path ".")
(load "enum-vars")
(load "occurs-bound")
(load "parse-expression")

(define bound-vars
  (lambda (exp)
    (let inner ((l (enum-filter-vars exp)) (i-exp (parse-expression exp)))
      (if (null? l)
	  '()
	  (if (occurs-bound? (car l) i-exp)
	      (cons (car l) (inner (cdr l) i-exp))
	      (inner (cdr l) i-exp))))))