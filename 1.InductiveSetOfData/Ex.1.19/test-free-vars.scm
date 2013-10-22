(use gauche.test)
(add-load-path ".")
(load "free-vars")

(test-start "free-vars")
(test-section "free-vars")
(test* "no free-vars"
       '()
       (free-vars '()))

(test* "no free-vars (2)"
       '()
       (free-vars '(lambda (x) x)))

(test* "some free vars"
       '(x)
       (free-vars '(lambda (y) x)))

(test* "some free vars (2)"
       '(x y)
       (free-vars '(lambda (a) (x y))))

(test* "some free vars (2)"
       '(a b c)
       (free-vars '((lambda (x) a) (b c))))

(test-end)
