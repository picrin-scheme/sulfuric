(import (scheme base)
        (picrin test)
        (sulfuric util))

(test-begin)

(define-record-type-with-accessors <kons>
  (kons kar kdr)
  kons?
  kar
  kdr)
(test #t (procedure? kar))
(test #t (procedure? kdr))
(test #t (procedure? set-kar!))
(test #t (procedure? set-kdr!))
(define k (kons 1 2))
(test 1 (kar k))
(test 2 (kdr k))
(set-kar! k 2)
(set-kdr! k 3)
(test 2 (kar k))
(test 3 (kdr k))

(define lst ())

(push! 1 lst)
(test (list 1) lst)
(push! 2 lst)
(test 2 (pop! lst))
(test (list 1) lst)
(test 1 (pop! lst))
(test () lst)

(test () (extract! even? lst))
(test () lst)
(set! lst (list 1))
(test () (extract! even? lst))
(test (list 1) lst)

(set! lst (list 2))
(test (list 2) (extract! even? lst))
(test () lst)

(set! lst (list 1 2 3 4 5 6 7 8 9 10))

(test (list 2 4 6 8 10) (extract! even? lst))
(test (list 1 3 5 7 9) lst)

(test 0  (position #\a "abcd"))
(test 0  (position #\a "aabcd"))
(test 1  (position #\a "aabcd" 1))
(test #f (position #\a "abcda" 1 3))


(test (list 0) (positions #\a "abcd"))
(test (list 0 1) (positions #\a "aabcd"))
(test () (positions #\a "bcd"))

(test () (positions #\a "abcd" 1))
(test (list 1) (positions #\a "aabcd" 1))
(test () (positions #\a "bcd" 1))


(test (list 0) (positions #\a "abcd" 0 1))
(test (list 0) (positions #\a "aabcd" 0 1))
(test () (positions #\a "bcd" 0 1))

(test (list "1" "2" "3") (string-split #\, "1.2.3"))
(test (list "1,2,3") (string-split #\, "1,2,3"))
(test (list "")  (string-split #\, ""))

(test-end)

