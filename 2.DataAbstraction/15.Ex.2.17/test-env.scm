(use gauche.test)
(add-load-path ".")
(load "env")

(test-start "has-association?")
(test-section "empty-env")

(test* "empty-env"
       #f
       (has-association? (empty-env) 'a))

(test* "empty-env"
       (test-error)
       (apply-env (empty-env) 'a))

(test-section "has-association")
(test* "env does not have value"
       #f
       (has-association? (extend-env '(x y) '(1 2) (empty-env)) 'a))

(test* "env does not have value"
       #t
       (has-association? (extend-env '(x y) '(1 2) (empty-env)) 'x))

(test-section "apply-env")
(test* "env does not have value"
       (test-error)
       (apply-env (extend-env '(x y) '(1 2) (empty-env)) 'a))

(test* "env does not have value"
       1
       (apply-env (extend-env '(x y) '(1 2) (empty-env)) 'x))

(test-end)