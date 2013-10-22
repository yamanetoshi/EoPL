(use gauche.test)
(add-load-path ".")
(load "enum-vars")

(test-start "enum-vars")
(test-section "enum-filter-vars")
(test* "application"
       '(a)
       (enum-filter-vars '((lambda (a) a) a)))

(test-section "enum-vars")
(test* "null"
       '()
       (enum-vars '()))
(test* "symbol"
       '(a)
       (enum-vars '(a)))
(test* "lambda exp"
       '(a)
       (enum-vars '(lambda (a) a)))
(test* "application"
       '((a) b)
       (enum-vars '((lambda (a) a) b)))


(test-end)
