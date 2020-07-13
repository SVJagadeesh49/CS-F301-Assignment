#lang racket

(require racket/include)
(include "q1.rkt")
(require racket/trace)
(trace sumUpRecursive)
(trace sumUpTailRecursion)
(sumUpRecursive '(100 20 41 203))
(sumUpTailRecursion '(100 20 41 203) 0)