(add-load-path "../../define-datatype")
(load "define-datatype")

(define bintree-to-list
  (lambda (tree)
    (cases bintree tree
	   (leaf-node (datum) (list 'leaf-node datum))
	   (interior-node (key left right)
			  (cons 'interior-node
				(list key 
				      (bintree-to-list left)
				      (bintree-to-list right)))))))
