

(define (sumUpRecursive list) 
    (cond
      [(empty? list) 0]
      [else (+ (first list) (sumUpRecursive (rest list)))]
))

(define (sumUpTailRecursion list ans)
      (cond
        [(empty? list) ans]
        [else (sumUpTailRecursion (rest list) (+ ans (first list) ))]))
