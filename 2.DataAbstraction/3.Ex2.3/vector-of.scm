(define vector-of
  (lambda (pred)
    (lambda (val)
      (let ((len (vector-length val)))
        (let f ((n 0))
          (or (= n len)
              (and (pred (vector-ref val n))
                   (f (+ n 1)))))))))
