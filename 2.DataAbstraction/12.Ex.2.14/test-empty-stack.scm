(use gauche.test)
(add-load-path ".")
(load "stacks")

(test-start "stack")
(test-section "empty-stack")

(test* "empty-stack"
       '()
       (empty-stack))

(test-section "empty-stack?")
(test* "empty-stack"
       #t
       (empty-stack? (empty-stack)))

(test-section "push")
(test* "pushed stack is not empty"
       #f
       (empty-stack? (push 1 (empty-stack))))

(test-section "pop")
(test* "cannot pop from empty-stack"
       (test-error)
       (pop (empty-stack)))
(test* "get top of stack"
       (empty-stack)
       (pop (push 1 (empty-stack))))
(test* "after pop"
       #t
       (empty-stack? (pop (push 1 (empty-stack)))))

(test-section "top")
(test* "cannot get from empty-stack"
       (test-error)
       (top (empty-stack)))
(test* "top of _not empty-stack_ check"
       1
       (top (push 1 (empty-stack))))
(test* "top not pop"
       #f
       (empty-stack? (top (push 1 (empty-stack)))))

(test-end)
