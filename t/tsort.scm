(load "./piclib/util.scm")
(load "./piclib/tsort.scm")
(import (scheme base)
        (picrin test)
        (sulfuric tsort))

(test-begin)
(test (list 4 3 2 1)
      (tsort
       '((1 2 3)
         (2 3)
         (3 4)
         (4))))

(test (list "4" "3" "2" "1")
      (tsort
       '(("1" "2" "3")
         ("2" "3")
         ("3" "4")
         ("4"))))


(test-end)
