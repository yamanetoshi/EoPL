(use gauche.test)
(add-load-path ".")
(load "fresh-id")

(test-start "fresh-id")
(test-section "all-ids")
(test* "example"
       '(w2 w1 w0 w3)
       (all-ids '(app-exp (lambda-exp w2
				      (app-exp (var-exp w1) (var-exp w0)))
			  (var-exp w3))))

(test-section "fresh-id")
(test* "example"
       'w4
       (fresh-id '(app-exp (lambda-exp 'w2
				       (app-exp (var-exp 'w1) (var-exp 'w0)))
			   (var-exp 'w3))
		 "w"))

(test-end)