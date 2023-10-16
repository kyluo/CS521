(define-fun Z1x ((e1 Real) (e2 Real)) Real
(+ 3 (+ e1 (* 2 e2)))   ; x1=3+e1+2e2
)

(define-fun Z1y ((e1 Real) (e2 Real)) Real
(+ e1 e2)   ; y1=e1+e2
)

(define-fun Z2x ((e1 Real) (e2 Real)) Real
(+ (- 1 (* 2 e1)) e2)  ;x2=1-2e1+e2
)

(define-fun Z2y ((e1 Real) (e2 Real)) Real
(+ e1 e2)   ; y1=e1+e2
)

(define-fun Z3x ((e31 Real) (e32 Real)) Real
(+ 1 (+ (* 3 e31) (* 2 e32)))   ; x3=1+3e1+2e2
)

(define-fun Z3y ((e31 Real) (e32 Real)) Real
(* 2 e32)   ; y3=e1+e2
)

(declare-const e1 Real)
(assert (and (>= e1 -1) (<= e1 1)))
(declare-const e2 Real)
(assert (and (>= e2 -1) (<= e2 1)))
(declare-const e31 Real)
(assert (and (>= e31 -1) (<= e31 1)))
(declare-const e32 Real)
(assert (and (>= e32 -1) (<= e32 1)))

(assert (forall ((x Real) (y Real))
(=> 
    (or
        (and (= x (Z1x e1 e2)) (= y (Z1y e1 e2)))
        (and (= x (Z2x e1 e2)) (= y (Z2y e1 e2)))
    )
    (and
        (= x (Z3x e31 e32)) (= y (Z3y e31 e32)))
    )
))

(check-sat)
