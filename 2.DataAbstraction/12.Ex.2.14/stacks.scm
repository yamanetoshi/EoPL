(define empty-stack
  (lambda ()
    '()))
(define empty-stack? null?)

(define push
  (lambda (value list)
    (cons value list)))
(define pop
  (lambda (list)
    (cdr list)))
(define top
  (lambda (list)
    (car list)))
