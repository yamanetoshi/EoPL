(use gauche.test)
(add-load-path ".")
(load "bound-vars")

(test-start "bound-vars")
(test-section "bound-vars")
(test* "no bound-vars"
       '()
       (bound-vars '()))

(test* "no free-vars (2)"
       '()
       (bound-vars '(lambda (x) y)))

(test* "some bound vars"
       '(x)
       (bound-vars '(lambda (x) x)))

(test* "some bound vars (2)"
       '(y x)
       (bound-vars '(lambda (x) ((lambda (y) y) x))))

(test* "some bound vars (3)"
       '(c b a)
       (bound-vars '(lambda (a) ((lambda (b) ((lambda (c) c) b)) a))))

(test-end)
