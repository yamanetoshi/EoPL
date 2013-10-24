(use gauche.test)
(add-load-path ".")
(load "parse-expression")

;(add-load-path "../../define-datatype")
;(load "define-datatype")

(test-start "parse-expression")
(test-section "if-exp")
(test* "cdr is null"
       (test-error)
       (parse-expression '(if)))
(test* "cadr is not pair"
       (test-error)
       (parse-expression '(if a)))
(test* "cddr is null"
       (test-error)
       (parse-expression '(if (a))))
(test* "cdddr is null"
       (test-error)
       (parse-expression '(if (a) x)))
(test* "normal case"
       '(if-exp (app-exp (free-info a) (free-info b)) (free-info x) (free-info y))
       (parse-expression '(if (a b) x y)))

(test-section "lambda-exp")
(test* "cdr is null"
       (test-error)
       (parse-expression '(lambda)))
(test* "cddr is null"
       (test-error)
       (parse-expression '(lambda ())))
(test* "normal case"
       '(lambda-exp (x) (free-info a))
       (parse-expression '(lambda (x) a)))

(test-section "app-exp")
(test* "cdr is null"
       (test-error)
       (parse-expression '(a)))
(test* "cddr is not null"
       (test-error)
       (parse-expression '(a b c)))
(test* "normal case"
       '(app-exp (free-info a) (free-info b))
       (parse-expression '(a b)))

(test-end)
