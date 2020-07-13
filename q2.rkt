#lang racket
(require typed-stack)
(require dyoo-while-loop)

(define stk (make-stack #\#))
(define postfix '())

(define (is-alpha-num x) (
    or (and (char? x) (char-alphabetic? x)) (number? x)
))

(define (char-append strin x) (
    append strin (make-list 1 x)
))

(define (prec x) 
    (if (or (char=? x #\+) (char=? x #\-))
        1 (if (char=? x #\*) 2 0)
    )
)

(define (infixToPostfix inp) (begin
    (for ([i inp]) (
        if (is-alpha-num i) 
            (set! postfix (char-append postfix i))
            (if (char=? i #\( )
                (push! stk i)
                (if (char=? i #\) )
                    (while (and (> (stack-length stk) 1) (not (char=? (top stk) #\( )))
                        (begin
                            (set! postfix (char-append postfix (top stk)))
                            (pop! stk)
                        )
                    )

                    (begin
                        (while (and (> (stack-length stk) 1) (<= (prec i) (prec (top stk))))
                            (begin
                                (set! postfix (char-append postfix (top stk)))
                                (pop! stk)
                        ))
                        (push! stk i)
                    )
                )
            )
    ))

    (while (> (stack-length stk) 1)
        (begin
            (set! postfix (char-append postfix (top stk)))
            (pop! stk)
        )
    )
    
    postfix
))

(println (infixToPostfix '( 1 #\+ 2 #\* 3 #\- 4 #\* 5)))
