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
(assert (= 1 x))
(assert (= 2 y))
(assert (= 3 z))
(assert (= 11 i))

(assert (< i 10))
(assert (<= i 10))
(assert (> i 10))
(assert (not (= x y)))
(check-sat)
(pop) ; remove the assertions

; I manually assign values to the variable as the body of the loop and change values accordingly for each iteration
; remove assertion that cause the program to return unsat if encounter one and keep continuing the loop
