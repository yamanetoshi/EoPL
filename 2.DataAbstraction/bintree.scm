(add-load-path "../../define-datatype")
(load "define-datatype")

(define-datatype bintree bintree?
  (leaf-node
   (datum number?))
  (interior-node
   (key symbol?)
   (left bintree?)
   (right bintree?)))
