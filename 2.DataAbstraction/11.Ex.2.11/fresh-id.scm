(add-load-path ".")
(load "expression")

(use srfi-1)

(define enum-filter-vars
  (lambda (exp)
    (delete-duplicates (flatten (enum-vars exp)))))

(define (flatten xs)
  (cond ((null? xs) '())
	((pair? xs) (append-map flatten xs))
	(else
	 (list xs))))

(define all-ids
  (lambda (exp)
    (delete-duplicates (flatten (enum-ids exp)))))

(define enum-ids
  (lambda  (exp)
    (cases expression exp
      (lit-exp (datum) '())
      (var-exp (id) id)
      (if-exp (test-exp true-exp false-exp)
	(cons (all-ids test-exp) (cons (all-ids true-exp) (all-ids false-exp))))
      (lambda-exp (id body)
        (cons id (all-ids body)))
      (app-exp (rator rand)
        (cons (all-ids rator) (all-ids rand)))
      (primapp-exp (prim rand1 rand2)
	(cons (all-ids rand1) (all-ids rand2))))))
		  

(define fresh-id
  (lambda (exp s)
    (let ((syms (all-ids exp)))
      (letrec ((loop (lambda (n)
		       (let ((sym (string->symbol
				   (string-append s
						  (number->string n)))))
			 (if (memv sym syms) (loop (+ n 1)) sym)))))
	(loop 0)))))
