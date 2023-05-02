(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement

(define (zip lst)
  (if
    (equal? lst nil)
    (cons nil (cons nil nil))
    (cons (cons (caar lst) (car (zip (cdr lst)))) (cons (cons (car (cdar lst)) (car (cdr (zip (cdr lst))))) nil))
  )
)


;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (begin
    (define (helper s num) 
    (if (equal? s nil) 
    nil
    (cons (cons num (cons (car s) nil)) (helper (cdr s) (+ num 1))))
    )
  (helper s 0)
  )
  )

  ; END PROBLEM 15


;; Problem 16

;; Merge two lists LIST1 and LIST2 according to COMP and return
;; the merged lists.
(define (merge comp list1 list2)
  ; BEGIN PROBLEM 16
  (cond
  ((equal? list1 nil) list2)
  ((equal? list2 nil) list1)
  ((comp (car list1) (car list2)) 
  (cons (car list1) (cons (car list2) (merge comp (cdr list1) (cdr list2)))) 
  )
  (else
  (cons (car list2) (cons (car list1) (merge comp (cdr list1) (cdr list2))))
  )
  )
  )
  ; END PROBLEM 16


(merge < '(1 5 7 9) '(4 8 10))
; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))
; expect (10 9 8 7 5 4 3 1)

;; Problem 17

(define (cmp a b)
  (if 
    (< a b)
    #t
    (if 
      (= a b) 
      #t 
      #f
    )
  )
)

(define (nondecreaselist s)
  (if (equal? nil (cddr s)) 
      (if 
        (cmp (car s) (cadr s)) 
        (cons (cons (car s) (cons (cadr s) nil)) nil)
        (cons (cons (car s) nil) (cons (cons (cadr s) nil) nil))
      )
      (if 
        (cmp (car s) (cadr s))
        (cons (cons (car s) (car (nondecreaselist (cdr s)))) (cdr (nondecreaselist (cdr s))))
        (cons (cons (car s) nil) (nondecreaselist (cdr s)))
      )
  )
)
; END PROBLEM 17

;; Problem EC
;; Returns a function that checks if an expression is the special form FORM

(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond 
    (
      (atom? expr)
      expr
    )
    (
      (quoted? expr)
      ;(let-to-lambda (cadr expr))
      expr
    )
    (
      (or (lambda? expr) (define? expr)) 
      (let 
      ((form (car expr)) (params (cadr expr)) (body (cddr expr)))
      (append (list form params) (map let-to-lambda body))
      )
    )
    (
      (let? expr) 
      (let 
      ((values (cadr expr)) (body (cddr expr)))
      ;(cons (cons 'lambda (cons (car (zip values)) (let body))) (cadr (zip values)))
      
      (define form (car (zip values)))
      (define params (map let-to-lambda (cadr (zip values))))
      (define body (map let-to-lambda body))
      (cons (append (list 'lambda form) body) params)

      )
    )
    (
      else 
      ;expr
      (map let-to-lambda expr)
    )
)
)