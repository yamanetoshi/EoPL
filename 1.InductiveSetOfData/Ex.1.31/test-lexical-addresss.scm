(use gauche.test)

(add-load-path ".")
(load "lexical-address")

(test-start "lexical-address")
(test-section "lexical-address")
(test* "example"
       '(lambda (a b c)
	  (if ((eqv? free) (b : 0 1) (c : 0 2))
	      ((lambda (c)
		 ((cons free) (a : 1 0) (c : 0 0)))
	       (a : 0 0))
	      (b : 0 1)))
       (lexical-address '(lambda (a b c)
	  (if (eqv? b c)
	      ((lambda (c)
		 (cons a c))
	       a)
	      b))))

(test-end)