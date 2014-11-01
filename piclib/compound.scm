(define-library (sulfuric compound)
  (import (scheme base)
          (sulfuric nitro)
          (sulfuric tsort)
          (sulfuric util))

  (define (resolve nitros)
    (tsort nitros))

  (define (scheme-sources tsorted-nitros)
    (apply append (map src tsorted-nitros)))

  (define (c-sources tsorted-nitros)
    (apply append (map c-src tsorted-nitros)))

  (define compound))
