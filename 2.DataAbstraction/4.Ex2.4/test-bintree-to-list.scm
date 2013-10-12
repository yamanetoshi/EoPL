(use gauche.test)

(add-load-path ".")
(add-load-path "..")
(load "bintree")
(load "bintree-to-list")

(define tree-a (interior-node 'a (leaf-node 2) (leaf-node 3)))
(define tree-b (interior-node 'b (leaf-node -1) tree-a))
(define tree-c (interior-node 'c tree-b (leaf-node 1)))

(test-start "bintree-to-list")
(test-section "bintree-to-list")
(test* "tree-a"
       '(interior-node a (leaf-node 2) (leaf-node 3))
       (bintree-to-list tree-a))

(test* "tree-b"
       '(interior-node b (leaf-node -1)
		       (interior-node a (leaf-node 2) (leaf-node 3)))
       (bintree-to-list tree-b))

(test* "tree-c"
       '(interior-node c
		       (interior-node b 
				      (leaf-node -1)
				      (interior-node a
						     (leaf-node 2)
						     (leaf-node 3)))
		       (leaf-node 1))
       (bintree-to-list tree-c))
       

(test-end)
