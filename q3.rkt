#lang racket
(require typed-stack)
(require dyoo-while-loop)

(define stck (make-stack #\#))

(define (is-operator x) (
    if (char? x) 
        (if (or (char=? x #\+) (char=? x #\-) (char=? x #\/) (char=? x #\*))
            #t #f
        ) #f
))

(define (evaluate operator op1 op2) (
    if (char=? operator #\+) 
        (+ op1 op2)
        (if (char=? operator #\-) (- op1 op2)
            (if (char=? operator #\*) 
                (* op1 op2)
                (if (char=? operator #\/) (/ op1 op2) 0
                )
            )
        )
))

(define (evalPostfixExpr postFixExpr) (begin
    (for ([i postFixExpr]) (begin
        (if (number? i) 
        (push! stck i)
        (if (is-operator i)
            (let ([x (top stck)] [y 0]) (begin
                (pop! stck)
                (set! y (top stck))
                (pop! stck)
                (push! stck (evaluate i y x))
            ))
            null
        ))
    ))
    (top stck)
))


(println (evalPostfixExpr '(5 1 2 #\+ 4 #\* #\+ 3 #\-)))