(use gauche.test)
(add-load-path ".")
(load "occurs-bound")
(load "parse-expression")

(test-start "occurs-bound")
(test-section "occurs-bound")
(test* "not bound"
       #f
       (occurs-bound? 'x (parse-expression 5)))

(test* "not bound (2)"
       #f
       (occurs-bound? 'x (parse-expression 'x)))

(test* "not bound (2)"
       #f
       (occurs-bound? 'x (parse-expression 'y)))

(test* "not bound (3)"
       #f
       (occurs-bound? 'x (parse-expression '(lambda (y) x))))

(test* "not bound (3)"
       #f
       (occurs-bound? 'x (parse-expression '(if (null? x) 1 2))))

(test* "not bound (3)"
       #f
       (occurs-bound? 'x (parse-expression '(if (null? y) x 2))))

(test* "not bound (3)"
       #f
       (occurs-bound? 'x (parse-expression '(if (null? y) 1 x))))

(test* "lambda exp (occurs-bound)"
       #t
       (occurs-bound? 'x (parse-expression '(lambda (x) x))))

(test* "lambda exp (not-bound)"
       #f
       (occurs-bound? 'x (parse-expression '(lambda (x) y))))

(test* "lambda exp (occurs-bound)"
       #t
       (occurs-bound? 'x (parse-expression '(lambda (y) y))))

(test* "app exp (occurs-bound)"
       #t
       (occurs-bound? 'x (parse-expression '((lambda (x) x) y))))

(test* "app exp"
       #t
       (occurs-bound? 'x (parse-expression '((lambda (y) y) x))))

(test* "app exp (not-bound)"
       #f
       (occurs-bound? 'x (parse-expression '((lambda (x) y) y))))

(test-end)