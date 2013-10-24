(add-load-path "../../define-datatype")
(load "define-datatype")

(define-datatype expression expression?
  (var-exp
   (id symbol?))
  (lambda-exp
   (id symbol?)
   (body expression?))
  (app-exp
   (rator expression?)
   (rand expression?)))
