(load "./piclib/util.scm")
(load "./piclib/util/version.scm")
(load "./piclib/nitro.scm")

(import (scheme base)
        (picrin test)
        (sulfuric nitro))

(define-nitro sample-nitro
  (license  "MIT")
  (authors "nyao" "nyan")
  (version  "0.0.1")
  (dependencies  (r7rs "1.0.0")
                 (other-nitro) ;version is not required
                 )
  (summary  "A sample nitro")
  (description "This is a sample nitro ...
...
...")
  (homepage "http://.....")
  (base-dir "./")
  #|
  ;; Or, if remote
  (set! (fetch-from n) (git "https://github.com/picrin-scheme/swank-picrin.git")
  |#
  (src "/piclib/*.scm")
  (c-src "/src/*.c")
  (doc "/docs/*.rst")
  (test "/test/*.scm")
  (extra-files "/README.md" "/LICENSE")) 

(write nitros)
