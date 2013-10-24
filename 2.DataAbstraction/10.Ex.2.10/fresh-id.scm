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
      (var-exp (id) id)
      (lambda-exp (id body)
        (cons id (all-ids body)))
      (app-exp (rator rand)
        (cons (all-ids rator) (all-ids rand))))))

(define fresh-id
  (lambda (exp s)
    (let ((syms (all-ids exp)))
      (letrec ((loop (lambda (n)
		       (let ((sym (string->symbol
				   (string-append s
						  (number->string n)))))
			 (if (memv sym syms) (loop (+ n 1)) sym)))))
	(loop 0)))))
