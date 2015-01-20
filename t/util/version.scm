(load "./piclib/util.scm")
(load "./piclib/util/version.scm")
(import (scheme base)
        (picrin test)
        (sulfuric util version))

(test-begin)

(test #t (version= (make-version 1 2 3) (make-version 1 2 3)))
(test #t (version= (make-version 1 2) (make-version 1 2)))
(test #t (version= (make-version 1) (make-version 1)))
(test #f (version= (make-version 1 2 3) (make-version 1 3 2)))
(test #f (version= (make-version 1 3 3) (make-version 1 2 2)))
(test #f (version= (make-version 1 2 3) (make-version 1 2 3)))

(test #f (version/= (make-version 1 2 3) (make-version 1 2 3)))
(test #f (version/= (make-version 1 2) (make-version 1 2)))
(test #f (version/= (make-version 1) (make-version 1)))
(test #t (version/= (make-version 1 2 3) (make-version 1 3 2)))
(test #t (version/= (make-version 1 3 3) (make-version 1 2 2)))
(test #t (version/= (make-version 1 2 3) (make-version 1 2 3)))


(test #t (version< (make-version 1 2 3) (make-version 1 2 4)))
(test #t (version< (make-version 1 2 3) (make-version 1 3 2)))
(test #f (version< (make-version 1 3 3) (make-version 1 2 2)))
(test #f (version< (make-version 1 2 3) (make-version 1 2 3)))
(test #f (version< (make-version 1 2) (make-version 1 2)))
(test #f (version< (make-version 1) (make-version 1)))

(test #t (version<= (make-version 1 2 3) (make-version 1 2 4)))
(test #t (version<= (make-version 1 2 3) (make-version 1 3 2)))
(test #f (version<= (make-version 1 3 3) (make-version 1 2 2)))
(test #t (version<= (make-version 1 2 3) (make-version 1 2 3)))
(test #f (version<= (make-version 1 2) (make-version 1 2)))
(test #f (version<= (make-version 1) (make-version 1)))

(test #f (version> (make-version 1 2 3) (make-version 1 2 4)))
(test #f (version> (make-version 1 2 3) (make-version 1 3 2)))
(test #t (version> (make-version 1 3 3) (make-version 1 2 2)))
(test #f (version> (make-version 1 2 3) (make-version 1 2 3)))
(test #f (version> (make-version 1 2) (make-version 1 2)))
(test #f (version> (make-version 1) (make-version 1)))

(test #f (version>= (make-version 1 2 3) (make-version 1 2 4)))
(test #f (version>= (make-version 1 2 3) (make-version 1 3 2)))
(test #t (version>= (make-version 1 3 3) (make-version 1 2 2)))
(test #t (version>= (make-version 1 2 3) (make-version 1 2 3)))
(test #t (version>= (make-version 1 2) (make-version 1 2)))
(test #t (version>= (make-version 1) (make-version 1)))


(test #t (version= (make-version 1 2 3) (string->version "1.2.3")))
(test #t (version= (make-version 1 2) (string->version "1.2")))
(test #t (version= (make-version 1) (string->version "1")))
(test "1.2.3" (version->string (string->version "1.2.3")))
(test (list 1 2 3) (version->list (string->version "1.2.3")))

