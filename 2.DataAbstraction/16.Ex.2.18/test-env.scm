(use gauche.test)
(add-load-path ".")
(load "env")

(test-start "env")
(test-section "environment-to-list")

(test* "example"
       '(extended-env-record (d x) (6 7)
	  (extended-env-record (y) (8)
            (empty-env-record)))
       (environment-to-list 
	(extend-env 
	 '(d x) '(6 7)
	 (extend-env
	  '(y) '(8)
	  (empty-env)))))				       

(test-end)