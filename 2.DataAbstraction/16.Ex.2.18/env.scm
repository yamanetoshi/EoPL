(add-load-path "../../define-datatype")
(load "define-datatype")

(define-datatype environment environment?
  (empty-env-record)
  (extended-env-record
   (syms (list-of symbol?))
   (vals (list-of scheme-value?))
   (env environment?)))

(define scheme-value? (lambda (v) #t))

(define empty-env
  (lambda ()
    (empty-env-record)))

(define extend-env
  (lambda (syms vals env)
    (extended-env-record syms vals env)))

(define apply-env
  (lambda (env sym)
    (cases environment env
      (empty-env-record ()
        (eopl:error 'apply-env "No binding for ~s" sym))
      (extended-env-record (syms vals env)
        (let ((pos (list-find-position sym syms)))
	  (if (number? pos)
	      (list-ref vals pos)
	      (apply-env env sym)))))))

(define environment-to-list
  (lambda (env)
    (cases environment env
      (empty-env-record ()
        '(empty-env-record))
      (extended-env-record (syms vals env)
        (list 'extended-env-record syms vals (environment-to-list env))))))