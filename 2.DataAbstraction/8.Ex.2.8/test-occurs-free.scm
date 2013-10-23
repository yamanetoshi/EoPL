(use gauche.test)
(add-load-path ".")
(load "occurs-free")
(load "parse-expression")

(test-start "occurs-free")
(test-section "occurs-free")
(test* "literal"
       #t
       (occurs-free? 'x (parse-expression 5)))

(test* "variable"
       #t
       (occurs-free? 'x (parse-expression 'x)))

(test* "variable"
       #t
       (occurs-free? 'x (parse-expression 'y)))

(test* "if exp"
       #t
       (occurs-free? 'x (parse-expression '(if (null? x) 1 2))))

(test* "if exp (2)"
       #t
       (occurs-free? 'x (parse-expression '(if (null? y) x 2))))

(test* "if exp (3)"
       #t
       (occurs-free? 'x (parse-expression '(if (null? y) 1 x))))

(test* "lambda exp"
       #f
       (occurs-free? 'x (parse-expression '(lambda (x) x))))

(test* "lambda exp"
       #t
       (occurs-free? 'x (parse-expression '(lambda (x) y))))

(test* "lambda exp"
       #t
       (occurs-free? 'x (parse-expression '(lambda (y) x))))

(test* "app exp"
       #t
       (occurs-free? 'x (parse-expression '((lambda (x) x) y))))

(test* "app exp"
       #t
       (occurs-free? 'x (parse-expression '((lambda (y) y) x))))

(test* "app exp (not-bound)"
       #t
       (occurs-free? 'x (parse-expression '((lambda (x) y) y))))

(test-end)