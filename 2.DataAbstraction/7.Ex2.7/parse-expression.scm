(add-load-path ".")
(load "lexical-address")

(define get-position
  (lambda (sym l)
    (let inner ((sym sym) (l l) (p 0))
      (cond
       ((null? l) #f)
       ((eqv? sym (car l)) p)
       (else
        (inner sym (cdr l) (+ 1 p)))))))

(define get-lexical-address
  (lambda (symbol dict)
    (let inner ((symbol symbol) (dict dict) (d 0) (p 0))
      (if (null? dict)
          (free-info symbol)
          (let ((pos (get-position symbol (car dict))))
            (if (eqv? pos #f)
                (inner symbol (cdr dict) (+ 1 d) 0)
                (lex-info symbol d pos)))))))

(define parse-expression
  (lambda (datum)
    (let inner ((datum datum) (dict '()))
      (cond
       ((null? datum) '())
       ((number? datum) (lit-exp datum))
       ((symbol? datum) (get-lexical-address datum dict))
       ((pair? datum)
	(cond
	 ((eqv? (car datum) 'lambda)
	  (lambda-exp (cadr datum)
		      (inner (caddr datum) (cons (cadr datum) dict))))
	 ((eqv? (car datum) 'if)
	  (if-exp (inner (cadr datum) dict)
		  (inner (caddr datum) dict)
		  (inner (cadddr datum) dict)))
	 (else
	  (app-exp
	   (inner (car datum) dict)
	   (inner (cadr datum) dict)))))
       (else
	(eopl:error 'parse-expression
		    "Invalid concrete syntax ~s" datum))))))