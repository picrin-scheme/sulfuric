(let ((n (make-nitro sample-nitro)))
  (set! (license n) "MIT")
  (set! (authors n) '("nyao" "nyan"))
  (set! (version n) "0.0.1")
  (set! (dependencies n) (list '(r7rs . "1.0.0")
                               '(other-nitro) ;version is not required
                               ))
  (set! (summary n) "A sample nitro")
  (set! (description n) "This is a sample nitro ...
...
...")
  (set! (homepage n) "http://.....")
  (set! (base-dir n) "./")
  #|
  ;; Or, if remote     ;
  (set! (fetch-from n) (git "https://github.com/picrin-scheme/swank-picrin.git")
  |#
  (set! (src n) (file-glob "/piclib/*.scm"))
  (set! (c-src n) (file-glob "/src/*.c"))
  (set! (doc n) (file-glob "/docs/*.rst"))
  (set! (test n) (file-glob "/test/*.scm"))
  (set! (extra-files n) '("/README.md" "/LICENSE"))

  (register-nitro n))
