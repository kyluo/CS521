(declare-const x Int)
(declare-const y Int)
(declare-const z Int)
(declare-const i Int)
(declare-const temp Int)

(push) ; initialize
(assert (= 1 x))
(assert (= 2 y))
(assert (= 3 z))
(assert (= 0 i))

(assert (< i 10))
(assert (<= i 10))
(assert (> i 10))
(assert (not (= x y)))
(check-sat)
(pop) ; remove the assertions
(push) ; last iteration
(assert (= 2 x))
(assert (= 3 y))
(assert (= 1 z))
(assert (= 11 i))

(assert (< i 10))
(assert (<= i 10))
(assert (> i 10))
(assert (not (= x y)))
(check-sat)
(pop) ; remove the assertions
