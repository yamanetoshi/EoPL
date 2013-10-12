(add-load-path ".")
(add-load-path "../../define-datatype")

(load "define-datatype")
(load "bintree")
(load "leaf-sum")

(define enumerate-interior-node
  (lambda (tree)
    (cases bintree tree
	   (leaf-node (datum) '())
	   (interior-node
	    (key left right)
	    (append (list tree)
		    (enumerate-interior-node left)
		    (enumerate-interior-node right))))))

(define max-interior
  (lambda (tree)
    (let ((l (sort (map (lambda (x) (list (cadr x) (leaf-sum x)))
			(enumerate-interior-node tree))
		   (lambda (x y) (> (cadr x) (cadr y))))))
      (car (car l)))
    ))
