(use gauche.test)
(add-load-path ".")
(load "env")

(test-start "env")
(test-section "enpty-env")
(test* "empty-env"
       '()
       (empty-env))

(test-section "list-find-position")
(test* "(list-find-position 'a '())"
       #f
       (list-find-position 'a '()))
(test* "(list-find-position 'a '((b 1)))"
       #f
       (list-find-position 'a '((b . 1))))
(test* "(list-find-position 'a '((a 1)))"
       1
       (list-find-position 'a '((a . 1))))

(test-section "extend-env")
(test* "(extend-env 'a 1 (empty-env))"
       '((a . 1))
       (extend-env 'a 1 (empty-env)))

(test-section "apply-env")
(test* "(apply-env (empty-env) 'x)"
       (test-error)
       (apply-env (empty-env) 'x))
(test* "(apply-env (extend-env 'a 1 (empty-env)) 'x)"
       (test-error)
       (apply-env (extend-env 'a 1 (empty-env)) 'x))
(test* "(apply-env (extend-env 'a 1 (empty-env)) 'a)"
       1
       (apply-env (extend-env 'a 1 (empty-env)) 'a))

(test-end)