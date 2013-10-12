(use gauche.test)

(add-load-path ".")
(load "vector-of")

(test-start "vector-of")
(test-section "vector-of")
(test* "number vector"
       #t
       ((vector-of number?) #(1 2 3 4 5)))
(test* "not number vector"
       #f
       ((vector-of number?) #(1 2 a 4 5)))
(test* "not number vector"
       #f
       ((vector-of number?) #(a b c)))

(test* "symbol vector"
       #t
       ((vector-of symbol?) #(a b c)))
(test* "not symbol vector"
       #f
       ((vector-of symbol?) #(a 2 c)))
(test* "not symbol vector"
       #f
       ((vector-of symbol?) #(1 2 3 4 5)))

(test-end)
