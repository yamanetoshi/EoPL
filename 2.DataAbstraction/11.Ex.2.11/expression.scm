(add-load-path "../../define-datatype")
(load "define-datatype")

(define-datatype expression expression?
  (lit-exp
   (datum number?))
  (var-exp
   (id symbol?))
  (if-exp
   (test-exp expression?)
   (true-exp expression?)
   (false-exp expression?))
  (lambda-exp
   (id symbol?)
   (body expression?))
  (app-exp
   (rator expression?)
   (rand expression?))
  (primapp-exp
   (prim (lambda (x) (or (eqv? '+ x) (eqv? '* x))))
   (rand1 expression?)
   (rand2 expression?)))
