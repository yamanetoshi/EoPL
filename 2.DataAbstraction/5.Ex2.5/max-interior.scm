(add-load-path ".")
(add-load-path "../../define-datatype")

(load "define-datatype")
(load "bintree")
(load "leaf-sum")


;; interior-node 数え上げ

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

(define max-interior-1
  (lambda (tree)
    (define (max-interior-inner rslt t)
      (let ((x (leaf-sum t)))
	(cases bintree t
	       (interior-node 
		(key left right)
		(let ((rettmp (if (or (> x (cadr rslt))
				      (not (car rslt)))
				  (list key x)
				  rslt))
		      (end (and (eq? 'leaf-node (car left))
				(eq? 'leaf-node (car right)))))
		  (let ((ret (if (eq? 'leaf-node (car left))
				 rettmp
				 (max-interior-inner rettmp left))))
		    (if end
			rettmp
			(max-interior-inner ret right)))))
	       (else rslt)))
      )
    (car (max-interior-inner '(#f 0) tree))
    )
  )
