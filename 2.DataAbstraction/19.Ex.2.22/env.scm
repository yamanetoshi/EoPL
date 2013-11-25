(add-load-path "../../define-datatype")
(load "define-datatype")

(define-datatype environment environment?
  (empty-env-record)
  (extended-env-record
   (syms (list-of symbol?))
   (vals vector?)
   (env environment?)))

(define scheme-value? (lambda (v) #t))

(define empty-env
  (lambda ()
    (empty-env-record)))

(define extend-env
  (lambda (syms vals env)
    (extended-env-record syms (list->vector vals) env)))

(define apply-env
  (lambda (env sym)
    (cases environment env
      (empty-env-record ()
        (eopl:error 'apply-env "No binding for ~s" sym))
      (extended-env-record (syms vals env)
        (let ((pos (list-find-position sym syms)))
	  (if (number? pos)
	      (vector-ref vals pos)
	      (apply-env env sym)))))))

(define has-association?
  (lambda (env sym)
    (cases environment env
      (empty-env-record () #f)
      (extended-env-record (syms vals env)
        (let ((pos (list-find-position sym syms)))
	  (if (number? pos)
	      #t
	      (has-association? env sym)))))))

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

(define environment-to-list
  (lambda (env)
    (cases environment env
      (empty-env-record ()
        '(empty-env-record))
      (extended-env-record (syms vals env)
        (list 'extended-env-record syms (vector->list vals) (environment-to-list env))))))