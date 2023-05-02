(define (filter-lst fn lst)
  'YOUR-CODE-HERE
  (cond
  ((eq? lst nil) ())
  ((fn (car lst)) (cons (car lst) (filter-lst fn (cdr lst))))
  (else (filter-lst fn (cdr lst)))
  )
)

;;; Tests
(define (even? x)
  (= (modulo x 2) 0))
(filter-lst even? '(0 1 1 2 3 5 8))
; expect (0 2 8)


(define (interleave first second)
  'YOUR-CODE-HERE
  (cond
  ((equal? first nil) second)
  ((equal? second nil) first)
  (else (cons (car first) (cons (car second) (interleave (cdr first) (cdr second)))))
  )
)

(interleave (list 1 3 5) (list 2 4 6))
; expect (1 2 3 4 5 6)

(interleave (list 1 3 5) nil)
; expect (1 3 5)

(interleave (list 1 3 5) (list 2 4))
; expect (1 2 3 4 5)


(define (accumulate combiner start n term)
  'YOUR-CODE-HERE
  (cond
  ((= n 1) (combiner start (term 1)))
  (else (combiner (term n) (accumulate combiner start (- n 1) term)))
  )
)

(define (helper x lst)
    (cond
    ((eq? lst nil) true)
    ((= x (car lst)) false)
    (else (helper x (cdr lst)))
    )
)

(define (no-repeats lst)
  'YOUR-CODE-HERE
  (cond
  ((eq? lst nil) ())
  ((helper (car lst) (cdr lst)) (cons (car lst) (no-repeats (cdr lst))))
  (else (no-repeats (cdr lst)))
  )
)

