; Lines that start with a semicolon are comments

; Define the function for which you are constructing a transformer

; Define the transformer as two functions
; one for the lower bound of the range and one for the upper bound

; problem 1
(define-fun f ((x Real)) Real
(ite (> x 0) x (- x))       ; absolute value function
)

(define-fun Tf_lower ((l Real) (u Real)) Real
(ite (< u 0) (- u) (ite (< l 0) 0 l)); Your code here
)
(define-fun Tf_upper ((l Real) (u Real)) Real
(ite (< l 0) (ite (< (- l) u) u (- l)) u); Your code here
)
; problem 1

; problem 2
(define-fun f ((x Real)) Real
(* x (* x x))
)

(define-fun Tf_lower ((l Real) (u Real)) Real
(* l (* l l)); Your code here
)
(define-fun Tf_upper ((l Real) (u Real)) Real
(* u (* u u)); Your code here
)
; problem 2

; problem 3
(define-fun f ((x Real)) Real
(- x (ite (< x 0) (- x) x))
)

(define-fun Tf_lower ((l Real) (u Real)) Real
(ite (< l 0) (* 2 l) 0); Your code here
)
(define-fun Tf_upper ((l Real) (u Real)) Real
(ite (< u 0) (* 2 u) 0); Your code here
)
; problem 3

; problem 4
(define-fun f ((x Real)) Real
(ite (< (- x (ite (< x 0) (- x) x)) (+ x (ite (< x 0) (- x) x)))
(- x (ite (< x 0) (- x) x))
(+ x (ite (< x 0) (- x) x)))
)

(define-fun Tf_lower ((l Real) (u Real)) Real
(ite (< l 0) (* 2 l) 0); Your code here
)
(define-fun Tf_upper ((l Real) (u Real)) Real
(ite (< u 0) (* 2 u) 0); Your code here
)
; problem 4

; problem 5
(define-fun f ((x Real)) Real
(ite (> (* x x) (* x (* x x))) (* x x) (* x (* x x)))
)

(define-fun max ((x Real) (y Real)) Real
  (ite (< x y) y x))

(define-fun min ((x Real) (y Real)) Real
  (ite (< x y) x y))

(define-fun Tf_lower ((l Real) (u Real)) Real
(ite (< u 0) (* u u) (ite (< l 0) 0 (max (* l l) (* l (* l l))))); Your code here
)
(define-fun Tf_upper ((l Real) (u Real)) Real
(max (* l l) (max (* u u) (* u (* u u)))); Your code here
)
; problem 5

; To state the correctness of the transformer, ask the solver if there is 
; (1) a Real number x and (2) an interval [l,u]
; that violate the soundness property, i.e., satisfy the negation of the soundness property.

(declare-const x Real)
(declare-const l Real)
(declare-const u Real)

; store complex expressions in intermediate variables
; output under the function
(declare-const fx Real)
(assert (= fx (f x)))
; lower bound of range interval
(declare-const l_Tf Real)
(assert (= l_Tf (Tf_lower l u)))
; upper bound of range interval
(declare-const u_Tf Real)
(assert (= u_Tf (Tf_upper l u)))


(assert (not                         ; negation of soundness property 
(=>  
    (and (<= l x) (<= x u))          ; if input is within given bounds
    (and (<= l_Tf fx) (<= fx u_Tf))  ; then output is within transformer bounds
)))


; This command asks the solver to check the satisfiability of your query
; If you wrote a sound transformer, the solver should say 'unsat'
(check-sat)
; If the solver returns 'sat', uncommenting the line below will give you the values of the various variables that violate the soundness property. This will help you debug your solution.
;(get-model)
