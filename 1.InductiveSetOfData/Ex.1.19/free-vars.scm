(add-load-path ".")
(load "enum-vars")
(load "occurs-free")

(define free-vars
  (lambda (exp)
    (let inner ((l (enum-filter-vars exp)))
      (if (null? l)
	  '()
	  (if (occurs-free? (car l) exp)
	      (cons (car l) (inner (cdr l)))
	      (inner (cdr l)))))))
