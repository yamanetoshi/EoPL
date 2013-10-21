(add-load-path "../../define-datatype")
(load "define-datatype")

(define-datatype lexical-address lexical-address?
  (lit-exp
   (datum number?))
  (lex-info
   (id symbol?)
   (depth number?)
   (position number?))
  (free-info
   (id symbol?))
  (if-exp
   (test-exp lexical-address?)
   (true-exp lexical-address?)
   (false-exp lexical-address?))
  (lambda-exp
   (args list?)
   (body lexical-address?))
  (app-exp
   (rator lexical-address?)
   (rand lexical-address?)))
