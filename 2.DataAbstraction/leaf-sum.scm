(define leaf-sum
  (lambda (tree)
    (cases bintree tree
	   (leaf-node (datum) datum)
	   (interior-node (key left right)
			  (+ (leaf-sum left) (leaf-sum right))))))
