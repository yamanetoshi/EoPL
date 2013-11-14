(add-load-path "../../define-datatype")
(load "define-datatype")

(define-datatype stack stack?
  (empty-stack-record)
  (extended-stack-record
    (val scheme-value?)
    (stk stack?)))

(define scheme-value?
  (lambda (v) #t))

(define empty-stack
  (lambda ()
    (empty-stack-record)))

(define empty-stack?
  (lambda (s)
    (cases stack s
      (empty-stack-record () #t)
      (extended-stack-record (val stk) #f))))

(define push
  (lambda (value s)
    (extended-stack-record value s)))

(define stack-access
  (lambda (access s)
    (cases stack s
      (empty-stack-record () (eopl:error 'stack-access "No data"))
      (extended-stack-record (val stk)
        (cond ((eqv? access 'pop)
               stk)
              ((eqv? access 'top)
               val))))))

(define pop
  (lambda (s) (stack-access 'pop s)))
(define top
  (lambda (s) (stack-access 'top s)))