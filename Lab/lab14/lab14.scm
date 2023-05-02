(define (split-at lst n)
  (cond
  ((equal? n 0) (cons nil lst))
  ((equal? lst nil) (cons nil nil))
  (else (cons 
        (cons (car lst) (car (split-at (cdr lst) (- n 1)))) 
        (cdr (split-at (cdr lst) (- n 1)))
        )
  )
  )
)


(define (compose-all funcs)
  'YOUR-CODE-HERE
  (define (helper x)
    (define (helper2 funcs x)
      (cond
      ((equal? funcs nil) x)
      (else (helper2 (cdr funcs) ((car funcs) x)))
      )
    )
    (helper2 funcs x)
  )
  helper
)

