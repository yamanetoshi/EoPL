(define list-find-position
  (lambda (sym los)
    (list-index (lambda (sym1) (eqv? sym1 sym)) los)))
(define list-index
  (lambda (pred ls)
    (cond
     ((null? ls) #f)
     ((pred (car ls)) 0)
     (else
      (let ((list-index-r (list-index pred (cdr ls))))
	(if (number? list-index-r)
	    (+ list-index-r 1)
	    #f))))))

(define list-tail
  (lambda (l pos)
    (let inner ((l l) (pos (+ pos 1)))
      (if (eq? 0 pos)
	  l
	  (inner (cdr l) (- pos 1))))))

(define list-find-last-position
  (lambda (sym los)
    (let ((pos (list-find-position sym los)))
      (if (not pos)
	  pos
	  (let inner ((pos pos) (l (list-tail los pos)))
	    (let ((newpos (list-find-position sym l)))
	      (if (not newpos)
		  pos
		  (inner (+ 1 pos newpos) (list-tail l newpos)))))))))
