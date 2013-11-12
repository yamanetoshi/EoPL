(use gauche.test)
(add-load-path ".")
(load "env")

(test-start "list-find-last-position")
(test-section "list-find-last-position")

(test* "list-find-position"
       1
       (list-find-position 'a '(c a b a c a d e)))

(test* "list-find-last-position"
       5
       (list-find-last-position 'a '(c a b a c a d e)))

(test* "list-find-last-position"
       5
       (list-find-last-position 'a '(c d b d c a d e)))

(test* "list-find-last-position"
       5
       (list-find-last-position 'a '(a a a a a a d e)))

(test-end)