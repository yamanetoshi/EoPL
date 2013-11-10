(define empty-stack
  (lambda ()
    (lambda (sym)
      (cond ((eqv? sym 'empty-stack?) #t)
	    (else
	     (eopl:error 'empty-stack "stack is empty ~s" sym))))))

(define push
  (lambda (value stack)
    (lambda (sym)
      (cond ((eqv? sym 'pop) stack)
	    ((eqv? sym 'top) value)
	    ((eqv? sym 'empty-stack?) #f)))))

(define pop
  (lambda (stack)
    (stack 'pop)))

(define top
  (lambda (stack)
    (stack 'top)))

(define empty-stack?
  (lambda (stack)
    (stack 'empty-stack?)))