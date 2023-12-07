(declare-const x Int)
(declare-const y Int)
(declare-const z Int)
(declare-const i Int)
(declare-const temp Int)

(define-fun Funtemp ((e1 Int)) Int (+ e1 0))
(define-fun Funx ((e1 Int)) Int(+ e1 0))
(define-fun Funy ((e1 Int)) Int(+ e1 0))
(define-fun Funz ((e1 Int)) Int(+ e1 0))
(define-fun Funi ((e1 Int)) Int(+ e1 0))

(assert (and
    (= (Funx 1) x)
    (= (Funy 2) y)
    (= (Funz 3) z)
    (= (Funi 0) i)
    
    (< i 10)
    (<= i 10)
    (> i 10)
    (not (= x y))
))


(check-sat)
