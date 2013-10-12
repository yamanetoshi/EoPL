(use gauche.test)

(add-load-path ".")
(load "bintree")
(load "max-interior")

(define tree-a (interior-node 'a (leaf-node 2) (leaf-node 3)))
(define tree-b (interior-node 'b (leaf-node -1) tree-a))
(define tree-c (interior-node 'c tree-b (leaf-node 1)))
(define tree-d (interior-node 'd (leaf-node -2) (leaf-node -3)))
(define tree-e (interior-node 'e tree-d tree-c))
(define tree-f (interior-node 'f (leaf-node -1) (leaf-node -5)))
(define tree-g (interior-node 'g tree-d tree-f))

(test-start "max-interior")
(test-section "enumerate-interior-node")
(test* "tree-a enum"
       (list tree-a)
       (enumerate-interior-node tree-a))
(test* "tree-b enum"
       (append (list tree-b) (list tree-a))
       (enumerate-interior-node tree-b))
(test* "tree-c enum"
       (append (list tree-c) (list tree-b) (list tree-a))
       (enumerate-interior-node tree-c))
(test* "tree-d enum"
       (list tree-d)
       (enumerate-interior-node tree-d))
(test* "tree-e enum"
       (append (list tree-e) (list tree-d) (list tree-c) (list tree-b) (list tree-a))
       (enumerate-interior-node tree-e))
(test* "tree-f enum"
       (list tree-f)
       (enumerate-interior-node tree-f))
(test* "tree-g enum"
       (append (list tree-g) (list tree-d) (list tree-f))
       (enumerate-interior-node tree-g))

(test-section "max-interior")
(test* "sample1"
       'a
       (max-interior tree-b))

(test* "sample2"
       'c
       (max-interior tree-c))

(test* "tree-e"
       'c
       (max-interior tree-e))

(test* "tree-g"
       'd
       (max-interior tree-g))

(test-end)
