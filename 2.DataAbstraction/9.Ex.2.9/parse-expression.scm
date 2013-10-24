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
(define parse-lambda-exp
  (lambda (datum dict)
    (cond
     ((or (not (cdr datum))
	  (not (cddr datum)))
      (eopl:error 'parse-expression
		  "Invalid lambda-exp syntax ~s" datum))
     (else
      (lambda-exp (cadr datum)
		  (parse-with-dict (caddr datum) (cons (cadr datum) dict)))))))

(define parse-if-exp
  (lambda (datum dict)
    (cond
     ((or (null? (cdr datum))
	  (null? (cddr datum))
	  (null? (cdddr datum)))
      (eopl:error 'parse-expression
		  "Invalid if-exp syntax ~s" datum))
     (else
	(if-exp (parse-with-dict (cadr datum) dict)
		(parse-with-dict (caddr datum) dict)
		(parse-with-dict (cadddr datum) dict))))))

(define parse-app-exp
  (lambda (datum dict)
    (cond
     ((or (null? (cdr datum))
	  (not (null? (cddr datum))))
      (eopl:error 'parse-expression
		  "Invalid app-exp syntax ~s" datum))
     (else
      (app-exp
       (parse-with-dict (car datum) dict)
       (parse-with-dict (cadr datum) dict))))))

(define parse-with-dict
  (lambda (datum dict)
    (cond
     ((null? datum) '())
     ((number? datum) (lit-exp datum))
     ((symbol? datum) (get-lexical-address datum dict))
     ((pair? datum)
      (cond
       ((eqv? (car datum) 'lambda)
	(parse-lambda-exp datum dict))
       ((eqv? (car datum) 'if)
	(parse-if-exp datum dict))
       (else
	(parse-app-exp datum dict))))
     (else
      (eopl:error 'parse-expression
		  "Invalid concrete syntax ~s" datum)))))

(define parse-expression
  (lambda (datum)
    (parse-with-dict datum '())))
